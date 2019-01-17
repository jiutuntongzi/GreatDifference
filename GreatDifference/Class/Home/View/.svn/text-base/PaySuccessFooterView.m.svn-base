//
//  PaySuccessFooterView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/2/8.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "PaySuccessFooterView.h"
#import "PayOrderModel.h"
#import "UILabel+Add_XX.h"

#define kBtnWidth               (SCREEN_WIDTH/4)
@interface PaySuccessFooterView ()
@property (nonatomic, strong) UILabel          *priceLabel;
@property (nonatomic, strong) UIButton         *lookupOrderBtn;
@property (nonatomic, strong) UIButton         *backHomeBtn;
@property (nonatomic, strong) UIView           *backView;
@end
@implementation PaySuccessFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.backView];
    [self addSubview:self.priceLabel];
//    [self addSubview:self.lookupOrderBtn];
    [self addSubview:self.backHomeBtn];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(10);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(35);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
//    [self.lookupOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(kBtnWidth/2);
//        make.top.equalTo(self.priceLabel.mas_bottom).offset(20);
//        make.width.mas_equalTo(kBtnWidth);
//        make.height.mas_equalTo(30);
//    }];
    
    [self.backHomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-30);
        make.top.equalTo(self).offset(30);
        make.width.mas_equalTo(kBtnWidth);
        make.height.mas_equalTo(25);

    }];
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = XGCOLOR(236, 236, 236);

    }
    return _backView;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = THEMECOLOR;
        _priceLabel.font = XGFONT(15);
        _priceLabel.text = @"总价: ￥ 29.6";
    }
    return _priceLabel;
}

- (UIButton *)lookupOrderBtn{
    if (!_lookupOrderBtn) {
        _lookupOrderBtn = [[UIButton alloc]init];
        _lookupOrderBtn.layer.cornerRadius = 2;
        _lookupOrderBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _lookupOrderBtn.layer.borderWidth = 1;
        [_lookupOrderBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        [_lookupOrderBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_lookupOrderBtn addTarget:self action:@selector(lookupOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lookupOrderBtn;
}

- (UIButton *)backHomeBtn{
    if (!_backHomeBtn) {
        _backHomeBtn = [[UIButton alloc]init];
        _backHomeBtn.layer.cornerRadius = 2;
        _backHomeBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _backHomeBtn.layer.borderWidth = 1;
        [_backHomeBtn setTitle:@"返回首页" forState:UIControlStateNormal];
        [_backHomeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_backHomeBtn addTarget:self action:@selector(backHomeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backHomeBtn;
}

- (void)lookupOrderAction:(UIButton *)btn{
    
}

- (void)backHomeAction:(UIButton *)btn{
    if (self.backBlock) {
        self.backBlock();
    }
}

- (void)setPayOrder:(PayOrderModel *)payOrder{
    _payOrder = payOrder;
    self.priceLabel.text    = [NSString stringWithFormat:@"总价:￥%@",payOrder.orderPrice];
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    NSRange range;
    range.location = 0;
    range.length =  3;
    [attribute setValue:[UIColor grayColor] forKey:NSForegroundColorAttributeName];
    [self.priceLabel setAttributes:attribute range:range];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
