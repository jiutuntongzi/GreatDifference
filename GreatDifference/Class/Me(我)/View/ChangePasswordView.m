//
//  ChangePasswordView.m
//  SweePea
//
//  Created by xiaodou_yxg on 16/7/2.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ChangePasswordView.h"
#import "ChangePWDModel.h"

@interface ChangePasswordView ()
@property (nonatomic, strong) UITextField *currentPwd_textField;
@property (nonatomic, strong) UIView      *lineView1;
@property (nonatomic, strong) UITextField *newlyPwd_textField;
@property (nonatomic, strong) UIView      *lineView2;
@property (nonatomic, strong) UITextField *againPwd_textField;

@property (nonatomic, strong) UIButton    *sureBtn;
@end
@implementation ChangePasswordView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
        self.backgroundColor = XGCOLOR(236, 236, 236);

    }
    return self;
}

- (void)setupSubviews{
    UIView *bgView = [[UIView alloc]init];
    bgView.layer.cornerRadius = 5;
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    [bgView addSubview:self.currentPwd_textField];
    [bgView addSubview:self.lineView1];
    
    [bgView addSubview:self.newlyPwd_textField];
    [bgView addSubview:self.lineView2];
    
    [bgView addSubview:self.againPwd_textField];
    [self addSubview:self.sureBtn];
    
//    __weak typeof(self) weakSelf = self;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kSpace * 2));
        make.top.equalTo(@(kSpace*8));
        make.right.equalTo(@(- kSpace * 2));
        make.height.equalTo(@150);
    }];
    
    [self.currentPwd_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(kSpace * 0.5);
        make.right.equalTo(bgView).offset(-kSpace * 0.5);
        make.top.equalTo(bgView.mas_top).offset(kSpace*0.5);
        make.height.equalTo(@40);
        
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@3);
        make.right.equalTo(@-3);
        make.top.equalTo(self.currentPwd_textField.mas_bottom).offset(5);
        make.height.equalTo(@1);
    }];
    
    [self.newlyPwd_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.currentPwd_textField);
        make.top.equalTo(self.lineView1.mas_bottom).offset(5);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@3);
        make.right.equalTo(@-3);
        make.top.equalTo(self.newlyPwd_textField.mas_bottom).offset(5);
        make.height.equalTo(@1);
    }];
    [self.againPwd_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.currentPwd_textField);
        make.top.equalTo(self.lineView2.mas_bottom).offset(5);
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgView);
        make.top.equalTo(bgView.mas_bottom).offset(30);
        make.height.equalTo(@40);
    }];
}

- (UITextField *)currentPwd_textField{
    if (!_currentPwd_textField) {
        _currentPwd_textField = [[UITextField alloc]init];
        _currentPwd_textField.placeholder = @"请输入当前密码";
        _currentPwd_textField.borderStyle = UITextBorderStyleNone;
        _currentPwd_textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _currentPwd_textField.secureTextEntry = YES;
    }
    return _currentPwd_textField;
}

- (UITextField *)newlyPwd_textField{
    if (!_newlyPwd_textField) {
        _newlyPwd_textField = [[UITextField alloc]init];
        _newlyPwd_textField.placeholder = @"请输入新密码";
        _newlyPwd_textField.borderStyle = UITextBorderStyleNone;
        _newlyPwd_textField.secureTextEntry = YES;

    }
    return _newlyPwd_textField;
}

- (UITextField *)againPwd_textField{
    if (!_againPwd_textField) {
        _againPwd_textField = [[UITextField alloc]init];
        _againPwd_textField.placeholder = @"请再次输入新密码";
        _againPwd_textField.borderStyle = UITextBorderStyleNone;
        _againPwd_textField.secureTextEntry = YES;

    }
    return _againPwd_textField;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc]init];
        [_sureBtn setBackgroundColor:THEMECOLOR];
        [_sureBtn setTitle:@"确认修改密码" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(makeChangePwd:) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.layer.cornerRadius = 5;
    }
    return _sureBtn;
}

- (UIView *)lineView1{
    
    if (!_lineView1) {
        _lineView1 = [[UIView alloc]init];
        _lineView1.backgroundColor = [UIColor lightGrayColor];
        _lineView1.alpha = 0.3;

    }
    return _lineView1;
}
- (UIView *)lineView2{
    
    if (!_lineView2) {
        _lineView2 = [[UIView alloc]init];
        _lineView2.backgroundColor = [UIColor lightGrayColor];
        _lineView2.alpha = 0.3;
    }
    return _lineView2;
}

- (void)makeChangePwd:(UIButton *)btn{
    ChangePWDModel *model = [[ChangePWDModel alloc]init];
    model.currentPassword = self.currentPwd_textField.text;
    model.password        = self.newlyPwd_textField.text;
    model.passwordAgain   = self.againPwd_textField.text;
    if (self.SureBlock) {
        self.SureBlock(model);
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
