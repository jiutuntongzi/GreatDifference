//
//  ThirdRegisterViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/2/21.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "ThirdRegisterViewController.h"
#import "MainViewController.h"

#import "StringUtils.h"
#import "LoginHttpManager.h"
#import "UserInfoResult.h"
#import "AccountUtils.h"

@interface ThirdRegisterViewController ()
@property (nonatomic, strong) UITextField       *phoneTextField;
@property (nonatomic, strong) UITextField       *validTextField;
@property (nonatomic, strong) UITextField       *inviteCodeTextField;

@property (nonatomic, strong) UIButton          *registerBtn;

@end

@implementation ThirdRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.validTextField];
    [self.view addSubview:self.inviteCodeTextField];
    
    [self.view addSubview:self.registerBtn];
    
    WS(self);
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@84);
        make.right.equalTo(weakself.view).offset(-10);
        make.height.equalTo(@40);
    }];
    
    [self.validTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.phoneTextField);
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(10);
    }];
    
    
    
    [self.inviteCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.phoneTextField);
        make.top.equalTo(self.validTextField.mas_bottom).offset(10);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.validTextField);
        make.top.equalTo(self.inviteCodeTextField.mas_bottom).offset(30);
        
    }];


    // Do any additional setup after loading the view.
}

#pragma mark -- getter
- (UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc]init];
        
        _phoneTextField.rightViewMode = UITextFieldViewModeAlways;
        
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.placeholder = @"仅支持中国大陆手机号";
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        UIButton *validBtn = [[UIButton alloc]init];
        [validBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        UIImage *bgImage = [UIImage imageNamed:@"valideCode_bg"];
        [validBtn setBackgroundImage:bgImage forState:UIControlStateNormal];
        
        //        validBtn.backgroundColor = [UIColor lightGrayColor];
        validBtn.size = CGSizeMake(80, 20);
        validBtn.titleLabel.font = XGFONT(15);
        [validBtn addTarget:self action:@selector(didClickedValidBtn:) forControlEvents:UIControlEventTouchUpInside];
        [validBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _phoneTextField.rightView = validBtn;
        
        //        [_phoneTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//        _phoneTextField.delegate = self;
    }
    return _phoneTextField;
}


- (UITextField *)validTextField{
    if (!_validTextField) {
        _validTextField = [[UITextField alloc]init];
        _validTextField.leftViewMode = UITextFieldViewModeAlways;
        _validTextField.borderStyle = UITextBorderStyleNone;
        _validTextField.placeholder = @"请输入验证码";
        _validTextField.borderStyle = UITextBorderStyleNone;
        
    }
    return _validTextField;
}


- (UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc]init];
        _registerBtn.backgroundColor = THEMECOLOR;
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _registerBtn.layer.cornerRadius = 3;
        [_registerBtn addTarget:self action:@selector(didClickedRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (UITextField *)inviteCodeTextField{
    if (!_inviteCodeTextField) {
        _inviteCodeTextField = [[UITextField alloc]init];
        _inviteCodeTextField.placeholder = @"输入邀请码(可不输入)";
        _inviteCodeTextField.borderStyle = UITextBorderStyleNone;
        
    }
    return _inviteCodeTextField;
}

- (void)didClickedValidBtn:(UIButton *)btn{

    NSString *phoneNum = self.phoneTextField.text;
    
    if ([StringUtils isEmpty:phoneNum]) {
        [HUDUtils showAlert:@"请输入手机号"];
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phoneNum              forKey:@"mob"];
    [LoginHttpManager getValidCodeWithParams:param success:^(CommonModelResult *responseObj) {
//        XGLog(@"验证码:%@",responseObj.data);
    } failure:^(id responseObj, NSError *error) {
        
    }];
}

- (void)didClickedRegisterBtn:(UIButton *)btn{

    NSString *phoneNum = self.phoneTextField.text;
    NSString *validNum = self.validTextField.text;
    
    [self.view endEditing:YES];

    if ([StringUtils isEmpty:phoneNum]) {
        [HUDUtils showAlert:@"请输入手机号码"];
        return;
    }
    if (phoneNum.length!=11 || ![phoneNum hasPrefix:@"1"]) {
        [HUDUtils showAlert:@"请输入正确的手机号码"];
        return;
    }
    
    if ([StringUtils isEmpty:validNum]) {
        [HUDUtils showAlert:@"请输入验证码"];
        return;
    }
    
    SSDKCredential *credential = self.kUser.credential;
    NSDictionary   *dict  = self.kUser.rawData;
    NSString *thirdHeadImgUrl = dict[@"headimgurl"];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:phoneNum               forKey:@"mob"];
    [params setValue:validNum               forKey:@"verifyCode"];
    [params setValue:credential.uid         forKey:@"openuid"];
    [params setValue:self.thirdType         forKey:@"thirdpart"];
    [params setValue:credential.token       forKey:@"token"];
    [params setValue:self.kUser.nickname    forKey:@"nickName"];
    [params setValue:thirdHeadImgUrl        forKey:@"headImgUrl"];
    [params setValue:self.inviteCodeTextField.text      forKey:@"invitationCode"];

    [LoginHttpManager thirdRegisterUserWithParams:params success:^(UserInfoResult *responseObj) {
        
        UserInfo *user = responseObj.data;
        [MyUserDefaults setValue:user.token forKey:Access_token];
        [MyUserDefaults setBool:YES forKey:LoginState];
        [MyUserDefaults synchronize];
        [AccountUtils save:user];
        
        UIWindow *window  = [UIApplication sharedApplication].keyWindow;
        window.rootViewController    = [MainViewController new];
        
    } failure:^(id responseObj, NSError *error) {
        
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
