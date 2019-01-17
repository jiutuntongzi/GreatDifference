//
//  OrderDetailBottomView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/7.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "OrderDetailBottomView.h"


@interface OrderDetailBottomView ()
@property (nonatomic, strong) UIButton         *modifyAddressBtn;

@end
@implementation OrderDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.cancelOrderBtn];
//    [self addSubview:self.modifyAddressBtn];
    [self addSubview:self.payBtn];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(70);
    }];
    
//    [self.modifyAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.width.height.equalTo(self.payBtn);
//        make.right.equalTo(self.payBtn.mas_left).offset(-10);
//    }];
    
    [self.cancelOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(self.payBtn);
        make.right.equalTo(self.payBtn.mas_left).offset(-10);
    }];
}

- (UIButton *)cancelOrderBtn{
    if (!_cancelOrderBtn) {
        _cancelOrderBtn = [[UIButton alloc]init];
        [_cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [_cancelOrderBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_cancelOrderBtn addTarget:self action:@selector(cancelOrderAction:) forControlEvents:UIControlEventTouchUpInside];
        _cancelOrderBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _cancelOrderBtn.layer.borderWidth = 1;
        _cancelOrderBtn.tag = 100;
        _cancelOrderBtn.titleLabel.font = XGFONT(15);

    }
    return _cancelOrderBtn;
}

- (UIButton *)modifyAddressBtn{
    if (!_modifyAddressBtn) {
        _modifyAddressBtn = [[UIButton alloc]init];
        [_modifyAddressBtn setTitle:@"修改地址" forState:UIControlStateNormal];
        [_modifyAddressBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_modifyAddressBtn addTarget:self action:@selector(cancelOrderAction:) forControlEvents:UIControlEventTouchUpInside];
        _modifyAddressBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _modifyAddressBtn.layer.borderWidth = 1;
        _modifyAddressBtn.titleLabel.font = XGFONT(15);
        _modifyAddressBtn.tag = 101;

    }
    return _modifyAddressBtn;
}

- (UIButton *)payBtn{
    if (!_payBtn) {
        _payBtn = [[UIButton alloc]init];
        [_payBtn setTitle:@"付款" forState:UIControlStateNormal];
        [_payBtn setTitleColor:THEMECOLOR forState:UIControlStateNormal];
        [_payBtn addTarget:self action:@selector(cancelOrderAction:) forControlEvents:UIControlEventTouchUpInside];
        _payBtn.layer.borderColor = THEMECOLOR.CGColor;
        _payBtn.layer.borderWidth = 1;
        _payBtn.titleLabel.font = XGFONT(15);
        _payBtn.tag = 102;

    }
    return _payBtn;
}

- (void)cancelOrderAction:(UIButton *)btn{
    if (self.OrderOperationBlock) {
        self.OrderOperationBlock(btn.tag);
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
