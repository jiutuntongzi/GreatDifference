//
//  OrderDetailFooterView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/7.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "OrderDetailFooterView.h"

@interface OrderDetailFooterView ()
@property (nonatomic, strong) UIView         *lineView;

@property (nonatomic, strong) UILabel         *qualityLabel;
@property (nonatomic, strong) UILabel         *qualityDetailLabel;

@property (nonatomic, strong) UILabel         *totalMoneyLabel;
@property (nonatomic, strong) UILabel         *totalMoneyDetailLabel;

@end
@implementation OrderDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.lineView];
    [self addSubview:self.qualityLabel];
    [self addSubview:self.qualityDetailLabel];
    
    [self addSubview:self.totalMoneyLabel];
    [self addSubview:self.totalMoneyDetailLabel];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.qualityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(10);
        
    }];
    
    [self.qualityDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
    }];
    
    [self.totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.qualityLabel.mas_bottom).offset(5);
    }];
    
    [self.totalMoneyDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qualityLabel.mas_bottom).offset(5);
        make.right.equalTo(self).offset(-10);
    }];
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.75];
    }
    return _lineView;
}

- (UILabel *)qualityLabel{
    if (!_qualityLabel) {
        _qualityLabel = [[UILabel alloc]init];
        _qualityLabel.text = @"商品数量";
        _qualityLabel.textColor = [UIColor grayColor];
        _qualityLabel.font = XGFONT(14);

    }
    return _qualityLabel;
}

- (UILabel *)totalMoneyLabel{
    if (!_totalMoneyLabel) {
        _totalMoneyLabel = [[UILabel alloc]init];
        _totalMoneyLabel.text = @"商品总价";
        _totalMoneyLabel.textColor = [UIColor grayColor];
        _totalMoneyLabel.font = XGFONT(14);
    }
    return _totalMoneyLabel;
}

- (UILabel *)qualityDetailLabel{
    if (!_qualityDetailLabel) {
        _qualityDetailLabel = [[UILabel alloc]init];
        _qualityDetailLabel.text    = @"X6";
        _qualityDetailLabel.font = XGFONT(14);
    }
    return _qualityDetailLabel;
}

- (UILabel *)totalMoneyDetailLabel{
    if (!_totalMoneyDetailLabel) {
        _totalMoneyDetailLabel = [[UILabel alloc]init];
        _totalMoneyDetailLabel.text    = @"￥96";
        _totalMoneyDetailLabel.font = XGFONT(14);
    }
    return _totalMoneyDetailLabel;
}

- (void)setOrderModel:(OrderModel *)orderModel{
    _orderModel = orderModel;
    self.qualityDetailLabel.text = [NSString stringWithFormat:@"×%@", orderModel.goodsNum];
    self.totalMoneyDetailLabel.text = [NSString stringWithFormat:@"￥%@",orderModel.orderPrice];
}

- (void)setBigOrder:(OrderListModel *)bigOrder{
    _bigOrder = bigOrder;
    self.qualityDetailLabel.text = [NSString stringWithFormat:@"×%@", bigOrder.goodsNum];
    self.totalMoneyDetailLabel.text = [NSString stringWithFormat:@"￥%@",bigOrder.orderPrice];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
