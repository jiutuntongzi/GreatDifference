//
//  OrderHeaderView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/2.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "OrderHeaderView.h"

@interface OrderHeaderView ()
//@property (nonatomic, strong) UILabel         *orderStateLabel;
@end
@implementation OrderHeaderView

//- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
//    self = [super initWithReuseIdentifier:reuseIdentifier];
//    if (self) {
//        
//        [self setupSubviews];
//        self.contentView.backgroundColor = [UIColor whiteColor];
//    }
//    return self;
//    
//}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}


- (void)setupSubviews{
    [self addSubview:self.shopNameLabel];
//    [self addSubview:self.orderStateLabel];
    
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
//    [self.orderStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(-10);
//        make.top.equalTo(self.shopNameLabel);
//    }];
    
}



#pragma mark -- getter
- (UILabel *)shopNameLabel{
    if (!_shopNameLabel) {
        _shopNameLabel = [[UILabel alloc]init];
        _shopNameLabel.font = XGFONT(16);
        _shopNameLabel.text = @"订单编号: 20161206122569845";
    }
    return _shopNameLabel;
}

//- (UILabel *)orderStateLabel{
//    if (!_orderStateLabel) {
//        _orderStateLabel = [[UILabel alloc]init];
//        _orderStateLabel.textColor = THEMECOLOR;
//        _orderStateLabel.font = XGFONT(15);
//        _orderStateLabel.text = @"等待买家付款";
//    }
//    return _orderStateLabel;
//}

- (void)setOrderListModel:(OrderListModel *)orderListModel{
    _orderListModel  = orderListModel;
    self.shopNameLabel.text = [NSString stringWithFormat:@"订单编号: %@",orderListModel.bigOrderCode];
//    self.orderStateLabel.text   = [orderListModel getOrderStateName];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


@end
