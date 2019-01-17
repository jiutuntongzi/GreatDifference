//
//  PlatformView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/14.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "PlatformView.h"
#import "UILabel+Add_XX.h"

#define kLoginBtnWidth                          (SCREEN_WIDTH-50)/5

@interface PlatformView ()

@property (nonatomic, strong) UILabel           *loginTypeLabel;
@property (nonatomic, strong) UIButton          *wxLoginBtn;
@property (nonatomic, strong) UIButton          *qqLoginBtn;
@property (nonatomic, strong) UIButton          *wbLoginBtn;

@end
@implementation PlatformView
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

    [self addSubview:self.loginTypeLabel];
    [self addSubview:self.wxLoginBtn];
//    [self addSubview:self.qqLoginBtn];
//    [self addSubview:self.wbLoginBtn];
    
    [self.loginTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(40);
        make.centerX.equalTo(self);
    }];
    
    [self.wxLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginTypeLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(kLoginBtnWidth);
    }];
    
//    [self.wxLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.width.height.equalTo(self.qqLoginBtn);
//        make.right.equalTo(self.qqLoginBtn.mas_left).offset(-20);
//    }];
//
//    [self.wbLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.width.height.equalTo(self.qqLoginBtn);
//        make.left.equalTo(self.qqLoginBtn.mas_right).offset(20);
//        
//    }];

}

- (UILabel *)loginTypeLabel{
    if (!_loginTypeLabel) {
        _loginTypeLabel = [[UILabel alloc]init];
        _loginTypeLabel.text = @"其他方式登录";
        _loginTypeLabel.textColor = [UIColor lightGrayColor];
    }
    return _loginTypeLabel;
}


- (UIButton *)wxLoginBtn{
    if (!_wxLoginBtn) {
        _wxLoginBtn = [[UIButton alloc]init];
        [_wxLoginBtn setImage:[UIImage imageNamed:@"wechat_icon"] forState:UIControlStateNormal];
        _wxLoginBtn.layer.cornerRadius = kLoginBtnWidth/2;
        _wxLoginBtn.layer.masksToBounds = YES;
        [_wxLoginBtn addTarget:self action:@selector(didClickedBtn:) forControlEvents:UIControlEventTouchUpInside];
        _wxLoginBtn.tag = ThirdLoginTypeeWechat;
    }
    return _wxLoginBtn;
}

- (UIButton *)qqLoginBtn{
    if (!_qqLoginBtn) {
        _qqLoginBtn = [[UIButton alloc]init];
        [_qqLoginBtn setImage:[UIImage imageNamed:@"qq_icon"] forState:UIControlStateNormal];
        
        _qqLoginBtn.layer.cornerRadius = kLoginBtnWidth/2;
        _qqLoginBtn.layer.masksToBounds = YES;
        [_qqLoginBtn addTarget:self action:@selector(didClickedBtn:) forControlEvents:UIControlEventTouchUpInside];
        _qqLoginBtn.tag = ThirdLoginTypeQQ;
    }
    return _qqLoginBtn;
}

- (UIButton *)wbLoginBtn{
    if (!_wbLoginBtn) {
        _wbLoginBtn = [[UIButton alloc]init];
        [_wbLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_wbLoginBtn setImage:[UIImage imageNamed:@"weibo_icon"] forState:UIControlStateNormal];
        
        _wbLoginBtn.layer.cornerRadius = kLoginBtnWidth/2;
        _wbLoginBtn.layer.masksToBounds = YES;
        [_wbLoginBtn addTarget:self action:@selector(didClickedBtn:) forControlEvents:UIControlEventTouchUpInside];
        _wbLoginBtn.tag =  ThirdLoginTypeSina;
    }
    return _wbLoginBtn;
}

- (void)didClickedBtn:(UIButton *)btn{
    if (self.thirdLoginBlock) {
        self.thirdLoginBlock(btn.tag);
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
