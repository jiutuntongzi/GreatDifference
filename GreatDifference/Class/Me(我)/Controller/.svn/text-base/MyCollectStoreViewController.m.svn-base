//
//  MyCollectStoreViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/18.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MyCollectStoreViewController.h"
#import "StoreModel.h"
#import "MyCollectGoodsCell.h"
#import "PullDownMenu.h"
#import "StoreModel.h"
#import "PersonalHttpManager.h"
#import "StoreModelListResult.h"
#import "StoreViewController.h"
#import "HomeHttpManager.h"

@interface MyCollectStoreViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataSource;
@property (nonatomic, strong) NSMutableArray    *menuArray;
@property (nonatomic, copy) NSString            *sellerTypeId;

@end

@implementation MyCollectStoreViewController
static NSString *cellIdentifier = @"reuseCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    [self addRefreshHeader:self.tableView];
    [self addRefreshFooter:self.tableView];
    
    self.dataSource  = [NSMutableArray array];
    [self.tableView registerClass:[MyCollectGoodsCell class] forCellReuseIdentifier:cellIdentifier];

    
    [PersonalHttpManager getCollectStoreTypeListWithParams:nil success:^(StoreModelListResult *responseObj) {
        
        
        PullDownMenu *menu = [[PullDownMenu alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) menuTitleArray:@[@"全部"]];
        [menu setDataSource:responseObj.data];
        menu.callBack = ^(NSString *storeTypeId){
            self.sellerTypeId = storeTypeId;
            [self refreshDataWithMore:NO];
        };
        [self.view addSubview:menu];
    } failure:^(id responseObj, NSError *error) {
        
    }];

    // Do any additional setup after loading the view.
}

- (void)refreshDataWithMore:(BOOL)more{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"1" forKey:@"pageIndex"];
    [params setValue:@"10" forKey:@"pageSize"];
    [params setValue:@"" forKey:@"longitude"];
    [params setValue:@"" forKey:@"latitude"];
    [params setValue:self.sellerTypeId forKey:@"sellerTypeId"];
    
    [PersonalHttpManager getCollectStoreListWithParams:params success:^(StoreModelListResult *responseObj) {
        self.dataSource = [responseObj.data mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self endRefresh];
            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self endRefresh];
        });
    }];
}

#pragma mark -- getter
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
        StoreModel *model = [[StoreModel alloc]init];
        model.name  = @"全部店铺";
        model.isSelect  = YES;
        
        StoreModel *model1 = [[StoreModel alloc]init];
        model1.name  = @"便利店";
        model1.isSelect  = NO;
        
        StoreModel *model2 = [[StoreModel alloc]init];
        model2.name  = @"母婴店";
        model2.isSelect  = NO;
        
        StoreModel *model3 = [[StoreModel alloc]init];
        model3.name  = @"美食";
        model3.isSelect  = NO;
        
        StoreModel *model4 = [[StoreModel alloc]init];
        model4.name  = @"海淘商城";
        model4.isSelect  = NO;
        
        [_menuArray addObject:model];
        [_menuArray addObject:model1];
        [_menuArray addObject:model2];
        [_menuArray addObject:model3];
        [_menuArray addObject:model4];
        
    }
    return _menuArray;
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
    StoreViewController *storeVc = [[StoreViewController alloc]init];
    storeVc.shopId = model.shopId;
    [self.navigationController setNavigationBarHidden:NO];

    [self.navigationController pushViewController:storeVc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        StoreModel *storeModel = [self.dataSource objectAtIndex:indexPath.row];

        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:storeModel.shopId forKey:@"shopId"];
        [HomeHttpManager collectStoreWithParams:param success:^(CommonModelResult *responseObj) {
            [self.dataSource removeObject:storeModel];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            });
        }
            failure:^(id responseObj, NSError *error) {
            
        }];

//        [self.tableView reloadData];
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
