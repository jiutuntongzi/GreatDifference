//
//  AppDelegate+Share.m
//  GreatDifference
//
//  Created by 杨旭根 on 2018/2/6.
//  Copyright © 2018年 xiaodou. All rights reserved.
//

#import "AppDelegate+Share.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//新浪微博SDK头文件
#import "WeiboSDK.h"
#import "WXApi.h"

@implementation AppDelegate (Share)
- (void)setShareSDK{
    [ShareSDK registerApp:@"1b73a6eca08f0" activePlatforms:@[@(SSDKPlatformTypeWechat), @(SSDKPlatformTypeQQ),@(SSDKPlatformTypeSinaWeibo)] onImport:^(SSDKPlatformType platformType) {
        switch (platformType)
        {
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
            default:
                break;
        }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType)
        {
            case SSDKPlatformTypeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:@"318073556"
                                          appSecret:@"9b6700136fca9958039dc383ddfd7c70"
                                        redirectUri:@"http://www.douwong.com"
                                           authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:@"wx4d18a7e6077fa31f"
                                      appSecret:@"461f504d9cb63b0d8062735c71a6eef7"];
                break;
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:@"1105514407"
                                     appKey:@"loShLZQgV9U3wVQy"
                                   authType:SSDKAuthTypeBoth];
                break;
                
            default:
                break;
        }
    }];
}



@end
