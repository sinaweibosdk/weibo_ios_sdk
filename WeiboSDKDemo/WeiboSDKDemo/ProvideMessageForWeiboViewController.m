//
//  ProvideMessageForWeiboViewController.m
//  WeiboSDKDemo
//
//  Created by Wade Cheng on 4/1/13.
//  Copyright (c) 2013 SINA iOS Team. All rights reserved.
//

#import "ProvideMessageForWeiboViewController.h"

@interface ProvideMessageForWeiboViewController ()

@property (nonatomic, retain) UISwitch *textSwitch;
@property (nonatomic, retain) UISwitch *imageSwitch;
@property (nonatomic, retain) UISwitch *mediaSwitch;

@end

@implementation ProvideMessageForWeiboViewController

@synthesize textSwitch;
@synthesize imageSwitch;
@synthesize mediaSwitch;
@synthesize titleLabel;
@synthesize shareButton;

- (void)dealloc
{
    self.textSwitch = nil;
    self.imageSwitch = nil;
    self.mediaSwitch = nil;
    self.titleLabel = nil;
    self.shareButton = nil;
    [super dealloc];
}

- (UIButton *)buttonWithTitle:(NSString *)title selector:(SEL)selector frame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    return button;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)] autorelease];
    self.titleLabel.textAlignment = UITextAlignmentCenter;
    self.titleLabel.numberOfLines = 3;
    [self.view addSubview:self.titleLabel];
    [self.titleLabel setText:@"微博给第三方应用发送提供消息的请求后，第三方应用返回消息给微博"];
    
    UILabel *textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 110, 80, 30)] autorelease];
    textLabel.text = @"文字";
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textAlignment = UITextAlignmentCenter;
    self.textSwitch = [[[UISwitch alloc] initWithFrame:CGRectMake(100, 110, 120, 30)] autorelease];
    [self.view addSubview:textLabel];
    [self.view addSubview:self.textSwitch];
    
    UILabel *imageLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 150, 80, 30)] autorelease];
    imageLabel.text = @"图片";
    imageLabel.backgroundColor = [UIColor clearColor];
    imageLabel.textAlignment = UITextAlignmentCenter;
    self.imageSwitch = [[[UISwitch alloc] initWithFrame:CGRectMake(100, 150, 120, 30)] autorelease];
    [self.view addSubview:imageLabel];
    [self.view addSubview:self.imageSwitch];
    
    UILabel *mediaLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 190, 80, 30)] autorelease];
    mediaLabel.text = @"多媒体";
    mediaLabel.backgroundColor = [UIColor clearColor];
    mediaLabel.textAlignment = UITextAlignmentCenter;
    self.mediaSwitch = [[[UISwitch alloc] initWithFrame:CGRectMake(100, 190, 120, 30)] autorelease];
    [self.view addSubview:mediaLabel];
    [self.view addSubview:self.mediaSwitch];
    
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.shareButton.titleLabel.numberOfLines = 2;
    self.shareButton.titleLabel.textAlignment = UITextAlignmentCenter;
    [self.shareButton setTitle:@"返回消息给微博" forState:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(shareButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.shareButton.frame = CGRectMake(210, 110, 90, 110);
    [self.view addSubview:self.shareButton];
}

- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    if (self.textSwitch.on)
    {
        message.text = @"测试通过WeiboSDK发送文字到微博!";
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
        webpage.title = @"分享网页标题";
        webpage.description = [NSString stringWithFormat:@"分享网页内容简介-%.0f", [[NSDate date] timeIntervalSince1970]];
        webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
        webpage.webpageUrl = @"http://sina.cn?a=1";
        message.mediaObject = webpage;
    }
    
    return message;
}

- (void)shareButtonPressed
{
    WBProvideMessageForWeiboResponse *response = [WBProvideMessageForWeiboResponse responseWithMessage:[self messageToShare]];
    
    if ([WeiboSDK sendResponse:response])
    {
        [self dismissModalViewControllerAnimated:YES];
    }
}

@end
