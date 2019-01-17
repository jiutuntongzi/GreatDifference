//
//  RefundViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/26.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "RefundViewController.h"
#import "MyAllOrderOutCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "ApplyForRefundViewController.h"
#import "PersonalHttpManager.h"
#import "OrderLIstResult.h"
#import "MyOrderDetailViewController.h"

@interface RefundViewController ()<UITableViewDataSource, UITableViewDelegate, OrderOutCellDelegate>
@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, strong) NSMutableArray   *dataSource;
@property (nonatomic, assign) NSInteger        page;


@end

@implementation RefundViewController
static NSString *cellIdentifier         = @"refundCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MyAllOrderOutCell class] forCellReuseIdentifier:cellIdentifier];
    
    [self addRefreshHeader:self.tableView];
    [self addRefreshFooter:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDataWithMore:) name:KNOTIFICATION_REFRESH_REFUND_ORDERS object:nil];
//    [self refreshDataWithMore:NO];

    // Do any additional setup after loading the view.
}

- (void)refreshDataWithMore:(BOOL)more{
    if (!more) {
        self.page = 1;
    }else{
        self.page++;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"4" forKey:@"orderState"];
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

- (void)didClickedOrder:(OrderModel *)order atIndexPath:(NSIndexPath *)indexPath{
    MyOrderDetailViewController *orderDetailVc = [[MyOrderDetailViewController alloc]init];
    orderDetailVc.orderId = order.orderId;
    orderDetailVc.orderType = @"4";
    orderDetailVc.orderModel = order;
    [self.navigationController pushViewController:orderDetailVc animated:YES];
}

- (void)tableView:(UITableView *)tableView didClickedConfirmReceive:(OrderModel *)orderModel{
    ApplyForRefundViewController *refundVc = [[ApplyForRefundViewController alloc]init];
    [self.navigationController pushViewController:refundVc animated:YES];
    
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
