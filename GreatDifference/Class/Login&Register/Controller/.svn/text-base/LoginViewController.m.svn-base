//
//  LoginViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 16/11/1.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "LoginViewController.h"
#import "XGNavigationViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "AccountUtils.h"

#import "LoginView.h"
#import "RegisterViewController.h"
#import "ResetPwdViewController.h"

#import "LoginHttpManager.h"
#import "UserInfoResult.h"
#import "StringUtils.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import "ThirdRegisterViewController.h"
#import "H5WebViewController.h"


@interface LoginViewController ()
@property (nonatomic, weak) LoginView    *loginView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登陆";
    [self addTapAction];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(registerItem)];
    
    LoginView *loginView = [[LoginView alloc]init];
    self.loginView  = loginView;
    [self.view addSubview:loginView];
    
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self handleClickedAction];


    // Do any additional setup after loading the view.
}

- (void)registerItem{
    [self.navigationController pushViewController:[RegisterViewController new] animated:YES];
}

- (void)handleClickedAction{
    

    self.loginView.loginBlock = ^(NSString *username, NSString *password){
        [self.view endEditing:YES];

        if ([StringUtils isEmpty:username]) {
            [HUDUtils showAlert:@"请输入手机号"];
            return ;
        }
        
        if ([StringUtils isEmpty:password]) {
            [HUDUtils showAlert:@"密码"];
            return ;
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:username              forKey:@"mob"];
        [params setValue:password         forKey:@"password"];
        [HUDUtils showLoading:@"正在登录"];

        [LoginHttpManager loginWithParams:params success:^(UserInfoResult *responseObj) {
            
            [HUDUtils hideHud];

            UserInfo *user = responseObj.data;
            [MyUserDefaults setValue:user.token forKey:Access_token];
            [MyUserDefaults setBool:YES forKey:LoginState];
            [MyUserDefaults synchronize];
            [AccountUtils save:user];
            
            UIWindow *window  = [UIApplication sharedApplication].keyWindow;
            window.rootViewController    = [MainViewController new];
            
        } failure:^(id responseObj, NSError *error) {
            NSString *message = [responseObj objectForKey:@"message"];
            
            [HUDUtils hideHud];
            [HUDUtils showAlert:message];

        }];
        
    };
    
    self.loginView.protocolBlock    = ^{
        H5WebViewController *h5Vc = [[H5WebViewController alloc]init];
        h5Vc.url    = @"http://www.worldbigo.com/h5/reg.html";
        h5Vc.title = @"用户协议";
        [self.navigationController pushViewController:h5Vc animated:YES];
    };
    
    self.loginView.forgetPwdBlock    = ^{
        ResetPwdViewController *resetPwdVc = [[ResetPwdViewController alloc]init];
        [self.navigationController pushViewController:resetPwdVc animated:YES];
    };
    
    self.loginView.platformView.thirdLoginBlock = ^(ThirdLoginType loginType){
        
        if (loginType == ThirdLoginTypeQQ) {
            
            [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ
                                           onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                               
                                               //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                               //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                               associateHandler (user.uid, user, user);
                                               NSLog(@"返回的用户信息%@",user.rawData);
                                               NSLog(@"返回的授权凭证%@",user.credential);
                                               
                                           }
                                        onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                            
                                            if (state == SSDKResponseStateSuccess)
                                            {
                                                
                                            }
                                            
                                        }];
        }else if (loginType == ThirdLoginTypeeWechat){
            WS(self);
            [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat
                                           onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                               
                                               //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                               //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                               associateHandler (user.uid, user, user);
                                               NSLog(@"返回的用户信息%@",user.rawData);
                                               NSLog(@"返回的授权凭证%@",user.credential);
                                               [weakself thirdLogin:user thirdParty:loginType];
                                           }
                                        onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                            
                                            if (state == SSDKResponseStateSuccess)
                                            {
                                                
                                            }
                                            
                                        }];
            
        }else{
            
        }
//        [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat
//                                       onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
//                                           
//                                           //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
//                                           //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
//                                           associateHandler (user.uid, user, user);
//                                           NSLog(@"返回的用户信息%@",user.rawData);
//                                           NSLog(@"返回的授权凭证%@",user.credential);
//                                           
//                                       }
//                                    onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
//                                        
//                                        if (state == SSDKResponseStateSuccess)
//                                        {
//                                            
//                                        }
//                                        
//                                    }];
    };
    
}

- (void)thirdLogin:(SSDKUser *)thirdUser thirdParty:(ThirdLoginType )type{
//    NSDictionary *dict = thirdUser.rawData;
    
    SSDKCredential *credential = thirdUser.credential;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:credential.uid forKey:@"openuid"];
    [params setValue:[NSNumber numberWithInteger:type] forKey:@"thirdpart"];
    [self.view endEditing:YES];
    
//    NSString *thirdHeadImgUrl = dict[@"headImgurl"];
    [LoginHttpManager thirdLoginWithParams:params success:^(UserInfoResult *responseObj) {
        UserInfo *user = responseObj.data;
        [MyUserDefaults setValue:user.token forKey:Access_token];
        [MyUserDefaults setBool:YES forKey:LoginState];
        [MyUserDefaults synchronize];
        [AccountUtils save:user];
        
        UIWindow *window  = [UIApplication sharedApplication].keyWindow;
        window.rootViewController    = [MainViewController new];

        
    } failure:^(id responseObj, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *resultState = [responseObj objectForKey:@"state"];
            resultState = [NSString stringWithFormat:@"%@", resultState];
            XGLog(@"返回的错误码是:%@", resultState);
            if ([resultState isEqualToString:@"-1"]) {
                ThirdRegisterViewController *thirdRegisterVc = [[ThirdRegisterViewController alloc]init];
                thirdRegisterVc.kUser = thirdUser;
                thirdRegisterVc.thirdType = @"1";
                [self.navigationController pushViewController:thirdRegisterVc animated:YES];
                
            }
        });

    }];

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
