//
//  MyWalletHeaderView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/16.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MyWalletHeaderView.h"
#import "CustomButton.h"

@interface MyWalletHeaderView ()
@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UILabel         *priceLabel;
@property (nonatomic, strong) UILabel         *detailLabel;
@property (nonatomic, strong) CustomButton    *leftBtn;
@property (nonatomic, strong) CustomButton    *rightBtn;
@property (nonatomic, strong) UIView           *lineView1;
@property (nonatomic, strong) UIView           *lineView2;
@property (nonatomic, strong) UIView           *bottomView;
@property (nonatomic, copy) NSString           *type; // 0 积分 1: 钱包

@end
@implementation MyWalletHeaderView

- (instancetype)initWithFrame:(CGRect )frame type:(NSString *)type{    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        [self setupSubviews];

    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.lineView1];
    [self addSubview:self.lineView2];
    [self addSubview:self.bottomView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(@10);
        make.height.mas_equalTo(20);
    }];
    
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(40);
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(60);
    }];
    
    if ([self.type isEqualToString:@"0"]) {
        [self addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.priceLabel.mas_bottom);
            make.left.right.equalTo(self);
        }];
    }

    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        CGFloat topY = 35;
        if (IS_IPHONE_6S) {
            topY = 50;
        }else if (IS_IPHONE_6SPlus){
            topY = 60;
        }
        make.top.equalTo(self.priceLabel.mas_bottom).offset(topY);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.lineView1.mas_bottom);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.width.mas_equalTo(0.5);

    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.lineView1.mas_bottom).offset(1);
        make.width.equalTo(@(SCREEN_WIDTH/2-0.5));
        make.bottom.equalTo(self.bottomView.mas_top);

    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView2.mas_right).offset(0.5);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.top.equalTo(self.leftBtn);
        make.width.equalTo(@(SCREEN_WIDTH/2-1));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(10);
    }];
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = XGFONT(15);
        _titleLabel.text = @"我的分润";
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.font = XGFONT(15);
        _detailLabel.text = @"我的分润";
        _detailLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _detailLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = XGFONT(50);
        _priceLabel.text    = @"80元";
    }
    return _priceLabel;
}

- (CustomButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[CustomButton alloc]initWithTitle:@"分润提现" image:@"get_integral" imageWidth:30];
//        [_leftBtn setTitle:@"分润提现" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
//        [_leftBtn setImage:[UIImage imageNamed:@"get_integral"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(didClickedCashBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (CustomButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[CustomButton alloc]initWithTitle:@"分润问题解答" image:@"integral_question" imageWidth:30];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(didClickedQuestionBtn:) forControlEvents:UIControlEventTouchUpInside];
//        _rightBtn.backgroundColor = [UIColor greenColor];

    }
    return _rightBtn;
}

- (UIView *)lineView1{
    if (!_lineView1) {
        _lineView1 = [[UIView alloc]init];
        _lineView1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.75];
        _lineView1.height = 0.5;
    }
    return _lineView1;
}

- (UIView *)lineView2{
    if (!_lineView2) {
        _lineView2 = [[UIView alloc]init];
        _lineView2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.75];
        _lineView1.width = 0.5;
    }
    return _lineView2;
}


- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35];
    }
    return _bottomView;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.leftBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)didClickedCashBtn:(UIButton *)btn{
    if (self.leftBlock) {
        self.leftBlock(self.model);
    }
}

- (void)didClickedQuestionBtn:(UIButton *)btn{
    if (self.rightBlock) {
        self.rightBlock(self.model);
    }
}

- (void)setModel:(IntegralModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.priceLabel.text    = [NSString stringWithFormat:@"%@", model.totalIntegral];
    self.detailLabel.text   = [NSString stringWithFormat:@"通用积分%@ 海淘积分%@",model.commonIntegral, model.mallIntegral];
    [self.leftBtn setTitle:model.leftTitle forState:UIControlStateNormal];
    [self.rightBtn setTitle:model.rightTitle forState:UIControlStateNormal];

    
}

- (void)setWalletModel:(IntegralModel *)wallet{
    _model = wallet;
    self.titleLabel.text = wallet.title;
    self.priceLabel.text    = [NSString stringWithFormat:@"%@元", wallet.money];
//    self.detailLabel.text   = [NSString stringWithFormat:@"通用积分%@ 海淘积分%@",wallet.commonIntegral, wallet.mallIntegral];
    [self.leftBtn setTitle:wallet.leftTitle forState:UIControlStateNormal];
    [self.rightBtn setTitle:wallet.rightTitle forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
