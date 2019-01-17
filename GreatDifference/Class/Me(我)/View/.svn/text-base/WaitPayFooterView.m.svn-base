//
//  WaitPayFooterView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/5.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "WaitPayFooterView.h"


@interface WaitPayFooterView ()
@property (nonatomic, strong) UILabel         *qualityLabel;
@property (nonatomic, strong) UILabel         *totalMoneyLabel;
@property (nonatomic, strong) UIView          *lineView;
@property (nonatomic, strong) UIButton         *cancelOrderBtn;
@property (nonatomic, strong) UIButton         *payBtn;
@end
@implementation WaitPayFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
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
    [self.contentView addSubview:self.lineView];
    
    [self.contentView addSubview:self.cancelOrderBtn];
    [self.contentView addSubview:self.payBtn];
    
    [self.qualityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.totalMoneyLabel.mas_left).offset(-10);
        make.top.equalTo(@10);
        make.height.mas_equalTo(20);
    }];
    
    [self.totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.height.equalTo(self.qualityLabel);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.qualityLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(0.5);
        
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.lineView).offset(10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(25);
    }];
    
    
    [self.cancelOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(self.payBtn);
        make.right.equalTo(self.payBtn.mas_left).offset(-10);
        //        make.height.mas_equalTo(30);
        
    }];
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


- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.75];
    }
    return _lineView;
}


- (UIButton *)cancelOrderBtn{
    if (!_cancelOrderBtn) {
        _cancelOrderBtn = [[UIButton alloc]init];
        _cancelOrderBtn.titleLabel.font = XGFONT(16);
        [_cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
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
        _payBtn.titleLabel.font = XGFONT(16);
        
        [_payBtn setTitleColor:THEMECOLOR forState:UIControlStateNormal];
        [_payBtn setTitle:@"付款" forState:UIControlStateNormal];
        [_payBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _payBtn;
}

- (void)setOrderListModel:(OrderListModel *)orderListModel{
    _orderListModel = orderListModel;
    self.qualityLabel.text = [NSString stringWithFormat:@"共%@件商品",orderListModel.goodsNum];
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"合计:%@",orderListModel.orderPrice];
    if ([orderListModel.existsChangeProduct isEqualToString:@"1"]) {
        self.payBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;;
        self.payBtn.layer.borderWidth = 1;
        self.payBtn.titleLabel.font = XGFONT(16);
        
        [self.payBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.payBtn.userInteractionEnabled = NO;

    }else{
        self.payBtn.layer.borderColor = THEMECOLOR.CGColor;
        self.payBtn.layer.borderWidth = 1;
        self.payBtn.titleLabel.font = XGFONT(16);
        
        [self.payBtn setTitleColor:THEMECOLOR forState:UIControlStateNormal];
        self.payBtn.userInteractionEnabled = YES;

    }
}

- (void)cancelOrderAction:(UIButton *)btn{
    if (self.cancelOrderBlock) {
        self.cancelOrderBlock();
    }
}

- (void)payAction:(UIButton *)btn{
    if (self.payBlock) {
        self.payBlock();
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
