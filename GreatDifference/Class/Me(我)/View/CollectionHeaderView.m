//
//  MeHeaderView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "CollectionHeaderView.h"
#import "CustomButton.h"

#define KButtonWidth                        (SCREEN_WIDTH)/7
@interface CollectionHeaderView ()
@property (nonatomic, strong) UILabel         *orderLabel;
@property (nonatomic, strong) UIView          *lineView;
@property (nonatomic, strong) UIButton        *lookMoreBtn;
@property (nonatomic, strong) CustomButton        *waitPaymentBtn;
@property (nonatomic, strong) CustomButton        *waitRecieveBtn;
@property (nonatomic, strong) CustomButton        *finishedBtn;
@property (nonatomic, strong) UIView          *backView;
@end
@implementation CollectionHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.orderLabel];
    [self addSubview:self.lookMoreBtn];
    [self addSubview:self.lineView];
//    [self addSubview:self.waitPaymentBtn];
//    [self addSubview:self.waitRecieveBtn];
//    [self addSubview:self.finishedBtn];
//    [self addSubview:self.backView];
//    
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [self.lookMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.height.equalTo(self.orderLabel);
    
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
//
//    [self.waitRecieveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.lineView.mas_bottom).offset(10);
//        make.bottom.equalTo(self.backView.mas_top);
//        make.centerX.equalTo(self);
//        make.width.mas_equalTo(KButtonWidth);
//    }];
//    
//    [self.waitPaymentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.width.equalTo(self.waitRecieveBtn);
//        make.right.equalTo(self.waitRecieveBtn.mas_left).offset(-KButtonWidth);
//    }];
//    
//    [self.finishedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.width.equalTo(self.waitRecieveBtn);
//        make.left.equalTo(self.waitRecieveBtn.mas_right).offset(KButtonWidth);
//    }];
//    
//    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self);
//        make.height.mas_equalTo(15);
//    }];
//
}

- (UILabel *)orderLabel{
    if (!_orderLabel) {
        _orderLabel = [[UILabel alloc]init];
        _orderLabel.text = @"我的订单";
        _orderLabel.textColor = [UIColor lightGrayColor];
        _orderLabel.font = XGFONT(13);
    }
    return _orderLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = LineColor;
    }
    return _lineView;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.30];
        
    }
    return _backView;
}

- (UIButton *)lookMoreBtn{
    if (!_lookMoreBtn) {
        _lookMoreBtn = [[UIButton alloc]init];
        [_lookMoreBtn setTitle:@"查看全部订单>" forState:UIControlStateNormal];
        [_lookMoreBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _lookMoreBtn.titleLabel.font = XGFONT(13);
        [_lookMoreBtn addTarget:self action:@selector(lookAllOrder:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lookMoreBtn;
}

- (CustomButton *)waitPaymentBtn{
    if (!_waitPaymentBtn) {
        _waitPaymentBtn = [[CustomButton alloc]init];
        [_waitPaymentBtn setTitle:@"待付款" forState:UIControlStateNormal];
        [_waitPaymentBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_waitPaymentBtn setImage:[UIImage imageNamed:@"me_wait_pay"] forState:UIControlStateNormal];
        _waitPaymentBtn.titleLabel.font = XGFONT(13);

    }
    return _waitPaymentBtn;
}

- (CustomButton *)waitRecieveBtn{
    if (!_waitRecieveBtn) {
        _waitRecieveBtn = [[CustomButton alloc]init];
        [_waitRecieveBtn setTitle:@"待收货" forState:UIControlStateNormal];
        [_waitRecieveBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_waitRecieveBtn setImage:[UIImage imageNamed:@"me_icon_che"] forState:UIControlStateNormal];
        _waitRecieveBtn.titleLabel.font = XGFONT(13);

    }
    return _waitRecieveBtn;
}

- (CustomButton *)finishedBtn{
    if (!_finishedBtn) {
        _finishedBtn = [[CustomButton alloc]init];
        [_finishedBtn setTitle:@"已完成" forState:UIControlStateNormal];
        [_finishedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_finishedBtn setImage:[UIImage imageNamed:@"me_icon_finish"] forState:UIControlStateNormal];
        _finishedBtn.titleLabel.font = XGFONT(13);

    }
    return _finishedBtn;
}

- (void)lookAllOrder:(UIButton *)btn{
    if (self.lookAllOrdersBlock) {
        self.lookAllOrdersBlock();
    }
}
@end
