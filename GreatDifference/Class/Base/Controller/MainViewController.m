//
//  MainViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 16/11/1.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "ShoppingCartViewController.h"
#import "IntegralViewController.h"
#import "MeViewController.h"

#import "XGNavigationViewController.h"

@interface MainViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) HomeViewController  *homeVc;
@property (nonatomic, strong) ShoppingCartViewController  *shoppingCart;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildControllers];

    self.delegate = self;
//    [self.tabBar setTintColor:[UIColor redColor]];
    
    
    // Do any additional setup after loading the view.
}

- (void)setupChildControllers{
    
    HomeViewController *homeVc = [[HomeViewController alloc]init];
    [self setController:homeVc title:@"商城" imageNamed:@"tabbar_home_normal" selectImageNamed:@"tabbar_home_select"];

    ShoppingCartViewController *shoppingCartVc = [[ShoppingCartViewController alloc]init];
    [self setController:shoppingCartVc title:@"购物车" imageNamed:@"tabbar_shopCart_normal" selectImageNamed:@"tabbar_shopCart_select"];
    self.shoppingCart = shoppingCartVc;
    
    
    IntegralViewController *integralVc = [[IntegralViewController alloc]init];
    [self setController:integralVc title:@"积分" imageNamed:@"tabbar_integral_normal" selectImageNamed:@"tabbar_integral_select"];
    
    MeViewController *meVc = [[MeViewController alloc]init];
    [self setController:meVc title:@"我" imageNamed:@"tabbar_me_normal" selectImageNamed:@"tabbar_me_select"];
    self.selectedIndex = 0;
//    self.navigationItem.title = @"商城";
}

- (void)setController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageName selectImageNamed:(NSString *)selectedImage{
    
    vc.title    = title;
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:title image:image selectedImage:selectImage];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: THEMECOLOR} forState:UIControlStateSelected];
    
    [vc setTabBarItem:item];
    
    XGNavigationViewController *nav = [[XGNavigationViewController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//    self.navigationItem.title = item.title;

}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionFade];
    [animation setDuration:0.25];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:
                                  kCAMediaTimingFunctionEaseIn]];
    [self.view.window.layer addAnimation:animation forKey:@"fadeTransition"];
    
    return YES;
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
