//
//  SignInCollectionFooterView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/21.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "SignInCollectionFooterView.h"

@interface SignInCollectionFooterView ()
@property (nonatomic, strong) UILabel         *titleLabel;

@property (nonatomic, strong) UILabel         *detailLabel;
@property (nonatomic, strong) UIView          *bgView;
@property (nonatomic, copy) NSString          *type;
@property (nonatomic, strong) UIButton        *saveBtn;

@end
@implementation SignInCollectionFooterView

- (instancetype)initWithFrame:(CGRect)frame footerType:(NSString *)type{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        [self setupSubviews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame footerType:@"signIn"];
}

- (void)setupSubviews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    if ([self.type isEqualToString:@"signIn"]) {
        
        [self addSubview:self.signInBtn];
        [self addSubview:self.bgView];
        
        [self.signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kSpace);
            make.top.mas_equalTo(self).offset(30);
            make.right.equalTo(@(-kSpace));
            make.height.mas_equalTo(40);
        }];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.signInBtn.mas_bottom).offset(5);
            make.left.right.equalTo(self);
            make.height.mas_equalTo(@15);
        }];
    }else{
        [self addSubview:self.saveBtn];
        [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.left.equalTo(self).offset(kSpace);
            make.top.mas_equalTo(self).offset(30);
            make.right.equalTo(@(-kSpace));
            make.height.mas_equalTo(40);
        }];
    }

    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        if ([self.type isEqualToString:@"signIn"]) {
            make.top.equalTo(self.bgView.mas_bottom).offset(10);
        }else{
            make.top.equalTo(self.saveBtn.mas_bottom).offset(10);

        }
        make.height.mas_equalTo(20);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self).offset(-kSpace);
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    
    
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"签到规则说明";
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.font = XGFONT(12);
        _detailLabel.numberOfLines = 0;
        _detailLabel.text = @"1.每日签到得1积分奖励, 连续7天即得7元奖励\n 2.积分自动发送至账户 \n 3.连续签到不足7天时，将签到奖励清零重新计算。";
    }
    return _detailLabel;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35];
    }
    return _bgView;
}

- (UIButton *)signInBtn{
    if (!_signInBtn) {
        _signInBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH - 20, 40)];
        _signInBtn.backgroundColor = THEMECOLOR;
        [_signInBtn setTitle:@"签到" forState:UIControlStateNormal];
        [_signInBtn setTitle:@"已签到" forState:UIControlStateSelected];
        
        [_signInBtn addTarget:self action:@selector(signInAction:) forControlEvents:UIControlEventTouchUpInside];
        _signInBtn.layer.cornerRadius = 5;
        [_signInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _signInBtn;
}

- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH - 20, 40)];
        _saveBtn.backgroundColor = THEMECOLOR;
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        
        [_saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.layer.cornerRadius = 5;
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _saveBtn;
}

- (void)signInAction:(UIButton *)btn{
    if (self.signInBlock) {
        self.signInBlock();
    }
}

- (void)saveAction:(UIButton *)btn{
    if (self.signInBlock) {
        self.signInBlock();
    }
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text    = title;
}

- (void)setDetail:(NSString *)detail{
    _detail = detail;
    self.detailLabel.text   = detail;
}

@end
