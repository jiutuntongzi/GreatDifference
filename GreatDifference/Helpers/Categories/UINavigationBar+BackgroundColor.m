//
//  UINavigationBar+BackgroundColor.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/8.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "UINavigationBar+BackgroundColor.h"
#import <objc/runtime.h>

@interface UINavigationBar ()
@property (nonatomic, strong) UIView  *overlay;
@end

@implementation UINavigationBar (BackgroundColor)
static char overlayKey;

- (UIView *)overlay{
    
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sg_setBackgroundColor:(UIColor *)backgroundColor{
    if (!self.overlay) {
        [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:[[UIImage alloc] init]];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
        self.overlay.userInteractionEnabled = NO;
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}
@end