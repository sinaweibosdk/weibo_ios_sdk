//
//  StatisticsDemoRootViewController.m
//  WeiboSDKSrcDemo
//
//  Created by DannionQiu on 15/4/16.
//  Copyright (c) 2015年 SINA iOS Team. All rights reserved.
//

#import "StatisticsDemoRootViewController.h"
#import "WeiboSDK+Statistics.h"

@interface StatisticsDemoRootViewController ()
{
    UIButton* eventButton;
    UIButton* forceUploadRecordsButton;
}

@end

@implementation StatisticsDemoRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self setupSubviews];
    [self configSubviewsFrame];
}

- (void)setupSubviews
{
    eventButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [eventButton setTitle:@"Event" forState:UIControlStateNormal];
    [eventButton addTarget:self action:@selector(pressedEventButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eventButton];
    
    
    forceUploadRecordsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [forceUploadRecordsButton setTitle:@"forceUploadRecords" forState:UIControlStateNormal];
    [forceUploadRecordsButton addTarget:self action:@selector(pressedForceUploadRecordsButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forceUploadRecordsButton];
}

- (void)configSubviewsFrame
{
    eventButton.frame = CGRectMake(100, 200, self.view.frame.size.width - 200, 40);
    forceUploadRecordsButton.frame = CGRectMake(40, 260, self.view.frame.size.width - 80, 40);
}

- (void)pressedEventButton:(id)sender
{
    //记录事件 record event
    NSDictionary* userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"userInfo1",@"userInfoKey1",
                                                                        @"userInfo2",@"userInfoKey2", nil];
    [WeiboSDK event:@"pressedEventButton" onPageView:@"StatisticsDemoRoot" withUserInfo:userInfo];
}

- (void)pressedForceUploadRecordsButton:(id)sender
{
    //强制上传客户端本地记录 force upload all the records in client
    //正常使用时无需调用该方法，SDK会间隔一定时间自动上传。
    [WeiboSDK forceUploadRecords];
}

- (void)viewWillAppear:(BOOL)animated
{
    //记录页面 record PageView lifecycle
    [super viewWillAppear:animated];
    [WeiboSDK beginLogPageView:@"StatisticsDemoRoot"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    //记录页面 record PageView lifecycle
    [super viewWillDisappear:animated];
    [WeiboSDK endLogPageView:@"StatisticsDemoRoot"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
