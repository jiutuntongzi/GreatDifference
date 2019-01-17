//
//  OrderPriceFooterView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/2/9.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "OrderPriceFooterView.h"
#import "OrderModel.h"

@interface OrderPriceFooterView ()
@property (nonatomic, strong) UILabel         *quantityLabel;
@property (nonatomic, strong) UILabel         *priceLabel;
@end
@implementation OrderPriceFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor whiteColor];
        self.backgroundView = backView;
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.quantityLabel];
    [self.contentView addSubview:self.priceLabel];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(@10);
        make.height.mas_equalTo(20);
    }];
    
    [self.quantityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.priceLabel.mas_left).offset(-10);
        make.top.equalTo(@10);
        make.height.mas_equalTo(20);
    }];
}

- (UILabel *)quantityLabel{
    if (!_quantityLabel) {
        _quantityLabel = [[UILabel alloc]init];
        _quantityLabel.textColor = [UIColor grayColor];
        _quantityLabel.font = XGFONT(15);
    }
    return _quantityLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = [UIColor grayColor];
        _priceLabel.font = XGFONT(15);
    }
    return _priceLabel;
}

- (void)setOrderModel:(OrderModel *)orderModel{
    _orderModel = orderModel;
    self.quantityLabel.text     = [NSString stringWithFormat:@"共%@件商品", orderModel.goodsNum];
    self.priceLabel.text        = [NSString stringWithFormat:@"合计 %@元", orderModel.orderPrice];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
