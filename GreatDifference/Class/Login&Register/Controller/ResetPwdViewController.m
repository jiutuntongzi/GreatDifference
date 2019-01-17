//
//  ResetPwdViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/9.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ResetPwdViewController.h"
#import "ResetPwdView.h"
#import "LoginHttpManager.h"
#import "CommonModelResult.h"
//#import "UserInfoResult.h"
#import "StringUtils.h"

@interface ResetPwdViewController ()
@property (nonatomic, weak) ResetPwdView  *resetPwdView;
@property (nonatomic, strong) UIButton        *validBtn;

@end

@implementation ResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTapAction];
    
    ResetPwdView *resetPwdView = [[ResetPwdView alloc]init];
    self.resetPwdView = resetPwdView;
    [self.view addSubview:resetPwdView];
    self.validBtn = (UIButton *)resetPwdView.phoneTextField.rightView;

    [resetPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    resetPwdView.registerBlock = ^(RegisterModel *model){
        [self.view endEditing:YES];

        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:model.mob              forKey:@"mob"];
        [params setValue:model.verifyCode       forKey:@"verifyCode"];
        [params setValue:model.password         forKey:@"password"];
        
        [HUDUtils showLoading:@"正在修改"];
        [LoginHttpManager forgetPwdWithParams:params success:^(CommonModelResult *responseObj) {
            [HUDUtils hideHud];
            [HUDUtils showAlert:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(id responseObj, NSError *error) {
            [HUDUtils hideHud];
            NSString *message = [responseObj objectForKey:@"message"];
            [HUDUtils showAlert:message];
        }];
    };
    
    resetPwdView.getValidBlock = ^(NSString *phoneNum){
        
        if ([StringUtils isEmpty:phoneNum]) {
            [HUDUtils showAlert:@"请输入手机号"];
        }
        
        self.validBtn.userInteractionEnabled = NO;

        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:phoneNum              forKey:@"mob"];
        [LoginHttpManager getValidCodeWithParams:param success:^(CommonModelResult *responseObj) {
            [self startTime];

            XGLog(@"验证码:%@",responseObj.data);
        } failure:^(id responseObj, NSError *error) {
            self.validBtn.userInteractionEnabled = YES;
        }];
    };

    // Do any additional setup after loading the view.
}


- (void)startTime{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //                UIButton *rightBtn = (UIButton *)self.registerView.phoneNum_textField.rightView;
                [self.resetPwdView setValidCodeBtnTitle:@" 获取验证码 "];
                self.validBtn.userInteractionEnabled = YES;
                //                rightBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.validBtn setTitle:[NSString stringWithFormat:@"重新发送(%@s)",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                //                rightBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}
//


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
