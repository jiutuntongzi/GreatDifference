//
//  OrderDetailTopCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/7.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "OrderDetailTopCell.h"
#import "PayOrderModel.h"

@interface OrderDetailTopCell ()
@property (nonatomic, strong) UILabel         *orderNoLabel;
@property (nonatomic, strong) UILabel         *orderTimeLabel;
@property (nonatomic, strong) UILabel         *statusLabel;
@property (nonatomic, strong) UILabel         *amountLabel;
@property (nonatomic, strong) UILabel         *integralLabel;
@property (nonatomic, strong) UILabel         *rewardLabel;

@end
@implementation OrderDetailTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}


- (void)setupSubviews{
    [self.contentView addSubview:self.orderNoLabel];
    [self.contentView addSubview:self.orderTimeLabel];
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.amountLabel];
    [self.contentView addSubview:self.integralLabel];
    [self.contentView addSubview:self.rewardLabel];
    
    [self.orderNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
    }];
    
    [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderNoLabel.mas_bottom).offset(5);
        make.left.equalTo(self.orderNoLabel);
        
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
//        make.centerY.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    
}

- (UILabel *)orderNoLabel{
    if (!_orderNoLabel) {
        _orderNoLabel = [[UILabel alloc]init];
        _orderNoLabel.textColor = [UIColor grayColor];
        _orderNoLabel.font = XGFONT(15);
        _orderNoLabel.text = @"订单号: 2016120364689";
    }
    return _orderNoLabel;
}

- (UILabel *)orderTimeLabel{
    if (!_orderTimeLabel) {
        _orderTimeLabel = [[UILabel alloc]init];
        _orderTimeLabel.textColor = [UIColor grayColor];
        _orderTimeLabel.font = XGFONT(14);
        _orderTimeLabel.text = @"下单时间: 2016-12-07 13:52";

    }
    return _orderTimeLabel;
}

- (UILabel *)amountLabel{
    if (!_amountLabel) {
        _amountLabel = [[UILabel alloc]init];
        _amountLabel.textColor = [UIColor grayColor];
        _amountLabel.font = XGFONT(14);
        _amountLabel.text = @"下单时间: 2016-12-07 13:52";
        
    }
    return _amountLabel;
}

- (UILabel *)integralLabel{
    if (!_integralLabel) {
        _integralLabel = [[UILabel alloc]init];
        _integralLabel.textColor = [UIColor grayColor];
        _integralLabel.font = XGFONT(14);
        _integralLabel.text = @"下单时间: 2016-12-07 13:52";
        
    }
    return _integralLabel;
}

- (UILabel *)rewardLabel{
    if (!_rewardLabel) {
        _rewardLabel = [[UILabel alloc]init];
        _rewardLabel.textColor = [UIColor grayColor];
        _rewardLabel.font = XGFONT(14);
        _rewardLabel.text = @"下单时间: 2016-12-07 13:52";
        
    }
    return _rewardLabel;
}

- (UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.textColor = THEMECOLOR;
        _statusLabel.font = XGFONT(16);
        _statusLabel.text = @"待付款";
    }
    return _statusLabel;
}

- (void)setOrderModel:(OrderModel *)orderModel{
    _orderModel = orderModel;
    self.orderNoLabel.text    = [NSString stringWithFormat:@"订单号:%@",orderModel.orderCode];
    self.orderTimeLabel.text   = [NSString stringWithFormat:@"下单时间:%@",orderModel.createTime];
    self.statusLabel.text = [orderModel orderStateName];
    
    self.amountLabel.text    = [NSString stringWithFormat:@"支付金额:%@",orderModel.payMoney];
    self.integralLabel.text   = [NSString stringWithFormat:@"支付积分:%@",orderModel.payIntegral];
    NSString *rewardIntegral = [NSString stringWithFormat:@"奖励积分:%@/%@", orderModel.commonIntegral, orderModel.mallIntegral];
    
    self.rewardLabel.text    = rewardIntegral;
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderTimeLabel.mas_bottom).offset(5);
        make.left.equalTo(self.orderNoLabel);
        
    }];
    
    
    [self.integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.amountLabel.mas_bottom).offset(5);
        make.left.equalTo(self.orderNoLabel);
    }];
    
    [self.rewardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.integralLabel.mas_bottom).offset(5);
        make.left.equalTo(self.orderNoLabel);
        
    }];

}


- (void)setOrderListModel:(OrderListModel *)orderListModel{
    _orderListModel = orderListModel;
    
    self.orderNoLabel.text    = [NSString stringWithFormat:@"订单号:%@",orderListModel.bigOrderCode];
    self.orderTimeLabel.text   = [NSString stringWithFormat:@"下单时间:%@",orderListModel.createTime];
    self.statusLabel.text = [orderListModel getOrderStateName];
    
}

- (void)setPayOrder:(PayOrderModel *)payOrder{
    _payOrder = payOrder;
    
    self.orderNoLabel.text    = [NSString stringWithFormat:@"订单号:%@",payOrder.orderCode];
    self.orderTimeLabel.text   = [NSString stringWithFormat:@"下单时间:%@",payOrder.createTime];
    self.statusLabel.text = @"买家已付款";
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
