//
//  NewFeatureViewController.m
//  SweePea
//
//  Created by xiaodou_yxg on 16/7/12.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "NewFeatureView.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "XGNavigationViewController.h"

@interface NewFeatureViewController ()

@end

@implementation NewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *images = @[@"launch"];
    NewFeatureView *newFeatureView = [[NewFeatureView alloc]initWithFrame:self.view.bounds images:images];
    
    newFeatureView.beginBlock = ^{
        BOOL loginState = [MyUserDefaults boolForKey:LoginState];
        if (loginState) {
            MainViewController *mainVc = [[MainViewController alloc]init];
            mainVc.view.backgroundColor = [UIColor whiteColor];
            UIWindow  *keyWindow = [UIApplication sharedApplication].keyWindow;
            keyWindow.rootViewController = mainVc;
        }else{
            LoginViewController *loginVc = [[LoginViewController alloc]init];
            loginVc.view.backgroundColor = [UIColor whiteColor];
            XGNavigationViewController *nav = [[XGNavigationViewController alloc]initWithRootViewController:loginVc];

            UIWindow  *keyWindow = [UIApplication sharedApplication].keyWindow;
            keyWindow.rootViewController = nav;
        }

        [MyUserDefaults setBool:YES forKey:kFirstLaunch];
        [MyUserDefaults synchronize];
        
    };
    [self.view addSubview:newFeatureView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
