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

#import <Photos/PHPhotoLibrary.h>
#import "CTAssetsPickerController.h"
static int kImageShareMaxCount = 9;
static int kVideoShareMaxCount = 1;

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


@interface SendMessageToWeiboViewController()<UIScrollViewDelegate,WBMediaTransferProtocol,CTAssetsPickerControllerDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UISwitch *textSwitch;
@property (nonatomic, strong) UILabel *imageCountLabel;
@property (nonatomic, strong) UISwitch *mediaSwitch;
@property (nonatomic, strong) UILabel *videoCountLabel;
@property (nonatomic, strong) UISwitch *weiyouSwitch;
@property (nonatomic, strong) UISwitch *superTopicSwitch;

@property (nonatomic, strong) NSString *superTopicName;
@property (nonatomic, strong) NSString *sectionName;
@property (nonatomic, strong) NSString *extra;

@property (nonatomic, strong) PHAsset *livePhotoAsset;
@property (nonatomic, strong) PHAsset *videoAsset;

@property (nonatomic, strong) NSMutableArray <PHAsset *>*imageAssetArray;

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
    self.imageCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 240, 60, 30)];
    self.imageCountLabel.font = [UIFont systemFontOfSize:13];
    self.imageCountLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:imageLabel];
    [scrollView addSubview:self.imageCountLabel];
    
    UIButton *pickerBtn = [[UIButton alloc] initWithFrame:CGRectMake(180, 240, 50, 30)];
    [pickerBtn setTitle:@"选相册" forState:UIControlStateNormal];
    [pickerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    pickerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [pickerBtn addTarget:self action:@selector(intoPicker) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:pickerBtn];
    
    UIButton *imageDeleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(250, 240, 40, 30)];
    [imageDeleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [imageDeleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    imageDeleteBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [imageDeleteBtn addTarget:self action:@selector(deleteImage) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:imageDeleteBtn];
    
    
    
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
    self.videoCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 320, 60, 30)];
    self.videoCountLabel.font = [UIFont systemFontOfSize:13];
    self.videoCountLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:videoLabel];
    [scrollView addSubview:self.videoCountLabel];
    
    UIButton *pickerBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(180, 320, 50, 30)];
    [pickerBtn1 setTitle:@"选相册" forState:UIControlStateNormal];
    [pickerBtn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    pickerBtn1.titleLabel.font = [UIFont systemFontOfSize:15];
    [pickerBtn1 addTarget:self action:@selector(intoPicker) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:pickerBtn1];
    
    UIButton *videoDeleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(250, 320, 40, 30)];
    [videoDeleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [videoDeleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    videoDeleteBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [videoDeleteBtn addTarget:self action:@selector(deleteVideo) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:videoDeleteBtn];
    
    
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
    self.shareButton.frame = CGRectMake(80, 400, 90, 50);
    [scrollView addSubview:self.shareButton];
    
    UIButton *linkWeiboButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [linkWeiboButton setTitle:NSLocalizedString(@"链接到微博API Demo", nil) forState:UIControlStateNormal];
    [linkWeiboButton addTarget:self action:@selector(linkToWeiboAPI) forControlEvents:UIControlEventTouchUpInside];
    linkWeiboButton.frame = CGRectMake(20, 460, 280, 40);
    [scrollView addSubview:linkWeiboButton];
    
    UILabel *versonLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 500, self.view.frame.size.width, 20)];
    versonLb.textAlignment = NSTextAlignmentCenter;
    versonLb.font = [UIFont systemFontOfSize:11];
    versonLb.textColor = [UIColor grayColor];
    versonLb.text = [NSString stringWithFormat:@"SDK版本-%@",[WeiboSDK getSDKVersion]];
    [scrollView addSubview:versonLb];
    
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 530)];
    
    [self updatePromptText];
    
}

- (void)updatePromptText{
    self.imageCountLabel.text = [NSString stringWithFormat:@"(0/%d)",kImageShareMaxCount];
    if(self.livePhotoAsset){
        self.imageCountLabel.text = @"live(1/1)";
    }else if(self.imageAssetArray.count){
        self.imageCountLabel.text = [NSString stringWithFormat:@"(%lu/%d)",(unsigned long)self.imageAssetArray.count,kImageShareMaxCount];
    }
    
    self.videoCountLabel.text = [NSString stringWithFormat:@"(0/%d)",kVideoShareMaxCount];
    if(self.videoAsset){
        self.videoCountLabel.text = [NSString stringWithFormat:@"(1/%d)",kVideoShareMaxCount];
    }
    
}

- (void)deleteVideo{
    self.videoAsset = nil;
    [self updatePromptText];
}

- (void)deleteImage{
    [self.imageAssetArray removeAllObjects];
    self.livePhotoAsset = nil;
    [self updatePromptText];
}

- (void)switchAction:(UISwitch *) s1 {
    if(self.superTopicSwitch == s1){
        if(s1.on){
            SuperTopicViewController *vc = [SuperTopicViewController new];
               [vc setCompletionBlock:^(NSString *topicName, NSString *sectionName, NSString *extra) {
                   self.superTopicName = topicName;
                   self.sectionName = sectionName;
                   self.extra = extra;
               }];
               [self.navigationController pushViewController:vc animated:YES];

        }else{
            self.superTopicName = nil;
            self.sectionName = nil;
            self.extra = nil;
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
    if (self.textSwitch.on)
    {
        self.messageObject.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    }
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
    BOOL isAllowShare = (([self hasImageShare] && self.mediaSwitch.on)||([self hasImageShare] && self.videoAsset)||(self.mediaSwitch.on && self.videoAsset));
    if (isAllowShare)
    {
        [self alertControllerWithTitle:@"提示" message:@"图片、多媒体、视频两两不能组合分享"  cancelBtnTitle:NSLocalizedString(@"确定", nil) sureBtnTitle:nil];
        return;
    }
    
    //未安装微博客户端，支持文字分享以及单张图片分享
    if (![WeiboSDK isCanShareInWeiboAPP] && (self.mediaSwitch.on || self.videoAsset))
    {
        [self alertControllerWithTitle:@"提示" message:@"未安装微博客户端时，仅支持文字与图片分享" cancelBtnTitle:NSLocalizedString(@"确定", nil) sureBtnTitle:nil];
        return;
    }
    
    
    
    [self.indicatorView startAnimating];
    [_indicatorView setHidesWhenStopped:YES];
    
    //未安装微博客户端，支持文字分享以及单张图片分享
    if (![WeiboSDK isCanShareInWeiboAPP] && (self.textSwitch.on || [self hasImageShare]))
    {
        [self messageToShareByWebView];
    }else if([self hasImageShare]){
        [self shareMessageToImage];
    }else if(self.videoAsset){
        [self shareMessageToVideo];
    }else if (self.mediaSwitch.on){
        [self shareMessageToMedia];
    }else if(self.superTopicSwitch.on && self.superTopicName){
        [self shareSuperTopic];
    }else if(self.textSwitch.on){
        [self shareMessageToText];
    }else{
        [self.indicatorView stopAnimating];
    }
}

- (BOOL)hasImageShare{
    if(self.livePhotoAsset || self.imageAssetArray.count){
        return YES;
    }
    return NO;
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

- (void)shareMessageToText{
    WBMessageObject *message = [WBMessageObject message];
    message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    self.messageObject = message;
    [self messageShare];
}

- (void)messageToShareByWebView
{
    WBMessageObject *message = [WBMessageObject message];
    
    if (self.textSwitch.on)
    {
        message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    }
    
    if ([self hasImageShare])
    {
        message.text = @"使用网页分享";
        WBImageObject *imageObject = [WBImageObject object];
        imageObject.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"]];
        imageObject.delegate = self;
        message.imageObject = imageObject;
    }
    self.messageObject = message;
    [self messageShare];
}

- (void)shareMessageToLivePhoto
{
    WBMessageObject *message = [WBMessageObject message];
    
    if (self.textSwitch.on)
    {
        message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    }
    
    if (self.livePhotoAsset)
    {
        WBImageObject *imageObject = [WBImageObject object];
        message.imageObject = imageObject;
        self.messageObject = message;
        [imageObject setLivePhotoAsset:self.livePhotoAsset completion:^(NSString * _Nullable error) {
            if(!error){
                [self messageShare];
            }
        }];
        
    }
    
    
}

- (void )shareMessageToMedia{
    WBMessageObject *message = [WBMessageObject message];
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"identifier1";
    webpage.title = NSLocalizedString(@"分享网页标题", nil);
    webpage.description = [NSString stringWithFormat:NSLocalizedString(@"分享网页内容简介-%.0f", nil), [[NSDate date] timeIntervalSince1970]];
    webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
    webpage.webpageUrl = @"http://weibo.com/p/1001603849727862021333?rightmod=1&wvr=6&mod=noticeboard";
    message.mediaObject = webpage;
    self.messageObject = message;
    [self messageShare];
}

- (void)shareMessageToImage{
    if(self.livePhotoAsset){
        [self shareMessageToLivePhoto];
    }else{
        WBMessageObject *message = [WBMessageObject message];
        NSMutableArray *imageArray = [NSMutableArray array];
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.synchronous = YES;
        options.networkAccessAllowed = YES;
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        for (PHAsset *asset in self.imageAssetArray) {
            [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                [imageArray addObject:result];

            }];
        }
        
        WBImageObject *imageObject = [WBImageObject object];
        imageObject.delegate = self;
        
        [imageObject addImages:imageArray];
        
        message.imageObject = imageObject;
        self.messageObject = message;
    }
}

- (void)shareMessageToVideo{
    WBMessageObject *message = [WBMessageObject message];
    WBNewVideoObject *videoObject = [WBNewVideoObject object];
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    PHImageManager *manager = [PHImageManager defaultManager];
    [manager requestAVAssetForVideo:self.videoAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        AVURLAsset *urlAsset = (AVURLAsset *)asset;
        NSString *pathExtension = [urlAsset.URL pathExtension];
        NSArray *resources = [PHAssetResource assetResourcesForAsset:self.videoAsset];
        __block PHAssetResource *videoResource = [resources firstObject];
        NSString *videoPath = [NSString stringWithFormat:@"%@.%@",[SendMessageToWeiboViewController getCreateCacheFilePath],pathExtension?:@"mov"];
        [[PHAssetResourceManager defaultManager] writeDataForAssetResource:videoResource toFile:[NSURL fileURLWithPath:videoPath] options:nil completionHandler:^(NSError * _Nullable error) {
            if(!error){
                NSURL *videoUrl = [NSURL fileURLWithPath:videoPath];
                videoObject.delegate = self;
                [videoObject addVideo:videoUrl];
                message.videoObject = videoObject;
                self.messageObject = message;
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.indicatorView stopAnimating];
                    [self alertControllerWithTitle:@"提示" message:@"获取相册视频出错，试试换其它一个视频" cancelBtnTitle:NSLocalizedString(@"确定", nil) sureBtnTitle:nil];
                });
            }
        }];
    }];
}

- (NSDictionary *)dictionaryWithJSON:(id)json {
    if (!json || json == (id)kCFNull) return nil;
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    } 
    else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
    } 
    else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    if (jsonData) {
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
    }
    return dic;
}

- (void)shareSuperTopic{
    WBMessageObject *message = [WBMessageObject message];
    WBSuperGroupObject *superGroupObject = [WBSuperGroupObject object];
    superGroupObject.superGroup = self.superTopicName;
    superGroupObject.section = self.sectionName;
    superGroupObject.extData = [self dictionaryWithJSON:self.extra];
    message.superTopicObject = superGroupObject;
    self.messageObject = message;
    [self messageShare];
}

- (void)intoPicker{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {

        if (status != PHAuthorizationStatusAuthorized) return ;

        dispatch_async(dispatch_get_main_queue(), ^{

            //弹出控制器

            CTAssetsPickerController *assetPC = [[CTAssetsPickerController alloc] init];

            //隐藏空相册

            assetPC.showsEmptyAlbums=YES;

            //显示图片索引

            assetPC.showsSelectionIndex=YES;

            //显示那些资源

            assetPC.assetCollectionSubtypes = @[@(PHAssetCollectionSubtypeSmartAlbumUserLibrary), @(PHAssetCollectionSubtypeAlbumRegular)];

            assetPC.delegate=self;

            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) //如果是运行到ipad上面

            {

                assetPC.modalPresentationStyle = UIModalPresentationFormSheet;



            }

            [self presentViewController:assetPC animated:YES completion:nil];



        });

    }];

}

#pragma mark - CTAssetsPickerControllerDelegate -

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset{
    NSInteger maxNumber = 9;
    if((self.imageAssetArray.count + picker.selectedAssets.count) > (maxNumber - 1)){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"最多选择%ld张", (long)maxNumber] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [picker presentViewController:alert animated:YES completion:nil];

           return NO;
    }
    return YES;

}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    //选择完毕关闭页面

    [picker dismissViewControllerAnimated:YES completion:nil];
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeExact;
    option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;

    //生成图片

    for(int i =0; i < assets.count; i++){

        PHAsset*asset = assets[i];
        if(asset.mediaType == PHAssetResourceTypePhoto){
            if(asset.mediaSubtypes & PHAssetMediaSubtypePhotoLive){
                self.livePhotoAsset = asset;
                break;;
            }else{
                if(self.imageAssetArray == nil){
                    self.imageAssetArray = [NSMutableArray array];
                }
                [self.imageAssetArray addObject:asset];
            }
        }else if(asset.mediaType == PHAssetResourceTypeVideo){
            self.videoAsset = asset;
            break;;
        }
        
    }
    [self updatePromptText];
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

+ (NSString *)getCreateCacheFilePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [self baseCacheShareFilePath];
    NSError *error = nil;
    if(![fileManager fileExistsAtPath:path]){
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    }
    if(!error){
        path = [path stringByAppendingPathComponent:[self cacheUUID]];
    }else{
        return nil;
    }
    return path;
}

+ (NSString *)baseCacheShareFilePath{
    //获取路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"shareDemo"];
    return path;
}

//生成唯一id
static long long nextId = 0;
+ (NSString *)cacheUUID{
    long long time_stamp_now = [[NSDate date] timeIntervalSince1970]*1000;
    nextId++;
    return [NSString stringWithFormat:@"shareFile%lld",time_stamp_now+nextId];
}

@end

