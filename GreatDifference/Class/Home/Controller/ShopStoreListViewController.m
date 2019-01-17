//
//  ShopStoreListViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/7.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ShopStoreListViewController.h"
#import "ShopStoreListCell.h"
#import "StoreModel.h"
#import "StoreViewController.h"
#import "UIUtils.h"
#import "HomeHttpManager.h"
#import "AddressModel.h"

#import "StoreModelListResult.h"
#import "SearchViewController.h"

@interface ShopStoreListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray  *dataSource;
@end

@implementation ShopStoreListViewController
static NSString *cellIdentifier = @"reuseCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = [NSMutableArray array];

    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[ShopStoreListCell class] forCellReuseIdentifier:cellIdentifier];


//    [self configureData];
    
    
    [self addRefreshHeader:self.tableView];
    [self addRefreshFooter:self.tableView];
    
    if (!self.shopName) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(didClickedSearchBtn:)];
    }else{
        NSMutableArray *array = [self.navigationController.viewControllers mutableCopy];
        [array removeObjectAtIndex:2];
        [self.navigationController setViewControllers:array animated:YES];
    }


    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.translucent = YES;
//    
//    UIColor *color = THEMECOLOR;
//    UIImage *image = [UIUtils navigationBarFromColor:color];
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.clipsToBounds   = NO;
    

}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)refreshDataWithMore:(BOOL)more{

//    [self endRefresh];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[NSNumber numberWithInteger:self.type] forKey:@"sellerTypeId"];
    [params setValue:self.addressModel.longitude forKey:@"longitude"];
    [params setValue:self.addressModel.latitude forKey:@"latitude"];
    [params setValue:@"1" forKey:@"pageIndex"];
    [params setValue:@"10" forKey:@"pageSize"];
    [params setValue:self.shopName forKey:@"shopName"];
    
    //    }];
    [HomeHttpManager getStoreListWithParams:params success:^(StoreModelListResult *responseObj) {
        self.dataSource = [responseObj.data mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self endRefresh];
            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        [self endRefresh];

    }];

}

#pragma mark -- tableViewDataSource && delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreModel *model = [self.dataSource objectAtIndex:indexPath.row];
    ShopStoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.storeModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreModel *storeModel = self.dataSource[indexPath.row];
    StoreViewController *storeVc    = [[StoreViewController alloc]init];
    storeVc.shopId  = storeModel.shopId;
    [self.navigationController pushViewController:storeVc animated:YES];
}

#pragma mark -- handleClickedAction
- (void)didClickedSearchBtn:(UIButton *)btn
{
    SearchViewController *searchVc = [[SearchViewController alloc]init];
    searchVc.address = self.addressModel;
    [self.navigationController pushViewController:searchVc animated:YES];
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
