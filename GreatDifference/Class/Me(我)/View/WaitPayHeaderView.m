//
//  WaitPayHeaderView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/5.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "WaitPayHeaderView.h"


@interface WaitPayHeaderView ()
@property (nonatomic, strong) UILabel         *shopNameLabel;
@property (nonatomic, strong) UILabel         *orderStateLabel;
//@property (nonatomic, strong) UILabel         *qualityLabel;

@end
@implementation WaitPayHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupSubviews];
        self.contentView.backgroundColor = [UIColor whiteColor];
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
    [self addSubview:self.shopNameLabel];
//    [self addSubview:self.qualityLabel];
    [self addSubview:self.orderStateLabel];
    
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@10);

        make.right.equalTo(self.orderStateLabel.mas_left).offset(-10);
    }];
    
    [self.orderStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.shopNameLabel);
    }];
    
//    [self.qualityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.orderStateLabel.mas_left).offset(-10);
//        make.top.equalTo(self.orderStateLabel);
//    }];
    
}



#pragma mark -- getter
//- (UILabel *)qualityLabel{
//    if (!_qualityLabel) {
//        _qualityLabel = [[UILabel alloc]init];
//        _qualityLabel.textColor = [UIColor grayColor];
//        _qualityLabel.font = XGFONT(15);
//        _qualityLabel.text = @"共2件商品";
//    }
//    return _qualityLabel;
//}

- (UILabel *)orderStateLabel{
    if (!_orderStateLabel) {
        _orderStateLabel = [[UILabel alloc]init];
        _orderStateLabel.textColor = THEMECOLOR;
        _orderStateLabel.font = XGFONT(15);
        _orderStateLabel.text   = @"合计: ￥890";
    }
    return _orderStateLabel;
}

- (UILabel *)shopNameLabel{
    if (!_shopNameLabel) {
        _shopNameLabel = [[UILabel alloc]init];
        _shopNameLabel.font = XGFONT(16);
        _shopNameLabel.text = @"XX母牛店";
    }
    return _shopNameLabel;
}

- (void)setOrderModel:(OrderModel *)orderModel{
    _orderModel = orderModel;
    self.shopNameLabel.text = orderModel.shopName;
    if ([orderModel.existsChangeProduct isEqualToString:@"1"]) {
        self.orderStateLabel.text = @"已失效订单";
        return;
    }
    self.orderStateLabel.text  = [NSString stringWithFormat:@"%@",[orderModel orderStateName]];
    if ([orderModel.orderState isEqualToString:@"1"]) {
        if ([orderModel.sellerComplete isEqualToString:@"0"]) {
            if ([orderModel.orderType isEqualToString:@"2"]) {
                self.orderStateLabel.text   = @"待收货";
            }
            return;
        }
        
        if ([orderModel.orderType isEqualToString:@"1"]) {
            self.orderStateLabel.text  = @"待取货（商家已接受订单）";
        }else{
            self.orderStateLabel.text  = @"待收货（商家已接受订单）";

        }

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
