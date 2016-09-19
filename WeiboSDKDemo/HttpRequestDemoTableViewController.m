//
//  HttpRequestDemoTableViewController.m
//  WeiboSDKSrcDemo
//
//  Created by DannionQiu on 14-9-23.
//  Copyright (c) 2014年 SINA iOS Team. All rights reserved.
//

#import "HttpRequestDemoTableViewController.h"
#import "AppDelegate.h"


#define aTestUserID @"2002619624"
#define anotherTestUserID @"3320390445"
#define aTestStatusID @"3772830615208395"
#define aTestPictureUrl @"http://ww4.sinaimg.cn/mw690/775d8ce8jw8efvrnxafrjj20hs0hst9m.jpg"

@interface HttpRequestDemoTableViewController ()

@end

@implementation HttpRequestDemoTableViewController


void DemoRequestHandler(WBHttpRequest *httpRequest, id result, NSError *error)
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    if (error)
    {
        title = NSLocalizedString(@"请求异常", nil);
        alert = [[UIAlertView alloc] initWithTitle:title
                                           message:[NSString stringWithFormat:@"%@",error]
                                          delegate:nil
                                 cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                 otherButtonTitles:nil];
    }
    else
    {
        title = NSLocalizedString(@"收到网络回调", nil);
        alert = [[UIAlertView alloc] initWithTitle:title
                                           message:[NSString stringWithFormat:@"%@",result]
                                          delegate:nil
                                 cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                 otherButtonTitles:nil];
    }
    
    [alert show];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 28;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [NSString stringWithFormat:@"httpRequestDemoCell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    
    // Configure the cell...
    NSInteger row = indexPath.row;
    switch (row) {
        case WeiboSDKHttpRequestDemoTypeReturn:
            cell.textLabel.text = NSLocalizedString(@"关闭", nil);
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForFriendsListOfUser:
            cell.textLabel.text = @"friendships/friends";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForFriendsUserIDListOfUser:
            cell.textLabel.text = @"friendships/friends/ids";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForCommonFriendsListBetweenTwoUser:
            cell.textLabel.text = @"friendships/friends/in_common";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForBilateralFriendsListOfUser:
            cell.textLabel.text = @"friendships/friends/bilateral";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForFollowersListOfUser:
            cell.textLabel.text = @"friendships/followers";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForFollowersUserIDListOfUser:
            cell.textLabel.text = @"friendships/followers/ids";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForActiveFollowersListOfUser:
            cell.textLabel.text = @"friendships/followers/active";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForBilateralFollowersListOfUser:
            cell.textLabel.text = @"friendships/friends_chain/followers";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForFriendshipDetailBetweenTwoUser:
            cell.textLabel.text = @"friendships/show";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForFollowAUser:
            cell.textLabel.text = @"friendships/create";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForCancelFollowingAUser:
            cell.textLabel.text = @"friendships/destroy";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForRemoveFollowerUser:
            cell.textLabel.text = @"friendships/followers/destroy";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForInviteBilateralFriend:
            cell.textLabel.text = @"messages/invite";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForUserProfile:
            cell.textLabel.text = @"users/show";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForStatusIDs:
            cell.textLabel.text = @"statuses/user_timeline/ids.json";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForRepostAStatus:
            cell.textLabel.text = @"statuses/repost";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForPostAStatus:
            cell.textLabel.text = @"statuses/update";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForPostAStatusAndPic:
            cell.textLabel.text = @"statuses/upload";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForPostAStatusAndPicurl:
            cell.textLabel.text = @"statuses/upload_url_text";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForRenewAccessToken:
            cell.textLabel.text = @"refreshTokenTest";
            break;
        case WeiboSDKHttpRequestDemoTypeAddGameObject:
            cell.textLabel.text = @"game/object/add";
            break;
        case WeiboSDKHttpRequestDemoTypeAddGameAchievementObject:
            cell.textLabel.text = @"game/achievement/add";
            break;
        case WeiboSDKHttpRequestDemoTypeAddGameAchievementGain:
            cell.textLabel.text = @"game/achievement/gain/add";
            break;
        case WeiboSDKHttpRequestDemoTypeAddGameScoreGain:
            cell.textLabel.text = @"game/score/add";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForGameScore:
            cell.textLabel.text = @"game/score/read_player";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForFriendsGameScore:
            cell.textLabel.text = @"game/score/read_player_friends";
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForGameAchievementGain:
            cell.textLabel.text = @"game/achievement/user gain";
            break;
        default:
            cell.textLabel.text = @"";
            break;
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    
    switch (row) {
        case WeiboSDKHttpRequestDemoTypeReturn:
            [self dismissViewControllerAnimated:YES completion:^{
            }];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForFriendsListOfUser:
            [self testRequestForFriendsListOfUser];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForFriendsUserIDListOfUser:
            [self testRequestForFriendsUserIDListOfUser];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForCommonFriendsListBetweenTwoUser:
            [self testRequestForCommonFriendsListBetweenTwoUser];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForBilateralFriendsListOfUser:
            [self testRequestForBilateralFriendsListOfUser];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForFollowersListOfUser:
            [self testRequestForFollowersListOfUser];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForFollowersUserIDListOfUser:
            [self testRequestForFollowersUserIDListOfUser];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForActiveFollowersListOfUser:
            [self testRequestForActiveFollowersListOfUser];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForBilateralFollowersListOfUser:
            [self testRequestForBilateralFollowersListOfUser];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForFriendshipDetailBetweenTwoUser:
            [self testRequestForFriendshipDetailBetweenTwoUser];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForFollowAUser:
            [self testRequestForFollowAUser];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForCancelFollowingAUser:
            [self testRequestForCancelFollowingAUser];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForRemoveFollowerUser:
            [self testRequestForRemoveFollowerUser];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForInviteBilateralFriend:
            [self testRequestForInviteBilateralFriend];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForUserProfile:
            [self testRequestForUserProfile];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForRepostAStatus:
            [self testRequestForRepostAStatus];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForStatusIDs:
            [self testRequestForGetStatusIDs];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForPostAStatus:
            [self testRequestForPostAStatus];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForPostAStatusAndPic:
            [self testRequestForPostAStatusAndPic];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForPostAStatusAndPicurl:
            [self testRequestForPostAStatusAndPicurl];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForRenewAccessToken:
            [self testRequestForRenewAccessToken];
            break;
        case WeiboSDKHttpRequestDemoTypeAddGameObject:
            [self testAddGameObject];
            break;
        case WeiboSDKHttpRequestDemoTypeAddGameAchievementObject:
            [self testAddGameAchievementObject];
            break;
        case WeiboSDKHttpRequestDemoTypeAddGameAchievementGain:
            [self testAddGameAchievementGain];
            break;
        case WeiboSDKHttpRequestDemoTypeAddGameScoreGain:
            [self testAddGameScoreGain];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForGameScore:
            [self testRequestForGameScore];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForFriendsGameScore:
            [self testRequestForFriendsGameScore];
            break;
        case WeiboSDKHttpRequestDemoTypeRequestForGameAchievementGain:
            [self testRequestForGameAchievementGain];
            break;
        default:
            break;
    }
}

#pragma mark - Test Method

- (void)testRequestForFriendsListOfUser
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //just set extraPara for http request as you want, more paras description can be found on the API website,
    //for this API, details are from http://open.weibo.com/wiki/2/friendships/friends/en .
    NSMutableDictionary* extraParaDict = [NSMutableDictionary dictionary];
    [extraParaDict setObject:@"2" forKey:@"cursor"];
    [extraParaDict setObject:@"3" forKey:@"count"];
    
    [WBHttpRequest requestForFriendsListOfUser:myDelegate.wbCurrentUserID withAccessToken:myDelegate.wbtoken andOtherProperties:extraParaDict queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
    
}

- (void)testRequestForFriendsUserIDListOfUser
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForFriendsUserIDListOfUser:myDelegate.wbCurrentUserID withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForCommonFriendsListBetweenTwoUser
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForCommonFriendsListBetweenUser:myDelegate.wbCurrentUserID andUser:aTestUserID withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForBilateralFriendsListOfUser
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForBilateralFriendsListOfUser:myDelegate.wbCurrentUserID withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForFollowersListOfUser
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForFollowersListOfUser:myDelegate.wbCurrentUserID withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForFollowersUserIDListOfUser
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForFollowersUserIDListOfUser:myDelegate.wbCurrentUserID withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForActiveFollowersListOfUser
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForActiveFollowersListOfUser:myDelegate.wbCurrentUserID withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForBilateralFollowersListOfUser
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForBilateralFollowersListOfUser:myDelegate.wbCurrentUserID withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForFriendshipDetailBetweenTwoUser
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForFriendshipDetailBetweenTargetUser:aTestUserID andSourceUser:myDelegate.wbCurrentUserID withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForFollowAUser
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForFollowAUser:aTestUserID withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForCancelFollowingAUser
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForCancelFollowAUser:anotherTestUserID withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForRemoveFollowerUser
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForRemoveFollowerUser:aTestUserID withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForInviteBilateralFriend
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForInviteBilateralFriend:aTestUserID withAccessToken:myDelegate.wbtoken inviteText:@"这个好玩Test!" inviteUrl:@"http://www.weibo.com/u/2002619624" inviteLogoUrl:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForUserProfile
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForUserProfile:aTestUserID withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForGetStatusIDs
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForStatusIDsFromCurrentUser:myDelegate.wbCurrentUserID withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForRepostAStatus
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForRepostAStatus:aTestStatusID repostText:@"" withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForPostAStatus
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForShareAStatus:@"test" contatinsAPicture:nil orPictureUrl:nil withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForPostAStatusAndPic
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    WBImageObject *image = [WBImageObject object];
    image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"]];
    
    [WBHttpRequest requestForShareAStatus:@"test" contatinsAPicture:image orPictureUrl:nil withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForPostAStatusAndPicurl
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForShareAStatus:@"test" contatinsAPicture:nil orPictureUrl:aTestPictureUrl withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testRequestForRenewAccessToken
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForRenewAccessTokenWithRefreshToken:myDelegate.wbRefreshToken queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHandler(httpRequest, result, error);
        
    }];
}

- (void)testAddGameObject
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableDictionary* extraParaDict = [NSMutableDictionary dictionary];
    [extraParaDict setObject:@"646811797" forKey:@"source"];
    [extraParaDict setObject:@"2025358001:b110989100001" forKey:@"game_id"];
    [extraParaDict setObject:@"game_test" forKey:@"game_name"];
    [extraParaDict setObject:@"game_type_test" forKey:@"game_type"];
    [extraParaDict setObject:@"image_test" forKey:@"image"];
    [extraParaDict setObject:@"description_test" forKey:@"description"];
    [extraParaDict setObject:@"creator_uid_test" forKey:@"creator_uid"];
    [extraParaDict setObject:@"url_test" forKey:@"url"];
    [extraParaDict setObject:@"icon_url_test" forKey:@"icon_url"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
    
    [extraParaDict setObject:currentDateStr forKey:@"create_time"];
    
    [WBHttpRequest addGameObject:aTestUserID
                 withAccessToken:myDelegate.wbtoken
              andOtherProperties:extraParaDict
                           queue:nil
           withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
               
               DemoRequestHandler(httpRequest, result, error);
               
           }];
}

- (void)testAddGameAchievementObject
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableDictionary* extraParaDict = [NSMutableDictionary dictionary];
    [extraParaDict setObject:@"646811797" forKey:@"source"];
    [extraParaDict setObject:@"2025358001:b1109891cec84f1800013" forKey:@"achievement_id"];
    [extraParaDict setObject:@"2025358001:b110989100001" forKey:@"game_id"];
    [extraParaDict setObject:@"title_test" forKey:@"title"];
    [extraParaDict setObject:@"image_test" forKey:@"image"];
    [extraParaDict setObject:@"description_test" forKey:@"description"];
    [extraParaDict setObject:@"10" forKey:@"game_point"];
    [extraParaDict setObject:@"url_test" forKey:@"url"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
    
    [extraParaDict setObject:currentDateStr forKey:@"create_time"];
    [extraParaDict setObject:currentDateStr forKey:@"updated_time"];
    
    [WBHttpRequest addGameAchievementObject:aTestUserID
                            withAccessToken:myDelegate.wbtoken
                         andOtherProperties:extraParaDict
                                      queue:nil
                      withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
               
                          DemoRequestHandler(httpRequest, result, error);
               
                      }];
}

- (void)testAddGameAchievementGain
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableDictionary* extraParaDict = [NSMutableDictionary dictionary];
    [extraParaDict setObject:@"646811797" forKey:@"source"];
    [extraParaDict setObject:@"b1109891cec84f1800013" forKey:@"achievement_id"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
    
    [extraParaDict setObject:currentDateStr forKey:@"create_time"];
    
    [WBHttpRequest addGameAchievementGain:aTestUserID
                          withAccessToken:myDelegate.wbtoken
                       andOtherProperties:extraParaDict
                                    queue:nil
                    withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
               
                        DemoRequestHandler(httpRequest, result, error);
               
                    }];
}

- (void)testAddGameScoreGain
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableDictionary* extraParaDict = [NSMutableDictionary dictionary];
    [extraParaDict setObject:@"b110989100001" forKey:@"game_id"];
    [extraParaDict setObject:@"646811797" forKey:@"source"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
    
    [extraParaDict setObject:currentDateStr forKey:@"create_time"];
    [extraParaDict setObject:@"10" forKey:@"score"];
    
    [WBHttpRequest addGameScoreGain:aTestUserID
                    withAccessToken:myDelegate.wbtoken
                 andOtherProperties:extraParaDict
                              queue:nil
              withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
               
                  DemoRequestHandler(httpRequest, result, error);
               
              }];
}

- (void)testRequestForGameScore
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableDictionary* extraParaDict = [NSMutableDictionary dictionary];
    [extraParaDict setObject:@"b110989100001" forKey:@"game_id"];
    [extraParaDict setObject:@"646811797" forKey:@"source"];
    
    [WBHttpRequest requestForGameScore:aTestUserID
                       withAccessToken:myDelegate.wbtoken
                    andOtherProperties:extraParaDict
                                 queue:nil
                 withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
               
                     DemoRequestHandler(httpRequest, result, error);
               
                 }];
}

- (void)testRequestForFriendsGameScore
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableDictionary* extraParaDict = [NSMutableDictionary dictionary];
    [extraParaDict setObject:@"b110989100001" forKey:@"game_id"];
    [extraParaDict setObject:@"646811797" forKey:@"source"];
    
    [WBHttpRequest requestForFriendsGameScore:aTestUserID
                              withAccessToken:myDelegate.wbtoken
                           andOtherProperties:extraParaDict
                                        queue:nil
                        withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
               
                            DemoRequestHandler(httpRequest, result, error);
               
                        }];
}

- (void)testRequestForGameAchievementGain
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableDictionary* extraParaDict = [NSMutableDictionary dictionary];
    [extraParaDict setObject:@"b110989100001" forKey:@"game_id"];
    [extraParaDict setObject:@"646811797" forKey:@"source"];
    
    [WBHttpRequest requestForGameAchievementGain:aTestUserID
                                 withAccessToken:myDelegate.wbtoken
                              andOtherProperties:extraParaDict
                                           queue:nil
                           withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
               
                               DemoRequestHandler(httpRequest, result, error);
               
                           }];
}

@end
