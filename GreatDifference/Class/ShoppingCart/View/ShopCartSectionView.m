//
//  ShopCartSectionView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/10.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ShopCartSectionView.h"
#import "StoreModel.h"

@interface ShopCartSectionView ()
@property (nonatomic, strong) UIButton        *circleBtn;
@property (nonatomic, strong) UILabel         *nameLabel;
@property (nonatomic, strong) UIView          *lineView;
@end
@implementation ShopCartSectionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.circleBtn];
        [self addSubview:self.nameLabel];
        [self addSubview:self.lineView];
        
        [self.circleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.centerY.equalTo(self);
            make.width.height.mas_equalTo(20);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.circleBtn.mas_right).offset(10);
            make.top.equalTo(@10);
            make.right.equalTo(self).offset(-10);
            
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@0.5);
        }];
        
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (UIButton *)circleBtn{
    if (!_circleBtn) {
        _circleBtn = [UIButton new];
        UIImage *image = [UIImage imageNamed:@"circle_unSelect"];
        UIImage *selectImage = [UIImage imageNamed:@"circle_select"];
        
        [_circleBtn setImage:image forState:UIControlStateNormal];
        [_circleBtn setImage:selectImage forState:UIControlStateSelected];
        [_circleBtn addTarget:self action:@selector(didClickedSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _circleBtn;
}


- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.text = @"便利店海岸城店";
        _nameLabel.font = XGFONT(15);
        _nameLabel.numberOfLines = 2;
    }
    return _nameLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (void)didClickedSelectBtn:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (self.sectionBlock) {
        self.sectionBlock(btn.selected);
    }
}

- (void)setStoreModel:(StoreModel *)storeModel{
    _storeModel = storeModel;
    self.nameLabel.text = storeModel.shopName;
    if (storeModel.isSelect) {
        self.circleBtn.selected = YES;
    }else{
        self.circleBtn.selected = NO;;
        
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
