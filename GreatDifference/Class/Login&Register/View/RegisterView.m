//
//  RegisterView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/14.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "RegisterView.h"
#import "UILabel+Add_XX.h"

@interface RegisterView ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField       *validTextField;
@property (nonatomic, strong) UIView            *lineView1;
@property (nonatomic, strong) UIView            *lineView2;
@property (nonatomic, strong) UIView            *lineView3;
@property (nonatomic, strong) UIView            *lineView4;

@property (nonatomic, strong) UITextField       *pwdTextField;
@property (nonatomic, strong) UITextField       *inviteCodeTextField;

@property (nonatomic, strong) UIButton          *registerBtn;
@property (nonatomic, strong) UILabel           *userProtocolLabel;
@end
@implementation RegisterView

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
    [self addSubview:self.lineView1];
    [self addSubview:self.validTextField];
    [self addSubview:self.lineView2];

    [self addSubview:self.pwdTextField];
    [self addSubview:self.lineView3];

    [self addSubview:self.inviteCodeTextField];
    [self addSubview:self.lineView4];

    [self addSubview:self.registerBtn];
    [self addSubview:self.userProtocolLabel];
//    [self addSubview:self.platformView];
    
    WS(self);
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@84);
        make.right.equalTo(weakself).offset(-10);
        make.height.equalTo(@35);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    [self.validTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.phoneTextField);
        make.top.equalTo(self.lineView1.mas_bottom).offset(10);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.validTextField.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.phoneTextField);
        make.top.equalTo(self.lineView2.mas_bottom).offset(10);
    }];
    
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.pwdTextField.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    [self.inviteCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.phoneTextField);
        make.top.equalTo(self.lineView3.mas_bottom).offset(10);
    }];
    
    [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.inviteCodeTextField.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.validTextField);
        make.top.equalTo(self.lineView4.mas_bottom).offset(19);
        
    }];
    
    [self.userProtocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerBtn.mas_bottom).offset(10);
        make.left.equalTo(self.registerBtn);
        make.height.mas_equalTo(20);
    }];
    
//    [self.platformView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.userProtocolLabel.mas_bottom);
//        make.left.right.bottom.equalTo(self);
//        
//    }];

}

#pragma mark -- getter
- (UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc]init];
        
        _phoneTextField.rightViewMode = UITextFieldViewModeAlways;
        
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.placeholder = @"请输入您的手机号";
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.font = XGFONT(14);
        UIButton *validBtn = [[UIButton alloc]init];
        [validBtn setTitle:@" 获取验证码 " forState:UIControlStateNormal];
//        UIImage *bgImage = [UIImage imageNamed:@"valideCode_bg"];
//        [validBtn setBackgroundImage:bgImage forState:UIControlStateNormal];
        
        validBtn.backgroundColor = THEMECOLOR;
        validBtn.layer.cornerRadius = 2;
        
        validBtn.size = CGSizeMake(95, 25);
        validBtn.titleLabel.font = XGFONT(14);
        [validBtn addTarget:self action:@selector(didClickedValidBtn:) forControlEvents:UIControlEventTouchUpInside];
        [validBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [validBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        _phoneTextField.rightView = validBtn;

//        [_phoneTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _phoneTextField.delegate = self;
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
        _validTextField.font = XGFONT(14);

    }
    return _validTextField;
}

- (UITextField *)pwdTextField{
    if (!_pwdTextField) {
        _pwdTextField = [[UITextField alloc]init];
        _pwdTextField.borderStyle = UITextBorderStyleNone;
        _pwdTextField.secureTextEntry = YES;
        _pwdTextField.placeholder = @"请输入6-16位登录密码";
        _pwdTextField.rightViewMode = UITextFieldViewModeAlways;
        _pwdTextField.font = XGFONT(14);

        UIButton *eyesBtn = [[UIButton alloc]init];
        eyesBtn.size = CGSizeMake(30, 20);
        eyesBtn.titleLabel.font = XGFONT(15);
        UIImage *image = [UIImage imageNamed:@"pwd_eyes_close"];
        UIImage *selectImage = [UIImage imageNamed:@"pwd_eyes_open"];
        [eyesBtn setImage:image forState:UIControlStateNormal];
        [eyesBtn setImage:selectImage forState:UIControlStateSelected];
        [eyesBtn addTarget:self action:@selector(eyesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [eyesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _pwdTextField.rightView = eyesBtn;
        
        _pwdTextField.rightViewMode = UITextFieldViewModeAlways;

    }
    return _pwdTextField;
}

- (UITextField *)inviteCodeTextField{
    if (!_inviteCodeTextField) {
        _inviteCodeTextField = [[UITextField alloc]init];
        _inviteCodeTextField.placeholder = @"输入邀请码(可不输入)";
        _inviteCodeTextField.borderStyle = UITextBorderStyleNone;
        _inviteCodeTextField.font = XGFONT(14);

    }
    return _inviteCodeTextField;
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

- (UIView *)lineView3{
    if (!_lineView3) {
        _lineView3 = [[UIView alloc]init];
        _lineView3.backgroundColor = HEXCOLOR(0xececec);
        
    }
    return _lineView3;
}

- (UIView *)lineView4{
    if (!_lineView4) {
        _lineView4 = [[UIView alloc]init];
        _lineView4.backgroundColor = HEXCOLOR(0xececec);
        
    }
    return _lineView4;
}

- (PlatformView *)platformView{
    if (!_platformView) {
        _platformView = [[PlatformView alloc]init];
        _platformView.backgroundColor = [UIColor whiteColor];
    }
    return _platformView;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location>=11) {
        return NO;
    }
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return YES;
    }
    return YES;
}

#pragma mark -- clickeAction
- (void)didClickedProtocol:(UITapGestureRecognizer *)tap{
    if (self.protocolBlock) {
        self.protocolBlock();
    }
}

- (void)didClickedRegisterBtn:(UIButton *)btn{
    btn.userInteractionEnabled = NO;
    RegisterModel *model    = [[RegisterModel alloc]init];
    model.mob               = self.phoneTextField.text;
    model.verifyCode        = self.validTextField.text;
    model.password          = self.pwdTextField.text;
    model.invitationCode    = self.inviteCodeTextField.text;
    if (self.registerBlock) {
        self.registerBlock(model);
    }
    btn.userInteractionEnabled = YES;

}

- (void)eyesBtnAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.pwdTextField.secureTextEntry = !btn.selected;
}

- (void)didClickedValidBtn:(UIButton *)btn{
    if (self.getValidBlock) {
        self.getValidBlock(self.phoneTextField.text);
    }
}

- (void)setValidCodeBtnTitle:(NSString *)title{
    UIButton *validBtn = (UIButton *)self.phoneTextField.rightView;
    [validBtn setTitle:title forState:UIControlStateNormal];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
