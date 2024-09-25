//
//  SuperTopicViewController.m
//  WeiboSDKSrcDemo
//
//  Created by yungang1 on 2021/6/1.
//  Copyright © 2021 SINA iOS Team. All rights reserved.
//

#import "SuperTopicViewController.h"

@interface SuperTopicViewController ()
@property (nonatomic, strong)UITextField *nameTF;
@property (nonatomic, strong)UITextField *sectionTF;
@property (nonatomic, strong)UITextField *extraTF;

@end

@implementation SuperTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加超话";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.nameTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 64+20, self.view.frame.size.width-40, 40)];
    self.nameTF.placeholder = @"请输入超话名";
    [self.view addSubview:self.nameTF];
    
    self.sectionTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 64+80, self.view.frame.size.width-40, 40)];
    self.sectionTF.placeholder = @"请输入版块名（可选）";
    [self.view addSubview:self.sectionTF];
    
    self.extraTF = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.sectionTF.frame)+20, self.view.frame.size.width-40, 40)];
    self.extraTF.placeholder = @"请输入携带信息（可选）";
    [self.view addSubview:self.extraTF];
}

- (void)done {
    if (self.completionBlock) {
        self.completionBlock(self.nameTF.text, self.sectionTF.text, self.extraTF.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
