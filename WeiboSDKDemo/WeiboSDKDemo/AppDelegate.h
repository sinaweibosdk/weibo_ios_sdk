//
//  AppDelegate.h
//  WeiboSDKDemo
//
//  Created by Wade Cheng on 3/29/13.
//  Copyright (c) 2013 SINA iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SendMessageToWeiboViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, WeiboSDKDelegate>
{
    NSString* wbtoken;
    NSString* wbCurrentUserID;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SendMessageToWeiboViewController *viewController;

@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbCurrentUserID;

@end
