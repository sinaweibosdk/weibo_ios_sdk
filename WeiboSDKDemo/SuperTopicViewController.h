//
//  SuperTopicViewController.h
//  WeiboSDKSrcDemo
//
//  Created by yungang1 on 2021/6/1.
//  Copyright © 2021 SINA iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperTopicViewController : UIViewController
@property (nonatomic, strong)void(^completionBlock)(NSString *topicName,NSString *sectionName,NSString *extra);
@end
