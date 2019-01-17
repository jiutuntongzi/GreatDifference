//
//  LifeServiceViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/1/17.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "LifeServiceViewController.h"
#import "StoreModel.h"
#import "MyCollectGoodsCell.h"
#import "PullDownMenu.h"
#import "StoreTypeModel.h"
#import "HomeHttpManager.h"
#import "StoreModelListResult.h"
#import "AddressModel.h"
#import "StoreViewController.h"

@interface LifeServiceViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) NSMutableArray      *dataSource;
@property (nonatomic, strong) NSMutableArray      *menuArray;

@end

@implementation LifeServiceViewController
static NSString *cellIdentifier = @"reuseCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"生活服务";
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[MyCollectGoodsCell class] forCellReuseIdentifier:cellIdentifier];
    // Do any additional setup after loading the view.
    
    [self addRefreshHeader:self.tableView];
    [self addRefreshFooter:self.tableView];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.sellerTypeId forKey:@"sellerTypeId"];
    
    [HomeHttpManager getLifeServiceTypeListWithParams:params success:^(StoreModelListResult *responseObj) {
        
        PullDownMenu *menu = [[PullDownMenu alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40) menuTitleArray:@[@"全部店铺"]];
        [menu setDataSource:responseObj.data];
        menu.callBack = ^(NSString *storeTypeId){
            self.sellerTypeId = storeTypeId;
            [self refreshDataWithMore:NO];
        };
        [self.view addSubview:menu];

    } failure:^(id responseObj, NSError *error) {
        
    }];
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - 40) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSMutableArray *)menuArray{
    if (!_menuArray) {
        _menuArray = [NSMutableArray array];
        StoreTypeModel *model = [[StoreTypeModel alloc]init];
        model.name  = @"全部店铺";
        model.numbers   = @"";
        model.isSelect  = YES;
        
        StoreTypeModel *model1 = [[StoreTypeModel alloc]init];
        model1.name  = @"便利店";
        model1.numbers   = @"6";
        model1.isSelect  = NO;
        
        StoreTypeModel *model2 = [[StoreTypeModel alloc]init];
        model2.name  = @"母婴店";
        model2.numbers   = @"4";
        model2.isSelect  = NO;
        
        StoreTypeModel *model3 = [[StoreTypeModel alloc]init];
        model3.name  = @"美食";
        model3.numbers   = @"7";
        model3.isSelect  = NO;
        
        StoreTypeModel *model4 = [[StoreTypeModel alloc]init];
        model4.name  = @"海淘商城";
        model4.numbers   = @"1";
        model4.isSelect  = NO;
        
        [_menuArray addObject:model];
        [_menuArray addObject:model1];
        [_menuArray addObject:model2];
        [_menuArray addObject:model3];
        [_menuArray addObject:model4];
        
    }
    return _menuArray;
}

- (void)refreshDataWithMore:(BOOL)more{
    
    //    [self endRefresh];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.sellerTypeId forKey:@"sellerTypeId"];
    [params setValue:self.addressModel.longitude forKey:@"longitude"];
    [params setValue:self.addressModel.latitude forKey:@"latitude"];
    [params setValue:@"1" forKey:@"pageIndex"];
    [params setValue:@"10" forKey:@"pageSize"];
    
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
    MyCollectGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.storeModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"取消关注";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreModel *model = [self.dataSource objectAtIndex:indexPath.row];

    StoreViewController *shopStoreVc = [[StoreViewController alloc]init];
    shopStoreVc.shopId = model.shopId;
    [self.navigationController pushViewController:shopStoreVc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        GoodsModel *model = [self.dataSource objectAtIndex:indexPath.row];
        [self.dataSource removeObject:model];
        [self.tableView reloadData];
    }
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
