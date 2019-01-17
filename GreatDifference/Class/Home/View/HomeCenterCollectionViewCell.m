//
//  HomeCenterCollectionViewCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/5.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "HomeCenterCollectionViewCell.h"

@interface HomeCenterCollectionViewCell ()
@property (nonatomic, strong) UIImageView       *imageView;
@property (nonatomic, strong) UILabel           *titleLabel;
@end
@implementation HomeCenterCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@10);
            make.right.equalTo(@-10);
            make.width.equalTo(self.imageView.mas_height);

        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(5);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(@20);
        }];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor magentaColor];
        _imageView.layer.masksToBounds= YES;
        _imageView.layer.cornerRadius = (self.bounds.size.width-20)/2;
        _imageView.image = [UIImage imageNamed:@"1_full"];


    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"便利店";
        CGFloat font = 13;
        if (IS_IPHONE_5 || IS_IPHONE_4) {
            font = 13;
        }
        _titleLabel.font = XGFONT(font);
        _titleLabel.textColor = HEXCOLOR(0x666666);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)setStoreModel:(StoreModel *)storeModel{
    _storeModel = storeModel;
    self.titleLabel.text    = storeModel.shopName;
    self.imageView.image = [UIImage imageNamed:storeModel.shopIcon];
}
@end
