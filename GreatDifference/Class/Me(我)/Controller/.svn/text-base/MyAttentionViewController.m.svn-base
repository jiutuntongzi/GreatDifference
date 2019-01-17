//
//  MyAttentionViewController.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/11/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MyAttentionViewController.h"
#import "VTMagic.h"
#import "StoreCartViewController.h"
#import "OnlineStoreCartViewController.h"
#import "StoreModel.h"

#import "MyCollectGoodsViewController.h"
#import "MyCollectStoreViewController.h"

@interface MyAttentionViewController ()<VTMagicViewDataSource, VTMagicViewDelegate>
@property (nonatomic, strong) VTMagicController                 *magicController;
@property (nonatomic, strong) NSArray                           *menuList;
@property (nonatomic, strong) StoreCartViewController           *storeCartVc;
@property (nonatomic, strong) OnlineStoreCartViewController     *onlineStoreVc;
@property (nonatomic, strong) UIView                            *navigationBarView;

@end

@implementation MyAttentionViewController
- (void)testAction{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = nil;
    [self addChildViewController:self.magicController];
    [self.view addSubview:_magicController.view];
    _magicController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 0);
    [_magicController.magicView reloadData];
    
//    UIView *backgroundView = [[self.navigationController valueForKey:@"_navigationBar"] valueForKey:@"_backgroundView"];
//    backgroundView.backgroundColor = XGCOLOR(255, 255, 255); // 颜色自己选
//    backgroundView.alpha = 0; // 做渐变最好再设置一下
//    backgroundView.userInteractionEnabled = YES;
//    self.navigationBarView = backgroundView;

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    //    self.bckView.backgroundColor = XGCOLOR(255, 255, 255);
//    self.navigationBarView.alpha = 0;
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    self.navigationController.navigationBarHidden = NO;
    //    self.bckView.backgroundColor = THEMECOLOR;
//    self.navigationBarView.alpha = 1.0;
    
}

#pragma mark -- getter
- (VTMagicController *)magicController{
    if (!_magicController) {
        _magicController = [[VTMagicController alloc]init];
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.sliderColor = THEMECOLOR;
        _magicController.magicView.layoutStyle = VTLayoutStyleCenter;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.sliderWidth = 75;
        _magicController.magicView.navigationHeight = 44.f;
        _magicController.magicView.againstStatusBar = YES;
        _magicController.magicView.scrollEnabled    = NO;
        _magicController.magicView.dataSource = self;
        UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 32, 32)];
        back.tag = 100;
//        back.backgroundColor = [UIColor redColor];
        [back setImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
        [back addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];

        _magicController.magicView.leftNavigatoinItem = back;
        _magicController.magicView.delegate = self;
        //        _magicController.
    }
    return _magicController;
}

- (NSArray *)menuList{
    if (!_menuList) {
        _menuList = @[@"商品", @"店铺"];
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
    if (0 == pageIndex) {
        static NSString *recomId = @"recom.identifier";
        MyCollectGoodsViewController *recomViewController = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!recomViewController) {
            recomViewController = [[MyCollectGoodsViewController alloc] init];
        }
//        self.storeCartVc = recomViewController;
        
        return recomViewController;
    }
    
    static NSString *gridId = @"grid.identifier";
    MyCollectStoreViewController *gridViewController = [magicView dequeueReusablePageWithIdentifier:gridId];
    if (!gridViewController) {
        gridViewController = [[MyCollectStoreViewController alloc] init];
    }
//    self.onlineStoreVc = gridViewController;
    
    return gridViewController;
}

- (void)backAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
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
