//
//  SendMessageToWeiboViewController.m
//  WeiboSDKDemo
//
//  Created by Wade Cheng on 3/29/13.
//  Copyright (c) 2013 SINA iOS Team. All rights reserved.
//

#import "SendMessageToWeiboViewController.h"
#import "HttpRequestDemoTableViewController.h"
#import "AppDelegate.h"

@interface SendMessageToWeiboViewController()<UIScrollViewDelegate>
{
    WBSDKRelationshipButton *relationshipButton;
    WBSDKCommentButton *commentButton;
}

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIButton *shareButton;
@property (nonatomic, retain) UISwitch *textSwitch;
@property (nonatomic, retain) UISwitch *imageSwitch;
@property (nonatomic, retain) UISwitch *mediaSwitch;

@end

@implementation SendMessageToWeiboViewController

- (void)dealloc
{
    self.textSwitch = nil;
    self.imageSwitch = nil;
    self.mediaSwitch = nil;
    self.titleLabel = nil;
    self.shareButton = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    
    
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)] autorelease];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 3;
    [scrollView addSubview:self.titleLabel];
    self.titleLabel.text = NSLocalizedString(@"微博SDK示例", nil);
    
    UILabel *loginTextLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 70, 290, 20)] autorelease];
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
    
    UILabel *shareTextLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 170, 290, 20)] autorelease];
    shareTextLabel.text = NSLocalizedString(@"分享:", nil);
    shareTextLabel.backgroundColor = [UIColor clearColor];
    shareTextLabel.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:shareTextLabel];
    
    UILabel *textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 200, 80, 30)] autorelease];
    textLabel.text = NSLocalizedString(@"文字", nil);
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    self.textSwitch = [[[UISwitch alloc] initWithFrame:CGRectMake(100, 200, 120, 30)] autorelease];
    [scrollView addSubview:textLabel];
    [scrollView addSubview:self.textSwitch];
    
    UILabel *imageLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 240, 80, 30)] autorelease];
    imageLabel.text = NSLocalizedString(@"图片", nil);
    imageLabel.backgroundColor = [UIColor clearColor];
    imageLabel.textAlignment = NSTextAlignmentCenter;
    self.imageSwitch = [[[UISwitch alloc] initWithFrame:CGRectMake(100, 240, 120, 30)] autorelease];
    [scrollView addSubview:imageLabel];
    [scrollView addSubview:self.imageSwitch];
    
    UILabel *mediaLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 280, 80, 30)] autorelease];
    mediaLabel.text = NSLocalizedString(@"多媒体", nil);
    mediaLabel.backgroundColor = [UIColor clearColor];
    mediaLabel.textAlignment = NSTextAlignmentCenter;
    self.mediaSwitch = [[[UISwitch alloc] initWithFrame:CGRectMake(100, 280, 120, 30)] autorelease];
    [scrollView addSubview:mediaLabel];
    [scrollView addSubview:self.mediaSwitch];
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.shareButton.titleLabel.numberOfLines = 2;
    self.shareButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.shareButton setTitle:NSLocalizedString(@"分享消息到微博", nil) forState:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(shareButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.shareButton.frame = CGRectMake(210, 200, 90, 110);
    [scrollView addSubview:self.shareButton];
    
    UILabel *paymentTextLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 320, 290, 20)] autorelease];
    paymentTextLabel.text = NSLocalizedString(@"支付:", nil);
    paymentTextLabel.backgroundColor = [UIColor clearColor];
    paymentTextLabel.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:paymentTextLabel];
    
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [payButton setTitle:NSLocalizedString(@"支付", nil) forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(payButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    payButton.frame = CGRectMake(20, 340, 280, 40);
    [scrollView addSubview:payButton];
    
    UILabel *httpRequestLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 390, 290, 20)] autorelease];
    httpRequestLabel.text = NSLocalizedString(@"Open API:", nil);
    httpRequestLabel.backgroundColor = [UIColor clearColor];
    httpRequestLabel.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:httpRequestLabel];
    
    UIButton *openAPIButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [openAPIButton setTitle:NSLocalizedString(@"调用OpenAPI", nil) forState:UIControlStateNormal];
    [openAPIButton addTarget:self action:@selector(requestOpenAPI) forControlEvents:UIControlEventTouchUpInside];
    openAPIButton.frame = CGRectMake(20, 410, 280, 40);
    [scrollView addSubview:openAPIButton];
    
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    relationshipButton = [[[WBSDKRelationshipButton alloc] initWithFrame:CGRectMake(20, 460, 140, 30) accessToken:myDelegate.wbtoken currentUser:myDelegate.wbCurrentUserID followUser:@"2002619624" completionHandler:^(WBSDKBasicButton *button, BOOL isSuccess, NSDictionary *resultDict) {
        
        NSString* accessToken = [resultDict objectForKey:@"access_token"];
        if (accessToken)
        {
            myDelegate.wbtoken = accessToken;
        }
        NSString* uid = [resultDict objectForKey:@"uid"];
        if (uid)
        {
            myDelegate.wbCurrentUserID = uid;
        }
        
        
    }] autorelease];
    
    [scrollView addSubview:relationshipButton];
    
    UIButton *checkRelationShipButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [checkRelationShipButton setTitle:NSLocalizedString(@"刷新关注状态", nil) forState:UIControlStateNormal];
    [checkRelationShipButton addTarget:self action:@selector(checkRelationShipButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    checkRelationShipButton.frame = CGRectMake(180, 460, 140, 30);
    [scrollView addSubview:checkRelationShipButton];
    
    
    commentButton = [[[WBSDKCommentButton alloc] initWithFrame:CGRectMake(20, 500, 140, 30) accessToken:myDelegate.wbtoken keyword:@"后会无期" urlString:@"" category:@"1001" completionHandler:^(WBSDKBasicButton *button, BOOL isSuccess, NSDictionary *resultDict) {
        
        NSString* accessToken = [resultDict objectForKey:@"access_token"];
        if (accessToken)
        {
            myDelegate.wbtoken = accessToken;
        }
        NSString* uid = [resultDict objectForKey:@"uid"];
        if (uid)
        {
            myDelegate.wbCurrentUserID = uid;
        }
        
    }] autorelease];
    [scrollView addSubview:commentButton];
    
    UIButton *checkCommentButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [checkCommentButton setTitle:NSLocalizedString(@"刷新评论按钮", nil) forState:UIControlStateNormal];
    [checkCommentButton addTarget:self action:@selector(checkCommentButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    checkCommentButton.frame = CGRectMake(180, 500, 140, 30);
    [scrollView addSubview:checkCommentButton];
    
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 540)];
    
}

- (void)shareButtonPressed
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:myDelegate.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}

- (void)ssoButtonPressed
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (void)ssoOutButtonPressed
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"user1"];
}

- (void)payButtonPressed
{
    WBOrderObject *order = [[[WBOrderObject alloc] init] autorelease];
    [order setOrderString:@"type=test"];
    
    WBPaymentRequest *request = [WBPaymentRequest requestWithOrder:order];
    [WeiboSDK sendRequest:request];
}

- (void)requestOpenAPI
{
    HttpRequestDemoTableViewController* httpRequestDemoVC = [[[HttpRequestDemoTableViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];

    [self presentViewController:httpRequestDemoVC animated:YES completion:^{
    }];
    
}

- (void)checkCommentButtonPressed
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    commentButton.accessToken = myDelegate.wbtoken;
}

- (void)checkRelationShipButtonPressed
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    relationshipButton.accessToken = myDelegate.wbtoken;
    relationshipButton.currentUserID = myDelegate.wbCurrentUserID;
    [relationshipButton checkCurrentRelationship];
}


#pragma mark -
#pragma WBHttpRequestDelegate

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = NSLocalizedString(@"收到网络回调", nil);
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",result]
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = NSLocalizedString(@"请求异常", nil);
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",error]
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
    [alert release];
}

#pragma mark - 
#pragma Internal Method

- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    if (self.textSwitch.on)
    {
        message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    }
    
    if (self.imageSwitch.on)
    {
        WBImageObject *image = [WBImageObject object];
        image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"]];
        message.imageObject = image;
    }
    
    if (self.mediaSwitch.on)
    {
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = @"identifier1";
        webpage.title = NSLocalizedString(@"分享网页标题", nil);
        webpage.description = [NSString stringWithFormat:NSLocalizedString(@"分享网页内容简介-%.0f", nil), [[NSDate date] timeIntervalSince1970]];
        webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
        webpage.webpageUrl = @"http://sina.cn?a=1";
        message.mediaObject = webpage;
    }
    
    return message;
}


@end
