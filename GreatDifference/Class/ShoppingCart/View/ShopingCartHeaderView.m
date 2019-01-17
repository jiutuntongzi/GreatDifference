//
//  ShopingCartHeaderView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/10.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ShopingCartHeaderView.h"
#import "StoreModel.h"
#import "OrderModel.h"

@interface ShopingCartHeaderView ()
@property (nonatomic, strong) UIButton         *circleBtn;
@property (nonatomic, strong) UILabel         *nameLabel;
@property (nonatomic, strong) UIView          *lineView;
@end
@implementation ShopingCartHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.circleBtn];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.lineView];
//        self.contentView.backgroundColor = [UIColor redColor];
        [self.circleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.centerY.equalTo(self.contentView);
            make.width.height.mas_equalTo(40);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.circleBtn.mas_right).offset(5);
            make.centerY.equalTo(self.circleBtn);
            make.right.equalTo(self.contentView).offset(-10);
            
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}

- (UIButton *)circleBtn{
    if (!_circleBtn) {
        _circleBtn = [UIButton new];
        UIImage *image = [UIImage imageNamed:@"circle_unSelect"];
        UIImage *selectImage = [UIImage imageNamed:@"circle_select"];
        _circleBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
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

- (void)setOrderModel:(OrderModel *)orderModel{
    _orderModel = orderModel;
    
    self.nameLabel.text     = orderModel.shopName;
    if (orderModel.isSelect) {
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
