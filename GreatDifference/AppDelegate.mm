//
//  AppDelegate.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 16/10/29.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Share.h"

#import "LoginViewController.h"
#import "XGNavigationViewController.h"
#import "MainViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "WXApi.h"
#import "WXApiManager.h"

#import "NewFeatureViewController.h"



#import <AlipaySDK/AlipaySDK.h>

BMKMapManager* _mapManager;

@interface AppDelegate ()<UIAlertViewDelegate>
@property (nonatomic, copy) NSString  *updateUrl;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];


    [self updateApp];
    [self setRootViewController];
    [self setShareSDK];

    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"NnScWFxau6idbprnsPdk9nf3ZaBNoYyZ" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    //应用中本地图片缓存清除处理
//    [[SDImageCache sharedImageCache] clearMemory];
//    [[SDImageCache sharedImageCache] cleanDisk]

    [_window makeKeyAndVisible];

    return YES;
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

- (void)setRootViewController{
    // 应该存储当前的版本号 来判断是否需要更新
    NSString *lastVersion = [MyUserDefaults objectForKey:CURRENT_VERSION];
    NSString *currentVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:CURRENT_VERSION];
    if ([lastVersion isEqualToString:currentVersion]) {
        
        UIViewController *rootVc;
        BOOL loginState = [MyUserDefaults boolForKey:LoginState];
        if (!loginState) {
            LoginViewController *loginVc = [[LoginViewController alloc]init];
            rootVc = [[XGNavigationViewController alloc]initWithRootViewController:loginVc];
            
        }else{
            rootVc = [[MainViewController alloc]init];
        }
        
        _window.rootViewController = rootVc;
        
    }else{
        self.window.rootViewController = [NewFeatureViewController new];
        [MyUserDefaults setObject:currentVersion forKey:CURRENT_VERSION];
        [MyUserDefaults synchronize];
    }
}

- (BOOL)updateApp{
    
    NSError *error;
    //kAPP_URL : http://itunes.apple.com/lookup?id=
    //kAppId : 在iTunes connect上申请的APP ID
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kApp_URL, kAppId];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if (!response) {
        return NO;
    }
    NSError *dicError;
    NSDictionary *appInfoDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&dicError];
    
    if (error) {
        NSLog(@"%@", error.description);
        return NO;
    }
    NSArray *resultArray = [appInfoDict objectForKey:@"results"];
    if (!resultArray.count) {
        return NO;
    }
    NSDictionary *updateDict = [resultArray objectAtIndex:0];
    //获取服务器上应用的最新版本号 此判断 第一位数 不能大于9
    NSString  *updateVersion = updateDict[@"version"];
    NSRange range;
    range.location = 1;
    range.length = 1;
    float update = [[updateVersion stringByReplacingCharactersInRange:range withString:@""] floatValue];
    
    NSString * trackViewUrl = updateDict[@"trackViewUrl"];
    NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    float current = [[currentVersion stringByReplacingCharactersInRange:range withString:@""] floatValue];
    
    if (current<update) {
    
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"检查更新" message:@"发现最新版本是否更新" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        alertView.delegate = self;
        self.updateUrl = trackViewUrl;
        [alertView show];
//        
    }
    return NO;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.updateUrl]];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
