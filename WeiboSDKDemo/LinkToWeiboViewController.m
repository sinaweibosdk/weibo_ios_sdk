//
//  LinkToWeiboViewController.m
//  WeiboSDKSrcDemo
//
//  Created by jingyu11 on 2017/4/7.
//  Copyright © 2017年 SINA iOS Team. All rights reserved.
//

#import "LinkToWeiboViewController.h"

@interface LinkToWeiboViewController ()
{
    //连接到指定用户的微博个人主页
    UIButton* linkToUserButton;
    //连接到指定的单条微博详情页
    UIButton* linkToSingleBlogButton;
    //连接到指定的微博头条文章页
    UIButton* linkToArticleButton;
    //分享到微博
    UIButton* shareToWeiboButton;
    //评论指定的微博
    UIButton* commentToWeiboButton;
    //连接到微博搜索内容流
    UIButton* linkToSearchButton;
    //连接到我的微博消息流
    UIButton* linkToTimeLineButton;
    //连接到我的微博个人主页
    UIButton* linkToProfileButton;
}

@end

@implementation LinkToWeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self setupSubviews];
    [self configSubviewsFrame];
}

- (UIButton*)setupButtonbyTitle:(NSString*)title andSelector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}

- (void)setupSubviews
{
    linkToUserButton = [self setupButtonbyTitle:@"连接到指定用户的微博个人主页" andSelector:@selector(linkToUser:)];
    linkToSingleBlogButton = [self setupButtonbyTitle:@"连接到指定的单条微博详情页" andSelector:@selector(linkToSingleBlog:)];
    linkToArticleButton = [self setupButtonbyTitle:@"连接到指定的微博头条文章页" andSelector:@selector(linkToArticle:)];
    shareToWeiboButton = [self setupButtonbyTitle:@"分享到微博" andSelector:@selector(shareToWeibo:)];
    commentToWeiboButton = [self setupButtonbyTitle:@"评论指定的微博" andSelector:@selector(commentToWeibo:)];
    linkToSearchButton = [self setupButtonbyTitle:@"连接到微博搜索内容流" andSelector:@selector(linkToSearch:)];
    linkToTimeLineButton = [self setupButtonbyTitle:@"连接到我的微博消息流" andSelector:@selector(linkToTimeLine:)];
    linkToProfileButton = [self setupButtonbyTitle:@"连接到我的微博个人主页" andSelector:@selector(linkToProfile:)];
}

- (void)configSubviewsFrame
{
    linkToUserButton.frame = CGRectMake(0, 100, self.view.frame.size.width, 40);
    linkToSingleBlogButton.frame = CGRectMake(0, 140, self.view.frame.size.width, 40);
    linkToArticleButton.frame = CGRectMake(0, 180, self.view.frame.size.width, 40);
    shareToWeiboButton.frame = CGRectMake(0, 220, self.view.frame.size.width, 40);
    commentToWeiboButton.frame = CGRectMake(0, 260, self.view.frame.size.width, 40);
    linkToSearchButton.frame = CGRectMake(0, 300, self.view.frame.size.width, 40);
    linkToTimeLineButton.frame = CGRectMake(0, 340, self.view.frame.size.width, 40);
    linkToProfileButton.frame = CGRectMake(0, 380, self.view.frame.size.width, 40);
}

-(void)linkToUser:(UIButton*)sender
{
    [WeiboSDK linkToUser:@"5655398558"];
}

-(void)linkToSingleBlog:(UIButton*)sender
{
    [WeiboSDK linkToSingleBlog:@"5655398558" blogID:@"FaXBjmAPa"];
}

-(void)linkToArticle:(UIButton*)sender
{
    [WeiboSDK linkToArticle:@"2309404090697551600441"];
}

-(void)shareToWeibo:(UIButton*)sender
{
    [WeiboSDK shareToWeibo:@"SDK Share Test"];
}

-(void)commentToWeibo:(UIButton*)sender
{
    [WeiboSDK commentToWeibo:@"FaXBjmAPa"];
}

-(void)linkToSearch:(UIButton*)sender
{
    [WeiboSDK linkToSearch:@"SDK Link Search Test"];
}

-(void)linkToTimeLine:(UIButton*)sender
{
    [WeiboSDK linkToTimeLine];
}

-(void)linkToProfile:(UIButton*)sender
{
    [WeiboSDK linkToProfile];
}
@end
