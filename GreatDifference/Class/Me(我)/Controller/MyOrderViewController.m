//
//  MyOrderViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/2.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyAllOrderViewController.h"
#import "WaitRecevieViewController.h"
#import "WaitPayViewController.h"
#import "FinishOrderViewController.h"
#import "HadReceiveViewController.h"
#import "RefundViewController.h"

#import "VTMagic.h"

@interface MyOrderViewController ()<VTMagicViewDataSource, VTMagicViewDelegate>
@property (nonatomic, strong) NSMutableArray   *dataSource;
@property (nonatomic, strong) VTMagicController                 *magicController;
@property (nonatomic, strong) NSArray                           *menuList;
//@property (nonatomic, assign) NSInteger                         currentIndex;

@end

@implementation MyOrderViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    [self addChildViewController:self.magicController];
    [self.view addSubview:_magicController.view];
    _magicController.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    [_magicController.magicView reloadData];
//    self.magicController.currentPage = self.currentIndex;
    [self.magicController switchToPage:self.currentIndex animated:YES];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

#pragma mark -- getter
- (VTMagicController *)magicController{
    if (!_magicController) {
        _magicController = [[VTMagicController alloc]init];
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.sliderColor = THEMECOLOR;
        _magicController.magicView.layoutStyle = VTLayoutStyleDefault;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.sliderWidth = 75;
        _magicController.magicView.navigationHeight = 40.f;
        _magicController.magicView.againstStatusBar = NO;
        _magicController.magicView.scrollEnabled    = NO;
        _magicController.magicView.menuScrollEnabled    = YES;

        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        
    }
    return _magicController;
}

- (NSArray *)menuList{
    if (!_menuList) {
        _menuList = @[@"全部", @"待付款", @"待收货", @"已收货", @"退款/退货", @"已完成"];
    }
    return _menuList;
}

#pragma mark -- VTMagicViewDataSource

- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    return self.menuList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:RGBCOLOR(50, 50, 50) forState:UIControlStateNormal];
        [menuItem setTitleColor:THEMECOLOR forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {

    UIViewController *vc;
    switch (pageIndex) {
        case 0:
        {
            static NSString *recomId = @"all.identifier";
            vc = [magicView dequeueReusablePageWithIdentifier:recomId];
            if (!vc) {
                vc = [[MyAllOrderViewController alloc] init];
            }
            
            return vc;
        }
            break;
        case 1:
        {
            static NSString *waitPayId = @"waitPay.identifier";
            vc = [magicView dequeueReusablePageWithIdentifier:waitPayId];
            if (!vc) {
                vc = [[WaitPayViewController alloc] init];
            }
            
            return vc;
        }
            break;
        case 2:
        {
            static NSString *gridId = @"waitReceive.identifier";
            vc = [magicView dequeueReusablePageWithIdentifier:gridId];
            if (!vc) {
                vc = [[WaitRecevieViewController alloc] init];
            }
            
            return vc;
        }
            break;
        case 3:
        {
            static NSString *waitPayId = @"hadReceive.identifier";
            vc = [magicView dequeueReusablePageWithIdentifier:waitPayId];
            if (!vc) {
                vc = [[HadReceiveViewController alloc] init];
            }
            
            return vc;
        }
            break;
        case 4:
        {
            static NSString *gridId = @"refund.identifier";
            vc = [magicView dequeueReusablePageWithIdentifier:gridId];
            if (!vc) {
                vc = [[RefundViewController alloc] init];
            }
            
            return vc;
        }
            break;
        case 5:
        {
            static NSString *gridId = @"finishOrder.identifier";
            vc = [magicView dequeueReusablePageWithIdentifier:gridId];
            if (!vc) {
                vc = [[FinishOrderViewController alloc] init];
            }
            
            return vc;
        }
            break;

    }
    return vc;
    

}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex{
//    self.currentIndex = itemIndex;
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
