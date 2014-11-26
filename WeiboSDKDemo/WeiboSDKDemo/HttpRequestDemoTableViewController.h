//
//  HttpRequestDemoTableViewController.h
//  WeiboSDKSrcDemo
//
//  Created by DannionQiu on 14-9-23.
//  Copyright (c) 2014年 SINA iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>

enum
{
    WeiboSDKHttpRequestDemoTypeReturn = 0,
    WeiboSDKHttpRequestDemoTypeRequestForFriendsListOfUser,
    WeiboSDKHttpRequestDemoTypeRequestForFriendsUserIDListOfUser,
    WeiboSDKHttpRequestDemoTypeRequestForCommonFriendsListBetweenTwoUser,
    WeiboSDKHttpRequestDemoTypeRequestForBilateralFriendsListOfUser,
    WeiboSDKHttpRequestDemoTypeRequestForFollowersListOfUser,
    WeiboSDKHttpRequestDemoTypeRequestForFollowersUserIDListOfUser,
    WeiboSDKHttpRequestDemoTypeRequestForActiveFollowersListOfUser,
    WeiboSDKHttpRequestDemoTypeRequestForBilateralFollowersListOfUser,
    WeiboSDKHttpRequestDemoTypeRequestForFriendshipDetailBetweenTwoUser,
    WeiboSDKHttpRequestDemoTypeRequestForFollowAUser,
    WeiboSDKHttpRequestDemoTypeRequestForCancelFollowingAUser,
    WeiboSDKHttpRequestDemoTypeRequestForRemoveFollowerUser,
    WeiboSDKHttpRequestDemoTypeRequestForInviteBilateralFriend,
    WeiboSDKHttpRequestDemoTypeRequestForUserProfile,
    WeiboSDKHttpRequestDemoTypeRequestForStatusIDs,
    WeiboSDKHttpRequestDemoTypeRequestForRepostAStatus,
    WeiboSDKHttpRequestDemoTypeRequestForPostAStatus,
    WeiboSDKHttpRequestDemoTypeRequestForPostAStatusAndPic,
    WeiboSDKHttpRequestDemoTypeRequestForPostAStatusAndPicurl,
    WeiboSDKHttpRequestDemoTypeRequestForRenewAccessToken
};
typedef NSUInteger WeiboSDKHttpRequestDemoType;


@interface HttpRequestDemoTableViewController : UITableViewController

@end
