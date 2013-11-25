//
//  ProvideMessageForWeiboViewController.h
//  WeiboSDKDemo
//
//  Created by Wade Cheng on 4/1/13.
//  Copyright (c) 2013 SINA iOS Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvideMessageForWeiboViewController : UIViewController

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIButton *shareButton;

- (WBMessageObject *)messageToShare;

@end
