//
//  MyCollectGoodsViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/18.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MyCollectGoodsViewController.h"
#import "MyCollectGoodsCell.h"
#import "GoodsDetailViewController.h"

#import "PersonalHttpManager.h"
#import "GoodsModelListResult.h"
#import "HomeHttpManager.h"

@interface MyCollectGoodsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataSource;
@end

@implementation MyCollectGoodsViewController
static NSString *cellIdentifier = @"reuseCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.dataSource  = [NSMutableArray array];
    [self.tableView registerClass:[MyCollectGoodsCell class] forCellReuseIdentifier:cellIdentifier];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"1" forKey:@"pageIndex"];
    [params setValue:@"10" forKey:@"pageSize"];
    
    [PersonalHttpManager getCollectGoodsListWithParams:params success:^(GoodsModelListResult *responseObj) {
        self.dataSource = [responseObj.data mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        
    }];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsModel *model = [self.dataSource objectAtIndex:indexPath.row];
    MyCollectGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.goodsModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"取消关注";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsModel *goodsModel = [self.dataSource objectAtIndex:indexPath.row];
    GoodsDetailViewController *goodsDetailVc = [[GoodsDetailViewController alloc]init];
    goodsDetailVc.productId = goodsModel.productId;
    [self.navigationController setNavigationBarHidden:NO];

    [self.navigationController pushViewController:goodsDetailVc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        GoodsModel *goodsModel = [self.dataSource objectAtIndex:indexPath.row];
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:goodsModel.productId forKey:@"productId"];
        [HomeHttpManager collectGoodsWithParams:param success:^(CommonModelResult *responseObj) {
//            self.bottomBar.collectBtn.selected = !self.bottomBar.collectBtn.selected;
            [self.dataSource removeObject:goodsModel];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];


        } failure:^(id responseObj, NSError *error) {
            
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
