//
//  ContactServiceView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/29.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ContactServiceView.h"
#import "XDTextView.h"

@interface ContactServiceView ()
@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UIButton         *detailBtn;
@property (nonatomic, strong) UIView          *lineView;
@property (nonatomic, strong) UIView          *lineView1;

@property (nonatomic, strong) XDTextView      *textView;
@property (nonatomic, strong) UIButton        *submitBtn;
@property (nonatomic, assign) BOOL            isNavBarHidden;
@end
@implementation ContactServiceView

- (instancetype)initWithFrame:(CGRect)frame isNavigationBarHidden:(BOOL )hidden{
    self = [super initWithFrame:frame];
    if (self) {
        _isNavBarHidden = hidden;
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame isNavigationBarHidden:YES];
}

- (void)setupSubviews{
//    [self addSubview:self.titleLabel];
//    [self addSubview:self.detailBtn];
//    [self addSubview:self.lineView];
    [self addSubview:self.lineView1];

    [self addSubview:self.textView];
    [self addSubview:self.submitBtn];
    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@10);
//        CGFloat topY = 15;
//        topY = 80;
//        make.top.equalTo(@(topY));
//
//        make.height.mas_equalTo(20);
////        make.right.equalTo(self.detailBtn.mas_left).offset(-10);
//    }];
//    
//    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.titleLabel.mas_right).offset(10);
//        make.top.equalTo(self.titleLabel);
////        make.right.equalTo(self.mas_right).offset(-10);
//        make.width.mas_greaterThanOrEqualTo(80);
//    }];
//    
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
//        make.height.mas_equalTo(1);
//    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(80);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(120);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.textView.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(self.lineView1.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"联系电话";
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font    = XGFONT(15);
    }
    return _titleLabel;
}

- (UIButton *)detailBtn{
    if (!_detailBtn) {
        _detailBtn = [[UIButton alloc]init];
        [_detailBtn setTitle:@"400-5487-648" forState:UIControlStateNormal];
        [_detailBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_detailBtn setImage:[UIImage imageNamed:@"icon_phone"] forState:UIControlStateNormal];
        _detailBtn.titleLabel.font    = XGFONT(15);
        _detailBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    }
    return _detailBtn;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35];
    }
    return _lineView;
}

- (UIView *)lineView1{
    if (!_lineView1) {
        _lineView1 = [[UIView alloc]init];
        _lineView1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35];
    }
    return _lineView1;
}

- (XDTextView *)textView{
    if (!_textView) {
        _textView = [[XDTextView alloc]init];
        _textView.placeholder   = @"输入留言";
        _textView.font  = XGFONT(17);
    }
    return _textView;
}

- (UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]init];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.backgroundColor  = THEMECOLOR;
        _submitBtn.layer.cornerRadius = 3;
        [_submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (void)submitAction:(UIButton *)btn{
    if (self.submitBlock) {
        self.submitBlock(self.textView.text);
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
