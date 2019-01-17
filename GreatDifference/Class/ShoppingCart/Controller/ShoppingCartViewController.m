//
//  ShoppingCartViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 16/11/1.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartCell.h"
#import "VTMagic.h"
#import "BottomView.h"

#import "StoreCartViewController.h"
#import "OnlineStoreCartViewController.h"
#import "StoreModel.h"

@interface ShoppingCartViewController ()<VTMagicViewDataSource, VTMagicViewDelegate>
@property (nonatomic, strong) UITableView                       *tableView;
@property (nonatomic, strong) NSMutableArray                    *dataSource;
@property (nonatomic, strong) VTMagicController                 *magicController;
@property (nonatomic, strong) NSArray                           *menuList;
@property (nonatomic, assign) NSInteger                         currentIndex;
@property (nonatomic, strong) StoreCartViewController           *storeCartVc;
@property (nonatomic, strong) OnlineStoreCartViewController     *onlineStoreVc;
@property (nonatomic, weak) BottomView                         *bottomeView;
@property (nonatomic, strong) UIBarButtonItem                         *editBtn;

@end

@implementation ShoppingCartViewController
static NSString *cellIdentifier = @"reuseCell";
#pragma mark -- initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentIndex = 0;
    [self addChildViewController:self.magicController];
    [self.view addSubview:_magicController.view];
    _magicController.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    [_magicController.magicView reloadData];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedEditAction:)];
    self.editBtn = self.navigationItem.rightBarButtonItem;
    
//    BottomView *bottomView = [[BottomView alloc]init];
//    bottomView.delegate     = self;
//    [self.view addSubview:bottomView];
//    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
//        make.height.equalTo(@45);
//    }];
//    self.bottomeView = bottomView;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelAllSelect) name:KNOTIFICATION_SHOPCART_CANCEL_ALL object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(allSelect) name:KNOTIFICATION_SHOPCART_SELECT_ALL object:nil];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.currentIndex == 0) {
        self.storeCartVc.bottomeView.showDeleteBtn = NO;
        [self.editBtn setTitle:@"编辑"];
    }else{
        self.onlineStoreVc.bottomeView.showDeleteBtn = NO;
        [self.editBtn setTitle:@"编辑"];
  
    }
}


#pragma mark -- getter
- (VTMagicController *)magicController{
    if (!_magicController) {
        _magicController = [[VTMagicController alloc]init];
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.sliderColor = THEMECOLOR;
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.sliderWidth = 75;
        _magicController.magicView.navigationHeight = 40.f;
        _magicController.magicView.againstStatusBar = NO;
        _magicController.magicView.scrollEnabled    = NO;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
//        _magicController.
    }
    return _magicController;
}

//- (UIButton *)editBtn{
//    if (!_editBtn) {
//        _editBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 25)];
//        
//    }
//    return _editBtn;
//}

- (NSArray *)menuList{
    if (!_menuList) {
        _menuList = @[@"实体店", @"海淘商城"];
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
        StoreCartViewController *storeCartVc = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!storeCartVc) {
            storeCartVc = [[StoreCartViewController alloc] init];
        }
        self.storeCartVc = storeCartVc;
        storeCartVc.fromGoodsDetail = self.fromGoodsDetail;
        return storeCartVc;
    }
    
    static NSString *gridId = @"grid.identifier";
    OnlineStoreCartViewController *onlineStoreVc = [magicView dequeueReusablePageWithIdentifier:gridId];
    if (!onlineStoreVc) {
        onlineStoreVc = [[OnlineStoreCartViewController alloc] init];
    }
    self.onlineStoreVc = onlineStoreVc;
    onlineStoreVc.fromGoodsDetail = self.fromGoodsDetail;
    return onlineStoreVc;
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex{
    self.currentIndex = itemIndex;
//    [self didClickedEditAction:nil];
    [self.navigationItem.rightBarButtonItem setTitle:@"编辑"];
    if (itemIndex == 0) {
        self.onlineStoreVc.bottomeView.showDeleteBtn = NO;
        [self.onlineStoreVc cancelAllSelect];

    }else{
        self.storeCartVc.bottomeView.showDeleteBtn = NO;
        [self.storeCartVc cancelAllSelect];
    }
}

- (void)didClickedEditAction:(UIBarButtonItem *)btn{

    if (self.currentIndex == 0) {
        if (!self.storeCartVc.bottomeView.showDeleteBtn) {
            self.storeCartVc.bottomeView.showDeleteBtn = YES;
            [btn setTitle:@"完成"];
        }else{
            self.storeCartVc.bottomeView.showDeleteBtn = NO;
            [btn setTitle:@"编辑"];

        }
    }else{
        if (!self.onlineStoreVc.bottomeView.showDeleteBtn) {
            self.onlineStoreVc.bottomeView.showDeleteBtn = YES;
            [btn setTitle:@"完成"];
        }else{
            self.onlineStoreVc.bottomeView.showDeleteBtn = NO;
            [btn setTitle:@"编辑"];
            
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
