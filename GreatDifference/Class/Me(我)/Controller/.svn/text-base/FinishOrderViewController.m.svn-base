//
//  FinishOrderViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/6.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "FinishOrderViewController.h"
#import "MyAllOrderOutCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "OrderModel.h"
#import "ApplyForRefundViewController.h"
#import "ShopEvaluationViewController.h"
#import "StoreModel.h"
#import "PersonalHttpManager.h"
#import "OrderLIstResult.h"
#import "MyOrderDetailViewController.h"

@interface FinishOrderViewController ()<UITableViewDataSource, UITableViewDelegate, OrderOutCellDelegate>
@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, strong) NSMutableArray   *dataSource;
@property (nonatomic, assign) NSInteger        page;

@end

@implementation FinishOrderViewController
static NSString *cellIdentifier         = @"finishOrderCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MyAllOrderOutCell class] forCellReuseIdentifier:cellIdentifier];
    [self addRefreshHeader:self.tableView];
    [self addRefreshFooter:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDataWithMore:) name:KNOTIFICATION_REFRESH_FINISH_ORDERS object:nil];

    // Do any additional setup after loading the view.
}

- (void)refreshDataWithMore:(BOOL)more{
    if (!more) {
        self.page = 1;
    }else{
        self.page++;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"5" forKey:@"orderState"];
    [params setValue:[NSNumber numberWithInteger:self.page] forKey:@"pageIndex"];
    
    [params setValue:@"10" forKey:@"pageSize"];
    
    [PersonalHttpManager getMyOrderListWithParams:params success:^(OrderLIstResult *responseObj) {
        if (!more) {
            self.dataSource = [responseObj.data mutableCopy];
        }else{
            [self.dataSource addObjectsFromArray:responseObj.data];
        }
        [self endRefresh];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        [self endRefresh];
        
        NSString *message= [responseObj objectForKey:@"message"];
        XGLog(@"%@" ,message);
    }];

}


#pragma mark -- getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark -- tableViewDataSource && delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListModel *model = [self.dataSource objectAtIndex:indexPath.row];
    MyAllOrderOutCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.delegate = self;
    [cell setOrderListModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    CGFloat height = [MyAllOrderOutCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        MyAllOrderOutCell *cell = (MyAllOrderOutCell *)sourceCell;
        [cell setOrderListModel:model];
    }];
    return height;
}


#pragma mark -- OrderOutCellDelegate
- (void)tableView:(UITableView *)tableView didClickedRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

// 删除订单
- (void)tableView:(UITableView *)tableView didClickedCancelOrder:(OrderModel *)orderModel{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定删除此订单吗" preferredStyle:UIAlertControllerStyleAlert];
                                          
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:orderModel.orderId forKey:@"orderId"];
        
        [PersonalHttpManager deleteMyOrderWithParams:params success:^(CommonModelResult *responseObj) {
            XGLog(@"删除订单成功");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self refreshDataWithMore:NO];
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_ALL_ORDERS object:nil];
                
            });
        } failure:^(id responseObj, NSError *error) {
            XGLog(@"删除订单失败");
            
        }];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)didClickedOrder:(OrderModel *)order atIndexPath:(NSIndexPath *)indexPath{
    MyOrderDetailViewController *orderDetailVc = [[MyOrderDetailViewController alloc]init];
    orderDetailVc.orderId = order.orderId;
    orderDetailVc.orderType = @"5";
    orderDetailVc.orderModel    = order;
    [self.navigationController pushViewController:orderDetailVc animated:YES];
}

// 评价
- (void)tableView:(UITableView *)tableView didClickedConfirmReceive:(OrderModel *)orderModel{
    ShopEvaluationViewController *shopEvaluationVc = [[ShopEvaluationViewController alloc]init];
    shopEvaluationVc.orderId = orderModel.orderId;
    [self.navigationController pushViewController:shopEvaluationVc animated:YES];
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
