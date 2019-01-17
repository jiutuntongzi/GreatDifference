//
//  SignInCollectionHeaderView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/21.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "SignInCollectionHeaderView.h"

@interface SignInCollectionHeaderView ()
@property (nonatomic, strong) UILabel         *jifenLabel;

@property (nonatomic, strong) UILabel         *remindLabel;
@property (nonatomic, strong) UISwitch        *remindSwitch;
@property (nonatomic, strong) UILabel         *detailLabel;
@property (nonatomic, strong) UIView          *bgView;
@end
@implementation SignInCollectionHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupSubviews{
//    [self addSubview:self.jifenLabel];
//    [self addSubview:self.detailLabel];
    [self addSubview:self.timeLabel];
//    [self addSubview:self.remindLabel];
//    [self addSubview:self.remindSwitch];
//    [self addSubview:self.bgView];
    
//    [self.jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.equalTo(@10);
//        make.height.mas_equalTo(20);
//    }];
//    
//    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.height.equalTo(self.jifenLabel);
//        make.top.equalTo(self.jifenLabel.mas_bottom);
//    }];
    
//    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.detailLabel.mas_bottom).offset(5);
//        make.left.right.equalTo(self);
//        make.height.mas_equalTo(@15);
//    }];
//    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kSpace);
        make.top.mas_equalTo(self).offset(10);
    }];
    
//    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.remindSwitch.mas_left).offset(-kSpace);
//        make.top.equalTo(self.timeLabel);
//        
//    }];
    
//    [self.remindSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.remindLabel).offset(-5);
//        make.right.equalTo(self).offset(-10);
//        make.height.mas_equalTo(30);
//        make.width.mas_equalTo(50);
//    }];
}

- (UILabel *)jifenLabel{
    if (!_jifenLabel) {
        _jifenLabel = [[UILabel alloc]init];
        _jifenLabel.text = @"当前奖励: 2积分";
    }
    return _jifenLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.font = XGFONT(12);
        _detailLabel.text = @"今日已奖励1积分, 在签五日即的7积分";
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

- (UILabel *)timeLabel{
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.text = @"2016-11-19";
        
    }
    return _timeLabel;
}

- (UILabel *)remindLabel{
    
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc]init];
        _remindLabel.textColor = [UIColor grayColor];
        _remindLabel.text = @"签到提醒";


    }
    return _remindLabel;
}

- (UISwitch *)remindSwitch{
    if (!_remindSwitch) {
        _remindSwitch = [[UISwitch alloc]init];
//        [_remindSwitch setTintColor:[UIColor redColor]];
//        _remindSwitch.backgroundColor = [UIColor yellowColor];
        [_remindSwitch addTarget:self action:@selector(remindAciton:) forControlEvents:UIControlEventValueChanged];
        [_remindSwitch setOnTintColor:THEMECOLOR];
    }
    return _remindSwitch;
}

- (void)remindAciton:(UISwitch *)remindSwitch{
    
}
@end
