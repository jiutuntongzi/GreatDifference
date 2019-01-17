//
//  LoginView.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/11/13.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "LoginView.h"
#import "UILabel+Add_XX.h"
#import "UserInfo.h"

#define kLoginBtnWidth                          (SCREEN_WIDTH-50)/5

@interface LoginView ()

@property (nonatomic, strong) UITextField       *phoneTextField;
@property (nonatomic, strong) UITextField       *passwordTextField;

@property (nonatomic, strong) UIButton          *loginBtn;
@property (nonatomic, strong) UILabel           *userProtocolLabel;
@property (nonatomic, strong) UIButton          *forgetPwdBtn;

@property (nonatomic, strong) UILabel           *loginTypeLabel;
@property (nonatomic, strong) UIButton          *wxLoginBtn;
@property (nonatomic, strong) UIButton          *qqLoginBtn;
@property (nonatomic, strong) UIButton          *wbLoginBtn;
@property (nonatomic, strong) UIView            *lineView1;
@property (nonatomic, strong) UIView            *lineView2;
@end
@implementation LoginView

#pragma mark -- initialization
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)setupSubviews{
    [self addSubview:self.phoneTextField];
    [self addSubview:self.passwordTextField];
    [self addSubview:self.loginBtn];
    [self addSubview:self.userProtocolLabel];
    [self addSubview:self.forgetPwdBtn];
    [self addSubview:self.platformView];
    [self addSubview:self.lineView1];
    [self addSubview:self.lineView2];
    
    WS(self);
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@84);
        make.right.equalTo(weakself).offset(-10);
        make.height.equalTo(@40);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.phoneTextField);
        make.top.equalTo(self.lineView1.mas_bottom).offset(10);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.passwordTextField);
        make.top.equalTo(self.lineView2.mas_bottom).offset(20);
        
    }];
    
    [self.userProtocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginBtn.mas_left);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(5);
        make.height.mas_equalTo(25);
    }];
    
    [self.forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.loginBtn.mas_right);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
    }];
    
    [self.platformView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userProtocolLabel.mas_bottom).offset(10);
        make.left.right.bottom.equalTo(self);
        
    }];
    
}

#pragma mark -- getter

- (UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc]init];
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        UILabel *leftLabel = [[UILabel alloc]init];
        leftLabel.size = CGSizeMake(60, 20);
        leftLabel.text = @"手机号";
        leftLabel.font = XGFONT(15);
        _phoneTextField.leftView = leftLabel;
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.placeholder = @"仅支持中国大陆手机号";
        [_phoneTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _phoneTextField.font = XGFONT(14);
//        UIButton *validBtn = [[UIButton alloc]init];
//        [validBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//        validBtn.backgroundColor = [UIColor lightGrayColor];
//        validBtn.size = CGSizeMake(80, 20);
//        validBtn.titleLabel.font = XGFONT(15);
//        [validBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        _phoneTextField.rightView = validBtn;
//
//        _phoneTextField.rightViewMode = UITextFieldViewModeAlways;
//
    }
    return _phoneTextField;
}


- (UITextField *)passwordTextField{
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc]init];
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        UILabel *leftLabel = [[UILabel alloc]init];
        leftLabel.size = CGSizeMake(60, 20);
        leftLabel.text = @"密码";
        leftLabel.font = XGFONT(15);
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.leftView = leftLabel;
        _passwordTextField.font = XGFONT(14);

        _passwordTextField.borderStyle = UITextBorderStyleNone;
        _passwordTextField.placeholder = @"请输入密码";
        [_passwordTextField addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    }
    return _passwordTextField;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        _loginBtn.backgroundColor = XGCOLOR(237, 180, 84);
        _loginBtn.userInteractionEnabled = NO;
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.layer.cornerRadius = 3;
        [_loginBtn addTarget:self action:@selector(didClickedLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UILabel *)userProtocolLabel{
    if (!_userProtocolLabel) {
        _userProtocolLabel = [[UILabel alloc]init];
        _userProtocolLabel.text = @"登录即为同意《大不同用户协议》";
        _userProtocolLabel.textColor = [UIColor lightGrayColor];
        _userProtocolLabel.font = XGFONT(12);
        _userProtocolLabel.textAlignment = NSTextAlignmentLeft;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickedProtocol:)];
        _userProtocolLabel.userInteractionEnabled = YES;
        [_userProtocolLabel addGestureRecognizer:tap];
        
        NSRange range;
        range.location = 6;
        range.length = 9;
        [_userProtocolLabel setAttributes:@{NSForegroundColorAttributeName:THEMECOLOR} range:range];
    }
    return _userProtocolLabel;
}


- (UIButton *)forgetPwdBtn{
    if (!_forgetPwdBtn) {
        _forgetPwdBtn = [[UIButton alloc]init];
        [_forgetPwdBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        _forgetPwdBtn.titleLabel.font = XGFONT(12);
        [_forgetPwdBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_forgetPwdBtn addTarget:self action:@selector(didForgetPwdBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPwdBtn;
}

- (UIView *)lineView1{
    if (!_lineView1) {
        _lineView1 = [[UIView alloc]init];
        _lineView1.backgroundColor = HEXCOLOR(0xececec);
        
    }
    return _lineView1;
}

- (UIView *)lineView2{
    if (!_lineView2) {
        _lineView2 = [[UIView alloc]init];
        _lineView2.backgroundColor = HEXCOLOR(0xececec);
        
    }
    return _lineView2;
}

- (PlatformView *)platformView{
    if (!_platformView) {
        _platformView = [[PlatformView alloc]init];
        _platformView.backgroundColor = [UIColor whiteColor];
    }
    return _platformView;
}

#pragma mark -- clickedAction
- (void)didClickedLoginBtn:(UIButton *)loginBtn{
    if (self.loginBlock) {
        self.loginBlock(self.phoneTextField.text, self.passwordTextField.text);
    }
}


- (void)didClickedProtocol:(UITapGestureRecognizer *)tap{
    if (self.protocolBlock) {
        self.protocolBlock();
    }
}

- (void)phoneTextFieldDidChange:(UITextField *)textfield{
    if (textfield.text.length>0) {
        if (self.passwordTextField.text.length>0) {
            self.loginBtn.userInteractionEnabled = YES;
            self.loginBtn.backgroundColor = THEMECOLOR;
        }
    }else{
        self.loginBtn.userInteractionEnabled = NO;
        self.loginBtn.backgroundColor = XGCOLOR(237, 180, 84);
    }
}

- (void)passwordTextFieldDidChange:(UITextField *)textfield{
    
    if (textfield.text.length>0) {
        if (self.phoneTextField.text.length>0) {
            self.loginBtn.userInteractionEnabled = YES;
            self.loginBtn.backgroundColor = THEMECOLOR;
        }
    }else{
        self.loginBtn.userInteractionEnabled = NO;
        self.loginBtn.backgroundColor = XGCOLOR(237, 180, 84);
    }
}

- (void)didForgetPwdBtn:(UIButton *)btn{
    if (self.forgetPwdBlock) {
        self.forgetPwdBlock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
