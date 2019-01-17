//
//  ContactServiceViewController.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/11/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ContactServiceViewController.h"
#import "ContactServiceView.h"
#import "LeaveMessageRecordViewController.h"
#import "PersonalHttpManager.h"
#import "CommonModelResult.h"

@interface ContactServiceViewController ()

@end

@implementation ContactServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"联系客服";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubviews];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"留言记录" style:UIBarButtonItemStylePlain target:self action:@selector(messageRecordAction)];
    [self addTapAction];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBar.hidden = NO;
}

- (void)messageRecordAction{
    LeaveMessageRecordViewController *leaveRecord    = [[LeaveMessageRecordViewController alloc]init];
    [self.navigationController pushViewController:leaveRecord animated:YES];
}

- (void)setupSubviews{
    ContactServiceView *contactServiceView = [[ContactServiceView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH) isNavigationBarHidden:self.navigationBarHidden];
    
    [self.view addSubview:contactServiceView];

    contactServiceView.submitBlock = ^(NSString *messages){
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:messages forKey:@"content"];
        [params setValue:@"1" forKey:@"type"];
        [HUDUtils showLoading:@"正在提交"];

        [PersonalHttpManager addLeaveMessageWithParams:params success:^(CommonModelResult *responseObj) {
            if ([responseObj.state isEqualToString:@"1"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [HUDUtils hideHud];
                    [HUDUtils showAlert:@"留言成功"];
                    
                    [self.view endEditing:YES];
                });
            }
        } failure:^(id responseObj, NSError *error) {
            NSString *message = [responseObj objectForKey:@"message"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDUtils hideHud];
                [HUDUtils showAlert:message];
            });
        }];
    };
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
