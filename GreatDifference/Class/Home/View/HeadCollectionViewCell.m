//
//  HeadCollectionViewCell.m
//  SweePea
//
//  Created by xiaodou_yxg on 16/6/24.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "HeadCollectionViewCell.h"

@implementation HeadCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView = imageView;
        [self.contentView addSubview:imageView];
    }
    return self;
}
@end
