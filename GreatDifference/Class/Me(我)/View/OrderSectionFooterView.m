//
//  OrderFooterView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/2.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "OrderSectionFooterView.h"


@interface OrderSectionFooterView ()
@property (nonatomic, strong) UILabel         *qualityLabel;
@property (nonatomic, strong) UILabel         *totalMoneyLabel;
@property (nonatomic, strong) UIButton         *cancelOrderBtn;
@property (nonatomic, strong) UIButton         *payBtn;
@property (nonatomic, strong) UIButton         *refundBtn;// 退货按钮

@property (nonatomic, copy) NSString           *reuseId;
//@property (nonatomic, strong) OrderModel       *orderModel;
@end
@implementation OrderSectionFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.reuseId = reuseIdentifier;
        [self setupSubviews];
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        self.backgroundView = view;
    }
    return self;
    
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier orderModel:(OrderModel *)order{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.reuseId = reuseIdentifier;
        self.orderModel = order;
        [self setupSubviews];
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        self.backgroundView = view;
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}


- (void)setupSubviews{
    
    [self.contentView addSubview:self.qualityLabel];
    [self.contentView addSubview:self.totalMoneyLabel];
    [self addSubview:self.payBtn];
    
    [self.qualityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.totalMoneyLabel.mas_left).offset(-10);
        make.top.equalTo(@10);
        make.height.mas_equalTo(20);
    }];
    
    [self.totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.height.equalTo(self.qualityLabel);
    }];

    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.qualityLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(25);
    }];
    
    if ([self.reuseId isEqualToString:@"footerWaitReceive"]) {
        [self.payBtn setTitle:@"确认收货" forState:UIControlStateNormal];

        [self.cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        if ([self.orderModel.sellerComplete isEqualToString:@"0"]) {
            [self addSubview:self.cancelOrderBtn];
            
            
            [self.cancelOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.width.height.equalTo(self.payBtn);
                make.right.equalTo(self.payBtn.mas_left).offset(-10);
                //        make.height.mas_equalTo(30);
                
            }];
        }

    }else if ([self.reuseId isEqualToString:@"footerHadReceive"]) {
        [self.payBtn setTitle:@"评价" forState:UIControlStateNormal];
        [self.cancelOrderBtn setTitle:@"退货" forState:UIControlStateNormal];
        
        [self addSubview:self.cancelOrderBtn];
        
        
        [self.cancelOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.width.height.equalTo(self.payBtn);
            make.right.equalTo(self.payBtn.mas_left).offset(-10);
            //        make.height.mas_equalTo(30);
            
        }];
    }
    else if ([self.reuseId isEqualToString:@"footerHadReceiveCommonId"]) {
        [self.payBtn setTitle:@"评价" forState:UIControlStateNormal];
//        [self.cancelOrderBtn setTitle:@"退货" forState:UIControlStateNormal];
//        
//        [self addSubview:self.cancelOrderBtn];
        
        
//        [self.cancelOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.width.height.equalTo(self.payBtn);
//            make.right.equalTo(self.payBtn.mas_left).offset(-10);
//            //        make.height.mas_equalTo(30);
//            
//        }];
    }
    else if ([self.reuseId isEqualToString:@"footerRefund"]) {
        [self.payBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [self addSubview:self.cancelOrderBtn];
        
        
        [self.cancelOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.width.height.equalTo(self.payBtn);
            make.right.equalTo(self.payBtn.mas_left).offset(-10);
            //        make.height.mas_equalTo(30);
            
        }];
    }
    else if ([self.reuseId isEqualToString:@"footerFinish"]) {
//        [self.payBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        self.orderModel.hasEvalute = @"1";
        if ([self.orderModel.hasEvalute isEqualToString:@"1"]) {
            self.payBtn.hidden = YES;
        }else{
            self.payBtn.hidden = NO;
        }
        [self.payBtn setTitle:@"评价" forState:UIControlStateNormal];
        [self addSubview:self.cancelOrderBtn];
        
        
        [self.cancelOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.width.height.equalTo(self.payBtn);
//            CGFloat
            if ([self.orderModel.hasEvalute isEqualToString:@"1"]) {
                make.right.equalTo(self.contentView).offset(-10);
            }else{
                make.right.equalTo(self.payBtn.mas_left).offset(-10);
            }
            //        make.height.mas_equalTo(30);
            
        }];
    }


}

#pragma mark -- getter
- (UILabel *)qualityLabel{
    if (!_qualityLabel) {
        _qualityLabel = [[UILabel alloc]init];
        _qualityLabel.textColor = [UIColor grayColor];
        _qualityLabel.font = XGFONT(15);
        _qualityLabel.text = @"共2件商品";
    }
    return _qualityLabel;
}

- (UILabel *)totalMoneyLabel{
    if (!_totalMoneyLabel) {
        _totalMoneyLabel = [[UILabel alloc]init];
        _totalMoneyLabel.textColor = [UIColor grayColor];
        _totalMoneyLabel.font = XGFONT(15);
        _totalMoneyLabel.text   = @"合计: ￥890";
    }
    return _totalMoneyLabel;
}

- (UIButton *)cancelOrderBtn{
    if (!_cancelOrderBtn) {
        _cancelOrderBtn = [[UIButton alloc]init];
        _cancelOrderBtn.titleLabel.font = XGFONT(15);
        [_cancelOrderBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        [_cancelOrderBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_cancelOrderBtn addTarget:self action:@selector(cancelOrderAction:) forControlEvents:UIControlEventTouchUpInside];
        _cancelOrderBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _cancelOrderBtn.layer.borderWidth = 1;
    }
    return _cancelOrderBtn;
}

- (UIButton *)payBtn{
    if (!_payBtn) {
        _payBtn = [[UIButton alloc]init];
        _payBtn.layer.borderColor = THEMECOLOR.CGColor;
        _payBtn.layer.borderWidth = 1;
        _payBtn.titleLabel.font = XGFONT(15);

        [_payBtn setTitleColor:THEMECOLOR forState:UIControlStateNormal];
        [_payBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        [_payBtn addTarget:self action:@selector(confirmReceiveAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _payBtn;
}


- (void)cancelOrderAction:(UIButton *)btn{
    if (self.cancelOrderBlock) {
        self.cancelOrderBlock(nil);
    }
}

- (void)confirmReceiveAction:(UIButton *)btn{
    if ([[btn currentTitle]isEqualToString:@"确认收货"]) {
        if (self.confirmReceiveBlock) {
            self.confirmReceiveBlock(nil);
        }
    }
    else if ([[btn currentTitle]isEqualToString:@"评价"]){
        if (self.evaluteBlock) {
            self.evaluteBlock(nil);
        }
    }else if ([[btn currentTitle]isEqualToString:@"退货"]){
        if (self.refundBlock) {
            self.refundBlock(nil);
        }
    }

}

- (void)setOrderModel:(OrderModel *)orderModel{
    _orderModel = orderModel;
    self.qualityLabel.text  = [NSString stringWithFormat:@"共%@件商品", orderModel.goodsNum];
    self.totalMoneyLabel.text   = [NSString stringWithFormat:@"合计 %@元", orderModel.orderPrice];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
