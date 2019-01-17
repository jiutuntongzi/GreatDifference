//
//  BottomView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/14.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "BottomView.h"
#import "UILabel+Add_XX.h"

@interface BottomView ()
@property (nonatomic, strong) UIButton        *allSelectBtn;
@property (nonatomic, strong) UIButton        *cashBtn;
@property (nonatomic, strong) UILabel         *priceLabel;
@property (nonatomic, strong) UILabel         *amountLabel;
@property (nonatomic, strong) UIButton        *deleteBtn;

@end
@implementation BottomView

#pragma mark -- initialization
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.75].CGColor;
        self.layer.borderWidth = 0.5;
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)setupSubviews{
    [self addSubview:self.allSelectBtn];
    [self addSubview:self.cashBtn];
    [self addSubview:self.priceLabel];
    [self addSubview:self.amountLabel];
    [self.deleteView addSubview:self.deleteBtn];
    [self addSubview:self.deleteView];
    
    [self.allSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(self);
        make.height.equalTo(@40);
        make.width.equalTo(@75);

    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allSelectBtn.mas_right).offset(10);
        make.top.equalTo(self).offset(5);
        make.height.mas_equalTo(18);
    }];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(self.priceLabel);
        make.top.equalTo(self.priceLabel.mas_bottom);
        
    }];
    
    [self.cashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    [self.deleteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allSelectBtn.mas_right);
        make.top.right.bottom.equalTo(self);
    }];
    
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.deleteView).offset(-10);
        make.centerY.equalTo(self.deleteView);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    [self setTotalPrice:0 totalQuantity:0];

}

- (UIButton *)allSelectBtn{
    if (!_allSelectBtn) {
        _allSelectBtn = [[UIButton alloc]init];
        [_allSelectBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_allSelectBtn setImage:[UIImage imageNamed:@"circle_unSelect"] forState:UIControlStateNormal];
        [_allSelectBtn setImage:[UIImage imageNamed:@"circle_select"] forState:UIControlStateSelected];
        _allSelectBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        _allSelectBtn.titleLabel.font = XGFONT(15);
        [_allSelectBtn addTarget:self action:@selector(allSelectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectBtn;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.text = @"合计: ";
        _priceLabel.font = XGFONT(13);
        _priceLabel.textColor = THEMECOLOR;
    }
    return _priceLabel;
}

- (UILabel *)amountLabel{
    if (!_amountLabel) {
        _amountLabel = [[UILabel alloc]init];
        _amountLabel.font = XGFONT(12);
        _amountLabel.textColor = [UIColor lightGrayColor];
        _amountLabel.text = @"共2件";
    }
    return _amountLabel;
}

- (UIButton *)cashBtn{
    if (!_cashBtn) {
        _cashBtn = [[UIButton alloc]init];
        _cashBtn.backgroundColor = THEMECOLOR;
        [_cashBtn setTitle:@"去结算" forState:UIControlStateNormal];
        [_cashBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cashBtn.layer.cornerRadius = 15;
        _cashBtn.titleLabel.font = XGFONT(15);
        [_cashBtn addTarget:self action:@selector(didClickedCashBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cashBtn;
}

- (UIView *)deleteView{
    if (!_deleteView) {
        _deleteView = [[UIView alloc]init];
        _deleteView.backgroundColor = [UIColor whiteColor];
        _deleteView.hidden = YES;

    }
    return _deleteView;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc]init];
        _deleteBtn.backgroundColor = [UIColor whiteColor];
        [_deleteBtn setTitle:@"删除商品" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:THEMECOLOR forState:UIControlStateNormal];
        _deleteBtn.layer.cornerRadius = 15;
        _deleteBtn.layer.borderColor = THEMECOLOR.CGColor;
        _deleteBtn.layer.borderWidth = 1;
        _deleteBtn.titleLabel.font = XGFONT(15);
        [_deleteBtn addTarget:self action:@selector(didClickedDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _deleteBtn;
}


- (void)allSelectBtnClicked:(UIButton *)btn{
    self.allSelectBtn.selected = !btn.selected;
    if ([self.delegate respondsToSelector:@selector(bottomView:didSelectAllButton:)]) {
        [self.delegate bottomView:self didSelectAllButton:self.allSelectBtn.selected];
    }
}

- (void)didClickedCashBtn:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(bottomView:didSelectCashButton:)]) {
        [self.delegate bottomView:self didSelectCashButton:btn];
    }
}

- (void)didClickedDeleteBtn:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(bottomView:didSelectDeleteButton:)]) {
        [self.delegate bottomView:self didSelectDeleteButton:btn];
    }
}


- (UIButtonStatus )getButtonStats{
    if (self.allSelectBtn.selected) {
        return UIButtonStatusSelect;
    }
    return UIButtonStatusNormal;
}

- (void)setSelectAllStatus:(UIButtonStatus )status{
    self.allSelectBtn.selected = status;
}

- (void)setShowDeleteBtn:(BOOL)showDeleteBtn{
    _showDeleteBtn = showDeleteBtn;
    self.deleteView.hidden  = !showDeleteBtn;
}

- (void)setTotalPrice:(float )price totalQuantity:(NSInteger)num{
    self.priceLabel.text    = [NSString stringWithFormat:@"合计: %.2lf",price];
    self.amountLabel.text   = [NSString stringWithFormat:@"共%ld件", (long)num];
    
    NSRange range;
    range.location=0;
    range.length = 4;
    [_priceLabel setAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]} range:range];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
