//
//  ChangePasswordViewController.m
//  SweePea
//
//  Created by xiaodou_yxg on 16/7/2.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "ChangePasswordView.h"
#import "ChangePWDModel.h"

#import "PersonalHttpManager.h"
#import "AccountUtils.h"
#import "CommonModelResult.h"
#import "StringUtils.h"

//#import "MD5EncodeUtils.h"
//#import "CourseModelResult.h"

@interface ChangePasswordViewController ()
@property (nonatomic, strong) ChangePasswordView *changePwdView;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    ChangePasswordView *view = [[ChangePasswordView alloc]initWithFrame:self.view.bounds];
    view.SureBlock = ^(ChangePWDModel *obj){
        if ([StringUtils isEmpty:obj.currentPassword]) {
            [HUDUtils showAlert:@"请输入当前密码"];
            return ;
        }
        if (![obj.password isEqualToString:obj.passwordAgain]) {
            [HUDUtils showAlert:@"两次输入的密码不一致,请检查后重新输入"];
            return ;
        }
        //过滤数据之后再提交
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];

        [params setObject:obj.currentPassword forKey:@"oldPassword"];
        [params setObject:obj.password    forKey:@"password"];
//        [params setObject:newPwd        forKey:@"newpassword"];
        [HUDUtils showLoading:@"正在提交"];
        [PersonalHttpManager changePasswordWithParams:params success:^(CommonModelResult *responseObj) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDUtils hideHud];
                [HUDUtils showAlert:@"密码修改成功"];
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(id responseObj, NSError *error) {

            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDUtils hideHud];
                [HUDUtils showAlert:@"密码修改失败"];
            });
        }];
    };

    [self.view addSubview:view];
    // Do any additional setup after loading the view.
}

- (void)tapAction{
    [self.view endEditing:YES];
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
