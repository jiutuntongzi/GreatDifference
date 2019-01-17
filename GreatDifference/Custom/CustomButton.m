//
//  CustomButton.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "CustomButton.h"

@interface CustomButton ()
@property (nonatomic, assign) CGFloat     imageWidth;
@end
@implementation CustomButton

- (instancetype)initWithTitle:(NSString *)title image:(NSString *) imageName imageWidth:(CGFloat )width{
    self = [super init];
    if (self) {
        self.imageWidth = width;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        
    }
    return self;
}



- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageHeight = contentRect.size.height * 0.5;
    CGFloat imageWidth  = contentRect.size.width;
    return CGRectMake((imageWidth - self.imageWidth)/2, (imageHeight -self.imageWidth), self.imageWidth, self.imageWidth);
    
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
