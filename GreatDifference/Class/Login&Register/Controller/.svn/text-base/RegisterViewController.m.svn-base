//
//  RegisterViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 16/11/1.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "RegisterViewController.h"


#import "RegisterView.h"

#import "LoginHttpManager.h"
#import "AccountUtils.h"

#import "UserInfoResult.h"
#import "CommonModelResult.h"
#import "StringUtils.h"

@interface RegisterViewController ()
@property (nonatomic, weak) RegisterView  *registerView;
@property (nonatomic, strong) UIButton        *validBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self addTapAction];

    self.view.backgroundColor = [UIColor whiteColor];
    
    RegisterView *registerView = [[RegisterView alloc]init];
    self.registerView = registerView;
    self.validBtn = (UIButton *)registerView.phoneTextField.rightView;
    
    [self.view addSubview:registerView];
    
    [registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 三方注册
    registerView.platformView.thirdLoginBlock = ^(ThirdLoginType loginType){
        
    };
    
    // 注册

    registerView.registerBlock = ^(RegisterModel *model){
        
        [self.view endEditing:YES];

        if ([StringUtils isEmpty:model.mob]) {
            [HUDUtils showAlert:@"请输入手机号码"];
            return;
        }
        if (model.mob.length!=11 || ![model.mob hasPrefix:@"1"]) {
            [HUDUtils showAlert:@"请输入正确的手机号码"];
            return;
        }
        
        if ([StringUtils isEmpty:model.verifyCode]) {
            [HUDUtils showAlert:@"请输入验证码"];
            return;
        }
        if ([StringUtils isEmpty:model.password]) {
            [HUDUtils showAlert:@"请输入密码"];
            return;
        }
//        if (model.password.length<6||model.password.length>16) {
//            [HUDUtils showAlert:@"密码必须大于6位小于16位"];
//            return;
//        }

        [HUDUtils showLoading:@"正在注册"];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:model.mob              forKey:@"mob"];
        [params setValue:model.verifyCode       forKey:@"verifyCode"];
        [params setValue:model.password         forKey:@"password"];
        [params setValue:model.invitationCode   forKey:@"invitationCode"];

        [LoginHttpManager registerUserWithParams:params success:^(UserInfoResult *responseObj) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDUtils hideHud];
                [HUDUtils showAlert:@"注册成功"];

                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8*NSEC_PER_SEC));
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            });
//            UserInfo *user = responseObj.data;
//            [AccountUtils save:user];
            
        } failure:^(id responseObj, NSError *error) {
            
            NSString *message = [responseObj objectForKey:@"message"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDUtils hideHud];
                [HUDUtils showAlert:message];

            });
        }];
    };
    
    // 协议
    registerView.protocolBlock  = ^{
        
    };
    

    registerView.getValidBlock = ^(NSString *phoneNum){
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
            NSString *message = [responseObj objectForKey:@"message"];
            [HUDUtils showAlert:message];
            
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
                [self.registerView setValidCodeBtnTitle:@" 获取验证码 "];
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
//                UIButton *rightBtn = (UIButton *)self.registerView.phoneNum_textField.rightView;
//                
                [self.validBtn setTitle:[NSString stringWithFormat:@"重新发送(%@s)",strTime] forState:UIControlStateNormal];
//                self.validBtn.backgroundColor = THEMECOLOR;
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
