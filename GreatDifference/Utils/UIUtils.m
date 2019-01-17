//
//  UIUtils.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/18.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils
+ (UIImage *)navigationBarFromColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, SCREEN_HEIGHT, 64);
    UIImage *image = [self imageWithFrame:rect color:color];
    return image;
}

+ (UIImage *)imageWithFrame:(CGRect)frame color:(UIColor *)color{
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
