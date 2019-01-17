//
//  CancelOrderCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/3/20.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "CancelOrderCell.h"

@interface CancelOrderCell ()
@property (nonatomic, strong) UILabel         *reasonLabel;
@property (nonatomic, strong) UILabel         *applyTimeLabel;
@property (nonatomic, strong) UILabel         *returnAmountLabel;
@property (nonatomic, strong) UILabel         *returnIntegralLabel;
@property (nonatomic, strong) UILabel         *platIntegralLabel;
@property (nonatomic, strong) UILabel         *fenRunLabel;
@end
@implementation CancelOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setupSubviews{
    [self.contentView addSubview:self.reasonLabel];
    [self.contentView addSubview:self.applyTimeLabel];
    [self.contentView addSubview:self.returnAmountLabel];
    [self.contentView addSubview:self.returnIntegralLabel];
    [self.contentView addSubview:self.platIntegralLabel];
    [self.contentView addSubview:self.fenRunLabel];

    
    [self.reasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    [self.applyTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.reasonLabel.mas_bottom).offset(5);
        make.left.equalTo(self.reasonLabel);
        
    }];
    
    [self.returnAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.applyTimeLabel.mas_bottom).offset(5);
        make.left.equalTo(self.reasonLabel);
        
    }];
    
    [self.returnIntegralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.returnAmountLabel.mas_bottom).offset(5);
        make.left.equalTo(self.returnAmountLabel);
        
    }];
    
    [self.platIntegralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.returnIntegralLabel.mas_bottom).offset(5);
        make.left.equalTo(self.reasonLabel);
        
    }];
    
    [self.fenRunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.platIntegralLabel.mas_bottom).offset(5);
        make.left.equalTo(self.reasonLabel);
        
    }];
    
    
}

- (UILabel *)reasonLabel{
    if (!_reasonLabel) {
        _reasonLabel = [[UILabel alloc]init];
        _reasonLabel.textColor = [UIColor grayColor];
        _reasonLabel.font = XGFONT(15);
        _reasonLabel.text = @"订单号: 2016120364689";
    }
    return _reasonLabel;
}

- (UILabel *)applyTimeLabel{
    if (!_applyTimeLabel) {
        _applyTimeLabel = [[UILabel alloc]init];
        _applyTimeLabel.textColor = [UIColor grayColor];
        _applyTimeLabel.font = XGFONT(14);
        _applyTimeLabel.text = @"下单时间: 2016-12-07 13:52";
        
    }
    return _applyTimeLabel;
}

- (UILabel *)returnIntegralLabel{
    if (!_returnIntegralLabel) {
        _returnIntegralLabel = [[UILabel alloc]init];
        _returnIntegralLabel.textColor = [UIColor grayColor];
        _returnIntegralLabel.font = XGFONT(14);
        _returnIntegralLabel.text = @"下单时间: 2016-12-07 13:52";
        
    }
    return _returnIntegralLabel;
}

- (UILabel *)platIntegralLabel{
    if (!_platIntegralLabel) {
        _platIntegralLabel = [[UILabel alloc]init];
        _platIntegralLabel.textColor = [UIColor grayColor];
        _platIntegralLabel.font = XGFONT(14);
        _platIntegralLabel.text = @"下单时间: 2016-12-07 13:52";
        
    }
    return _platIntegralLabel;
}

- (UILabel *)fenRunLabel{
    if (!_fenRunLabel) {
        _fenRunLabel = [[UILabel alloc]init];
        _fenRunLabel.textColor = [UIColor grayColor];
        _fenRunLabel.font = XGFONT(14);
        _fenRunLabel.text = @"下单时间: 2016-12-07 13:52";
        
    }
    return _fenRunLabel;
}

- (UILabel *)returnAmountLabel{
    if (!_returnAmountLabel) {
        _returnAmountLabel = [[UILabel alloc]init];
        _returnAmountLabel.textColor = [UIColor grayColor];;
        _returnAmountLabel.font = XGFONT(14);
        _returnAmountLabel.text = @"待付款";
    }
    return _returnAmountLabel;
}

- (void)setOrderModel:(OrderModel *)orderModel{
    _orderModel = orderModel;
    self.reasonLabel.text    = [NSString stringWithFormat:@"申请原因: %@",orderModel.returnReason];
    self.applyTimeLabel.text   = [NSString stringWithFormat:@"申请时间: %@",orderModel.applicationTime];
    self.returnAmountLabel.text = [NSString stringWithFormat:@"返还用户金额: %@",orderModel.returnMoney];
    
    self.returnIntegralLabel.text    = [NSString stringWithFormat:@"返还用户积分: %@",orderModel.returnIntegral];
    
    NSString *returnIntegral = [NSString stringWithFormat:@"返还平台积分: %@/%@", orderModel.returnCommonIntegral, orderModel.returnMallIntegral];

    self.platIntegralLabel.text   = returnIntegral;
    self.fenRunLabel.text    = [NSString stringWithFormat:@"返回用户分润: %@",orderModel.returnFeeSplitting];

    //    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.orderTimeLabel.mas_bottom).offset(5);
    //        make.left.equalTo(self.orderNoLabel);
    //
    //    }];
    
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
