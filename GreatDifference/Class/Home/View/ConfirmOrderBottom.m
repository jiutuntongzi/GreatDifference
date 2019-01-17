//
//  ConfirmOrderBottom.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/12/4.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ConfirmOrderBottom.h"
#import "UILabel+Add_XX.h"
@interface ConfirmOrderBottom ()
@property (nonatomic, strong) UIView        *lineView;
@property (nonatomic, strong) UILabel       *qualityLabel;
@property (nonatomic, strong) UILabel       *totalMoneyLabel;
@property (nonatomic, strong) UILabel       *jifenLabel;
@property (nonatomic, strong) UIButton      *payBtn;
@property (nonatomic, strong) OrderListModel      *tempOrder;

@end
@implementation ConfirmOrderBottom


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.qualityLabel];
    [self addSubview:self.totalMoneyLabel];
//    [self addSubview:self.jifenLabel];
    [self addSubview:self.payBtn];
    [self addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    
    [self.qualityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@15);
        
    }];
    
    [self.totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qualityLabel);
        make.left.equalTo(self.qualityLabel.mas_right).offset(10);
    }];
    
//    [self.jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.totalMoneyLabel.mas_right).offset(10);
//        make.top.equalTo(self.qualityLabel);
//    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.equalTo(self);
        make.width.mas_equalTo(100);
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
        _qualityLabel.text  = @"共1件";
        _qualityLabel.font = XGFONT(13);
        
    }
    return _qualityLabel;
}

- (UILabel *)totalMoneyLabel{
    if (!_totalMoneyLabel) {
        _totalMoneyLabel = [[UILabel alloc]init];
        _totalMoneyLabel.text  = @"合计: ￥3.00";
        _totalMoneyLabel.font = XGFONT(13);
        _totalMoneyLabel.textColor = THEMECOLOR;
    }
    return _totalMoneyLabel;
}

- (UILabel *)jifenLabel{
    if (!_jifenLabel) {
        _jifenLabel = [[UILabel alloc]init];
        _jifenLabel.text  = @"使用: 3积分";
        _jifenLabel.font = XGFONT(13);
    }
    return _jifenLabel;
}

- (UIButton *)payBtn{
    if (!_payBtn) {
        _payBtn = [[UIButton alloc]init];
        _payBtn.backgroundColor = THEMECOLOR;
        [_payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}

- (void)payAction:(UIButton *)btn{
    if (self.confirmPayBlock) {
        self.confirmPayBlock(btn);
    }
}

- (void)setBigOrder:(OrderListModel *)bigOrder{
    _bigOrder = bigOrder;
    self.qualityLabel.text = [NSString stringWithFormat:@"共%@件", bigOrder.goodsNum];
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"合计: ￥%.2lf", [bigOrder.orderPrice floatValue]];
    NSRange range;
    range.location = 0;
    range.length = 3;
    [self.totalMoneyLabel setAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} range:range];
    
    OrderListModel *tempOrder = [[OrderListModel alloc]init];
    tempOrder.goodsNum = self.bigOrder.goodsNum;
    
    tempOrder.orderPrice = self.bigOrder.orderPrice;
    self.tempOrder = tempOrder;
//    self.jifenLabel.text = [NSString stringWithFormat:@"使用%@积分", @"0"];
}

- (void)setTotalPrice:(NSString *)price{
//    self.bigOrder.orderPrice = price;

    
    self.tempOrder.orderPrice = price;
    [self setBigOrder:self.tempOrder];
}

- (NSString *)getCurrentPrice{
    return self.tempOrder.orderPrice;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
