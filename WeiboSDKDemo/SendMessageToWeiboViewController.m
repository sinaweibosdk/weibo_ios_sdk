//
//  SendMessageToWeiboViewController.m
//  WeiboSDKDemo
//
//  Created by Wade Cheng on 3/29/13.
//  Copyright (c) 2013 SINA iOS Team. All rights reserved.
//

#import "SendMessageToWeiboViewController.h"
#import "LinkToWeiboViewController.h"
#import "AppDelegate.h"
#import "WeiboSDK.h"
#import "SuperTopicViewController.h"


@interface WBDataTransferObject ()
//@property (nonatomic, readonly) WeiboSDK3rdApp *app;
- (NSString *)validate;
- (void)storeToDictionary:(NSMutableDictionary *)dict;
- (void)loadFromDictionary:(NSDictionary *)dict;
+ (id)mappedObjectWithDictionary:(NSDictionary *)dict;
#ifdef WeiboSDKDebug
- (void)debugPrint;
#endif
@end


@interface SendMessageToWeiboViewController()<UIScrollViewDelegate,WBMediaTransferProtocol>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UISwitch *textSwitch;
@property (nonatomic, strong) UISwitch *imageSwitch;
@property (nonatomic, strong) UISwitch *mediaSwitch;
@property (nonatomic, strong) UISwitch *videoSwitch;
@property (nonatomic, strong) UIButton *changeVideoBtn;
@property (nonatomic, strong) UISwitch *weiyouSwitch;
@property (nonatomic, strong) UISwitch *superTopicSwitch;

@property (nonatomic, strong) NSString *superTopicName;
@property (nonatomic, strong) NSString *sectionName;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, strong) WBMessageObject *messageObject;

@end

@implementation SendMessageToWeiboViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 3;
    [scrollView addSubview:self.titleLabel];
    self.titleLabel.text = NSLocalizedString(@"微博SDK示例", nil);
    
    UILabel *loginTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, 290, 20)];
    loginTextLabel.text = NSLocalizedString(@"登录:", nil);
    loginTextLabel.backgroundColor = [UIColor clearColor];
    loginTextLabel.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:loginTextLabel];
    
    UIButton *ssoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [ssoButton setTitle:NSLocalizedString(@"请求微博认证（SSO授权）", nil) forState:UIControlStateNormal];
    [ssoButton addTarget:self action:@selector(ssoButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    ssoButton.frame = CGRectMake(20, 90, 280, 40);
    [scrollView addSubview:ssoButton];
    
    UIButton *ssoOutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [ssoOutButton setTitle:NSLocalizedString(@"登出", nil) forState:UIControlStateNormal];
    [ssoOutButton addTarget:self action:@selector(ssoOutButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    ssoOutButton.frame = CGRectMake(20, 130, 280, 40);
    [scrollView addSubview:ssoOutButton];
    
    UILabel *shareTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 170, 290, 20)];
    shareTextLabel.text = NSLocalizedString(@"分享:", nil);
    shareTextLabel.backgroundColor = [UIColor clearColor];
    shareTextLabel.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:shareTextLabel];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 80, 30)];
    textLabel.text = NSLocalizedString(@"文字", nil);
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    self.textSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(100, 200, 120, 30)];
    [scrollView addSubview:textLabel];
    [scrollView addSubview:self.textSwitch];
    
    UILabel *imageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 240, 80, 30)];
    imageLabel.text = NSLocalizedString(@"图片", nil);
    imageLabel.backgroundColor = [UIColor clearColor];
    imageLabel.textAlignment = NSTextAlignmentCenter;
    self.imageSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(100, 240, 120, 30)];
    [scrollView addSubview:imageLabel];
    [scrollView addSubview:self.imageSwitch];
    
    UILabel *mediaLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 280, 80, 30)];
    mediaLabel.text = NSLocalizedString(@"多媒体", nil);
    mediaLabel.backgroundColor = [UIColor clearColor];
    mediaLabel.textAlignment = NSTextAlignmentCenter;
    self.mediaSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(100, 280, 120, 30)];
    [scrollView addSubview:mediaLabel];
    [scrollView addSubview:self.mediaSwitch];
    
    UILabel *videoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 320, 80, 30)];
    videoLabel.text = NSLocalizedString(@"视频", nil);
    videoLabel.backgroundColor = [UIColor clearColor];
    videoLabel.textAlignment = NSTextAlignmentCenter;
    self.videoSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(100, 320, 120, 30)];
    [scrollView addSubview:videoLabel];
    [scrollView addSubview:self.videoSwitch];
    
//    self.changeVideoBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.videoSwitch.frame.origin.x+self.videoSwitch.frame.size.width+20, self.videoSwitch.frame.origin.y, 80, 30)];
//    [self.changeVideoBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    self.changeVideoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    self.changeVideoBtn.tag = 0;
//    [self.changeVideoBtn setTitle:@"10MB视频" forState:UIControlStateNormal];
//    [self.changeVideoBtn addTarget:self action:@selector(clickChangeVideo) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:self.changeVideoBtn];
    
    
    UILabel *superTopicLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 360, 80, 30)];
    superTopicLabel.text = NSLocalizedString(@"超话", nil);
    superTopicLabel.backgroundColor = [UIColor clearColor];
    superTopicLabel.textAlignment = NSTextAlignmentCenter;
    self.superTopicSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(100, 360, 120, 30)];
    [self.superTopicSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:superTopicLabel];
    [scrollView addSubview:self.superTopicSwitch];
    
    
   /* UILabel *weiyouLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 360, 120, 30)];
   weiyouLabel.text = NSLocalizedString(@"分享到私信", nil);
   weiyouLabel.backgroundColor = [UIColor clearColor];
   weiyouLabel.textAlignment = NSTextAlignmentCenter;
   self.weiyouSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(130, 360, 120, 30)];
   [scrollView addSubview:weiyouLabel];
   [scrollView addSubview:self.weiyouSwitch];*/
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.shareButton.titleLabel.numberOfLines = 2;
    self.shareButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.shareButton setTitle:NSLocalizedString(@"分享消息到微博", nil) forState:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(shareButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.shareButton.frame = CGRectMake(210, 200, 90, 50);
    [scrollView addSubview:self.shareButton];
    
    
    UIButton *checkLinkBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    checkLinkBtn.titleLabel.numberOfLines = 0;
    checkLinkBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [checkLinkBtn setTitle:NSLocalizedString(@"检查UniversalLink是否有效", nil) forState:UIControlStateNormal];
    [checkLinkBtn addTarget:self action:@selector(clickUniversalLinkBtn) forControlEvents:UIControlEventTouchUpInside];
    checkLinkBtn.frame = CGRectMake(210, 360, 90, 80);
    [scrollView addSubview:checkLinkBtn];
    
    
    UIButton *linkWeiboButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [linkWeiboButton setTitle:NSLocalizedString(@"链接到微博API Demo", nil) forState:UIControlStateNormal];
    [linkWeiboButton addTarget:self action:@selector(linkToWeiboAPI) forControlEvents:UIControlEventTouchUpInside];
    linkWeiboButton.frame = CGRectMake(20, 480, 280, 40);
    [scrollView addSubview:linkWeiboButton];
    
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 530)];
    
}


- (void)switchAction:(UISwitch *) s1 {
    if(self.superTopicSwitch == s1){
        if(s1.on){
            SuperTopicViewController *vc = [SuperTopicViewController new];
               [vc setCompletionBlock:^(NSString * _Nonnull topicName, NSString * _Nonnull sectionName) {
                   self.superTopicName = topicName;
                   self.sectionName = sectionName;
               }];
               [self.navigationController pushViewController:vc animated:YES];

        }else{
            self.superTopicName = nil;
            self.sectionName = nil;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
    
    if (_indicatorView.isAnimating) {
        [_indicatorView stopAnimating];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}

-(void)messageShare
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:_messageObject authInfo:authRequest access_token:myDelegate.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    __weak SendMessageToWeiboViewController *weak_self = self;
    [WeiboSDK sendRequest:request completion:^(BOOL success) {
        [weak_self.indicatorView stopAnimating];
    }];
}

/*- (void)shareMessageToContactPressed
{
    //TODO:
    //1、微博内部添加WBWeiyouObject对象
    //2、在WeiboSDK.m添加对WBShareMessageToContactRequest的处理
    WBMessageObject *message = [WBMessageObject message];
    WBWeiyouObject *weiyouMessage = [WBWeiyouObject object];
    weiyouMessage.title = @"加油加油";
    weiyouMessage.url = @"https://36kr.com/newsflashes/678852489543812";
//    weiyouMessage.url = @"http://tech.sina.com.cn/i/2015-11-19/doc-ifxkwuxx1517374.shtml";
    weiyouMessage.imageURL = @"http://www.5671.info/hh/image/2845890749/";
    weiyouMessage.summary = @"为我点赞";
    message.weiyouObject = weiyouMessage;
    [WBShareMessageToContactRequest requestWithMessage:message];
}*/



- (void)shareButtonPressed
{
    
//    if (self.weiyouSwitch.on)
//    {
//        [self shareMessageToContactPressed];
//        return;
//    }

    
    //图片、多媒体、视频两两不共存
    BOOL isAllowShare = ((self.imageSwitch.on && self.mediaSwitch.on)||(self.imageSwitch.on && self.videoSwitch.on)||(self.mediaSwitch.on && self.videoSwitch.on));
    if (isAllowShare)
    {
        [self alertControllerWithTitle:@"提示" message:@"图片、多媒体、视频两两不能组合分享"  cancelBtnTitle:NSLocalizedString(@"确定", nil) sureBtnTitle:nil];
        return;
    }
    
    //未安装微博客户端，支持文字分享以及单张图片分享
    if (![WeiboSDK isCanShareInWeiboAPP] && (self.mediaSwitch.on || self.videoSwitch.on))
    {
        [self alertControllerWithTitle:@"提示" message:@"未安装微博客户端时，仅支持文字与图片分享" cancelBtnTitle:NSLocalizedString(@"确定", nil) sureBtnTitle:nil];
        return;
    }
    
    
    
    [self.indicatorView startAnimating];
    [_indicatorView setHidesWhenStopped:YES];
    
    
    
    //未安装微博客户端，支持文字分享以及单张图片分享
      if (![WeiboSDK isCanShareInWeiboAPP] && (self.textSwitch.on || self.imageSwitch.on))
      {
          _messageObject = [self messageToShareByWebView];
          [self messageShare];
          return;
      }

    _messageObject = [self messageToShare];
    //注意：安装微博客户端使用多图分享逻辑，分享时在图片、视频准备好的回调方法中分享
    if (!self.imageSwitch.on && !self.videoSwitch.on) {
        [self messageShare];
    }
}

- (void)clickUniversalLinkBtn{
    [WeiboSDK checkUniversalLink:^(WBULCheckStep step, NSError *error) {
        NSLog(@"step == %ld  errorCode=%ld  errorReason=%@",(long)step,(long)error.code,error.localizedDescription);
    }];
}

/*- (void)sharePanoramic{
    WBMessageObject *message = [WBMessageObject message];
    WBImageObject *imageObject = [WBImageObject object];
    
    imageObject.panoramaImageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"timg" ofType:@"jpeg"]];;
    message.imageObject = imageObject;
    message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:myDelegate.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    __weak SendMessageToWeiboViewController *weak_self = self;
    [WeiboSDK sendRequest:request completion:^(BOOL success) {
        [weak_self.indicatorView stopAnimating];
    }];
}*/

#pragma Internal Method
- (WBMessageObject *)messageToShareByWebView
{
    WBMessageObject *message = [WBMessageObject message];
    
    if (self.textSwitch.on)
    {
        message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    }
    
    if (self.imageSwitch.on)
    {
        message.text = @"使用网页分享";
        WBImageObject *imageObject = [WBImageObject object];
        imageObject.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"]];
        imageObject.delegate = self;
        message.imageObject = imageObject;
    }
    return message;
}

- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    if (self.textSwitch.on)
    {
        message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    }
    
    if (self.imageSwitch.on)
    {
        UIImage *image = [UIImage imageNamed:@"image_1.jpg"];
        UIImage *image1 = [UIImage imageNamed:@"image_2.jpg"];
        NSArray *imageArray = [NSArray arrayWithObjects:image,image1, nil];
        
//        NSMutableArray *imageArray = [NSMutableArray array];
//        for (int i=1; i<10; i++) {
//            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"IMG_%d.jpeg",i]];
//            if(image){
//                [imageArray addObject:image];
//            }
//        }
//        UIImage *GIfImage = [UIImage imageNamed:@"testGif.gif"];
//        if(GIfImage){
//            [imageArray addObject:GIfImage];
//        }
        
        WBImageObject *imageObject = [WBImageObject object];
        imageObject.delegate = self;
        
        [imageObject addImages:imageArray];
        message.imageObject = imageObject;
    }
    
    if (self.mediaSwitch.on)
    {
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = @"identifier1";
        webpage.title = NSLocalizedString(@"分享网页标题", nil);
        webpage.description = [NSString stringWithFormat:NSLocalizedString(@"分享网页内容简介-%.0f", nil), [[NSDate date] timeIntervalSince1970]];
        webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
        webpage.webpageUrl = @"http://weibo.com/p/1001603849727862021333?rightmod=1&wvr=6&mod=noticeboard";
        message.mediaObject = webpage;
    }
    
    if (self.videoSwitch.on) {
        WBNewVideoObject *videoObject = [WBNewVideoObject object];
        NSString *videoName = @"apm";
//        if(self.changeVideoBtn.tag == 1){
//            videoName = @"20MB";
//        }else if(self.changeVideoBtn.tag == 2){
//            videoName = @"30MB";
//        }else if(self.changeVideoBtn.tag == 3){
//            videoName = @"50MB";
//        }
        NSURL *videoUrl = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:videoName ofType:@"mov"]];
        videoObject.delegate = self;
        [videoObject addVideo:videoUrl];
        message.videoObject = videoObject;
    }
    if(self.superTopicSwitch.on && self.superTopicName){
        WBSuperGroupObject *superGroupObject = [WBSuperGroupObject object];
        superGroupObject.superGroup = self.superTopicName;
        superGroupObject.section = self.sectionName;
        superGroupObject.extData = @{@"type":@"SDK 测试"};
        message.superTopicObject = superGroupObject;
    }
    
    return message;
}

- (void)clickChangeVideo{
    NSString *title = @"10MB视频";
    if(self.changeVideoBtn.tag == 0){
        self.changeVideoBtn.tag = 1;
        title = @"20MB视频";
    }else if(self.changeVideoBtn.tag == 1){
        self.changeVideoBtn.tag = 2;
        title = @"30MB视频";
    }else if(self.changeVideoBtn.tag == 2){
        self.changeVideoBtn.tag = 3;
        title = @"50MB视频";
    }else if(self.changeVideoBtn.tag == 3){
        self.changeVideoBtn.tag = 0;
        title = @"10MB视频";
    }
    [self.changeVideoBtn setTitle:title forState:UIControlStateNormal];
}


#pragma mark SSO Authorization
- (void)ssoButtonPressed
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    //下面两句测试打开ituns网页
    request.shouldShowWebViewForAuthIfCannotSSO = YES;
//    request.shouldOpenWeiboAppInstallPageIfNotInstalled = YES;
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request completion:nil];
}

- (void)ssoOutButtonPressed
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"user1"];
}


- (void)linkToWeiboAPI
{
    LinkToWeiboViewController* linkToWeiboVC = [[LinkToWeiboViewController alloc] init];
    [self.navigationController pushViewController:linkToWeiboVC animated:YES];
}


#pragma mark WBHttpRequestDelegate
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
   
    dispatch_async(dispatch_get_main_queue(), ^{
         [self alertControllerWithTitle:NSLocalizedString(@"收到网络回调", nil) message:[NSString stringWithFormat:@"%@",result] cancelBtnTitle:NSLocalizedString(@"确定", nil) sureBtnTitle:nil];
    });
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self alertControllerWithTitle:NSLocalizedString(@"请求异常", nil) message:[NSString stringWithFormat:@"%@",error] cancelBtnTitle:NSLocalizedString(@"确定", nil) sureBtnTitle:nil];
    });
}

#pragma WBMediaTransferProtocol
-(void)wbsdk_TransferDidReceiveObject:(id)object
{
    if (![NSThread isMainThread])
    {
         dispatch_async(dispatch_get_main_queue(), ^{
           
           [self messageShare];
        });
    }else{
        
        [self messageShare];
    }

}

-(void)wbsdk_TransferDidFailWithErrorCode:(WBSDKMediaTransferErrorCode)errorCode andError:(NSError*)error
{
    if (![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self errorAlertDisplayWithErrorCode:errorCode];
        });
    }else{
        
        [self errorAlertDisplayWithErrorCode:errorCode];
    }
}


-(void)errorAlertDisplayWithErrorCode:(WBSDKMediaTransferErrorCode)errorCode
{
    NSString *strTitle = nil;
    if (errorCode==WBSDKMediaTransferAlbumPermissionError) {
        strTitle =@"请打开相册权限";
    }
    if (errorCode==WBSDKMediaTransferAlbumAssetTypeError) {
        strTitle =@"资源类型错误";
    }
    if (errorCode==WBSDKMediaTransferAlbumWriteError) {
        strTitle =@"相册写入错误";
    }
    [self alertControllerWithTitle:@"错误提示" message:strTitle cancelBtnTitle:@"确定" sureBtnTitle:nil];
    
}


#pragma mark other method
-(void)alertControllerWithTitle:(NSString *)title message:(NSString*)message cancelBtnTitle:(NSString*)cancelBtnTitle sureBtnTitle:(NSString*)sureBtnTitle
{
    if (!cancelBtnTitle && !sureBtnTitle) {
           return;
       }
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (cancelBtnTitle.length > 0)
    {
        [controller addAction:[UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:nil]];
    }
    if (sureBtnTitle.length > 0)
    {
        [controller addAction:[UIAlertAction actionWithTitle:sureBtnTitle style:UIAlertActionStyleDefault handler:nil]];
    }
 
    [self presentViewController:controller animated:YES completion:nil];
}


#pragma mark Getter&&Setter
-(UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicatorView.center = self.view.center;
        [self.view addSubview:_indicatorView];
        _indicatorView.color = [UIColor blueColor];
    }
    return _indicatorView;
}

@end

