//
//  AppDelegate+Pay.m
//  GreatDifference
//
//  Created by 杨旭根 on 2018/2/6.
//  Copyright © 2018年 xiaodou. All rights reserved.
//

#import "AppDelegate+Pay.h"
#import "WXApi.h"
#import "WXApiManager.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation AppDelegate (Pay)

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSString *resultStatus = [resultDic objectForKey:@"resultStatus"];
            NSString *result = [resultDic objectForKey:@"result"];
            
            if ([resultStatus isEqualToString:@"9000"]) {
                if ([result rangeOfString:@"Success"].location!=NSNotFound) {
                    // 此处本来需调用后台接口 确认支付是否成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFICATION_CHARGE_SUCCESS object:nil];
                }
            }
            NSLog(@"result = %@",resultDic);
        }];
    }
    //
    // 微信支付
    if ([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
        
    }
    [self finishPayWithUrl:url];
    return YES;
}

/**
 9000	订单支付成功
 8000	正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
 4000	订单支付失败
 5000	重复请求
 6001	用户中途取消
 6002	网络连接出错
 6004	支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
 其它	其它支付错误
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation NS_DEPRECATED_IOS(4_2, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED{
    [self finishPayWithUrl:url];
    return YES;
}

- (void)finishPayWithUrl:(NSURL *)url{
    
    // 支付宝支付
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSString *resultStatus = [resultDic objectForKey:@"resultStatus"];
            NSString *result = [resultDic objectForKey:@"result"];
            
            if ([resultStatus isEqualToString:@"9000"]) {
                if ([result rangeOfString:@"success=\"true\""].location!=NSNotFound) {
                    // 此处本来需调用后台接口 确认支付是否成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFICATION_CHARGE_SUCCESS object:nil];
                }
            }else if ([resultStatus isEqualToString:@"6001"]){
                [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFICATION_CHARGE_CANCEL_PAY object:@"alipay"];
                
            }else{
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
            NSLog(@"result = %@",resultDic);
        }];
    }
    // 微信支付
    if ([url.host isEqualToString:@"pay"]) {
        [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
}

@end
