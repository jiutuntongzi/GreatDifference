//
//  HUDUtils.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/18.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "HUDUtils.h"
#import "MBProgressHUD.h"

@implementation HUDUtils
+ (instancetype)sharedInstance{
    static HUDUtils *sharedInstance = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

+ (void)showLoading:(NSString *)title{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self showLoading:title inView:window];
}

+ (void)showLoading:(NSString *)title inView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.animationType = MBProgressHUDAnimationFade;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = title;
//    hud.minShowTime = 1.2;
}

+ (void)hideHud{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
   [MBProgressHUD hideHUDForView:window animated:YES];
}

+ (void)showError:(NSString *)error{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.animationType = MBProgressHUDAnimationFade;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text  = error;
    [hud hideAnimated:YES afterDelay:2.0f];
}


+ (void)showAlert:(NSString *)content{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.animationType = MBProgressHUDAnimationFade;
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    hud.bezelView.style =     MBProgressHUDBackgroundStyleSolidColor;
    hud.detailsLabel.text = content;
    hud.detailsLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.85];
    hud.detailsLabel.font = XGFONT(14);
    [hud hideAnimated:YES afterDelay:2.0];
}
@end
