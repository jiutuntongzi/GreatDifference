//
//  QualityView.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/12/4.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "QualityView.h"
#import "PPNumberButton.h"

@interface QualityView ()
@property (nonatomic, strong) UILabel           *titleLabel;
@property (nonatomic, strong) UILabel           *qualityLabel;
@property (nonatomic, strong) PPNumberButton    *numberButton;
@property (nonatomic, strong) UIButton          *sureBtn;
@property (nonatomic, strong) UIButton          *closeBtn;
@property (nonatomic, strong) UIView            *lineView1;
@property (nonatomic, strong) UIView            *lineView2;




@end
@implementation QualityView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.qualityLabel];
    [self addSubview:self.numberButton];
    [self addSubview:self.sureBtn];
    [self addSubview:self.closeBtn];
    [self  addSubview:self.lineView1];
    [self addSubview:self.lineView2];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.centerX.equalTo(self);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.qualityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
    
    }];
    
    [self.numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.qualityLabel).offset(-5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.qualityLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-20);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.height.mas_equalTo(40);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.top.equalTo(@5);
        make.width.height.mas_equalTo(30);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"选择购买数量";
    }
    return _titleLabel;
}

- (UILabel *)qualityLabel{
    if (!_qualityLabel) {
        _qualityLabel = [[UILabel alloc]init];
        _qualityLabel.text  = @"购买数量";
    }
    return _qualityLabel;
}

- (PPNumberButton *)numberButton{
    if (!_numberButton) {
        _numberButton = [[PPNumberButton alloc]init];
        
        _numberButton.frame = CGRectMake(0, 0, 100, 30);
        [_numberButton setImageWithincreaseImage:[UIImage imageNamed:@"icon_more_normal"] decreaseImage:[UIImage imageNamed:@"icon_less_normal"]];
//        [_numberButton setTitleWithIncreaseTitle:@"+" decreaseTitle:@"-"];
    }
    return _numberButton;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc]init];
        _sureBtn.backgroundColor = THEMECOLOR;
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc]init];
        _closeBtn.backgroundColor = [UIColor whiteColor];
        [_closeBtn setImage:[UIImage imageNamed:@"quality_close_icon"]forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return _closeBtn;
}

- (UIView *)lineView1{
    if (!_lineView1) {
        _lineView1 = [[UIView alloc]init];
        _lineView1.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView1;
}

- (UIView *)lineView2{
    if (!_lineView2) {
        _lineView2 = [[UIView alloc]init];
        _lineView2.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView2;
}

- (void)sureAction:(UIButton *)btn{
    if (self.sureBlock) {
        self.sureBlock([self.numberButton currentNumber]);
    }
}


- (void)closeAction:(UIButton *)btn{
    if (self.closeBlock) {
        self.closeBlock();
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
