//
//  RefundImgCollectionViewCell.m
//  GreatDifference-business
//
//  Created by xiaodou_yxg on 2017/3/27.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "RefundImgCollectionViewCell.h"

@interface RefundImgCollectionViewCell ()

@end
@implementation RefundImgCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.picImg];
    [self.picImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
- (UIImageView *)picImg{
    if (!_picImg) {
        _picImg = [[UIImageView alloc]init];
        
        
    }
    return _picImg;
}
@end
