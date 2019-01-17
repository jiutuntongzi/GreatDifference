//
//  XGNavigationViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 16/10/31.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "XGNavigationViewController.h"
#import "UINavigationBar+BackgroundColor.h"

@interface XGNavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation XGNavigationViewController

+ (void)initialize{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBarTintColor:THEMECOLOR];
    [navigationBar setTintColor:[UIColor whiteColor]];
    
    NSMutableDictionary *barAttributes             = [NSMutableDictionary dictionary];
    barAttributes[NSFontAttributeName]             = [UIFont systemFontOfSize:20];
    barAttributes[NSForegroundColorAttributeName]  = [UIColor whiteColor];
    [navigationBar setTitleTextAttributes:barAttributes];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationBar sg_setBackgroundColor:[UIColor orangeColor]];
    // Do any additional setup after loading the view.
}
//
//
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }else{
        viewController.hidesBottomBarWhenPushed = NO;

    }
    [super pushViewController:viewController animated:animated];
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
