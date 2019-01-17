//
//  CustomButton.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (instancetype)init{
    self = [super init];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageHeight = contentRect.size.height * 0.5;
    CGFloat imageWidth  = contentRect.size.width;
    return CGRectMake((imageWidth - 30)/2, (imageHeight -30), 30, 30);
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleHeight = contentRect.size.height * 0.5;
    CGFloat titleWidth  = contentRect.size.width;
    return CGRectMake(0, titleHeight, titleWidth, titleHeight);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
