//
//  DeleteView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/16.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "DeleteView.h"

@interface DeleteView ()
@property (nonatomic, strong) UIButton         *allSelectBtn;
@property (nonatomic, strong) UIButton         *deleteBtn;
@end
@implementation DeleteView

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
    [self addSubview:self.deleteBtn];
    
    [self.allSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(self);
        make.height.equalTo(@20);
        make.width.equalTo(@70);
        
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
}


- (UIButton *)allSelectBtn{
    if (!_allSelectBtn) {
        _allSelectBtn = [[UIButton alloc]init];
        [_allSelectBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_allSelectBtn setImage:[UIImage imageNamed:@"circle_unSelect"] forState:UIControlStateNormal];
        [_allSelectBtn setImage:[UIImage imageNamed:@"circle_select"] forState:UIControlStateSelected];
        _allSelectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _allSelectBtn.titleLabel.font = XGFONT(15);
        [_allSelectBtn addTarget:self action:@selector(allSelectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectBtn;
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
    if ([self.delegate respondsToSelector:@selector(deleteView:didSelectAllButton:)]) {
        [self.delegate deleteView:self didSelectDeleteButton:btn];
    }
}


- (void)didClickedDeleteBtn:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(deleteView:didSelectDeleteButton:)]) {
        [self.delegate deleteView:self didSelectDeleteButton:btn];
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
