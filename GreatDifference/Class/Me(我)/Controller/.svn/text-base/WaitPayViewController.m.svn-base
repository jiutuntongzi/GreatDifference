//
//  WaitPayViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/6.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "WaitPayViewController.h"
#import "MyAllOrderOutCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "BigOrderDetailViewController.h"
#import "ApplyForRefundViewController.h"
#import "PersonalHttpManager.h"

#import "OrderModel.h"
#import "OrderLIstResult.h"

@interface WaitPayViewController ()<UITableViewDataSource, UITableViewDelegate , OrderOutCellDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, strong) NSMutableArray   *dataSource;
@property (nonatomic, strong) OrderListModel   *orderListModel;
@property (nonatomic, copy) NSString           *reasonStr;
@property (nonatomic, strong) UITextField      *tapTextField;

@property (nonatomic, strong) NSArray         *pickerDataSource;
@property (nonatomic, strong) UIView          *pickerAccessoryView;

@property (nonatomic, strong) UIPickerView    *pickerView;
@property (nonatomic, assign) NSInteger        page;

@end

@implementation WaitPayViewController
static NSString *cellIdentifier         = @"waitPayCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.tapTextField];
    
    [self.tableView registerClass:[MyAllOrderOutCell class] forCellReuseIdentifier:cellIdentifier];
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setValue:@"1" forKey:@"orderState"];
//    [params setValue:@"1" forKey:@"pageIndex"];
//    
//    [params setValue:@"10" forKey:@"pageSize"];
//    
//    [PersonalHttpManager getMyOrderListWithParams:params success:^(OrderLIstResult *responseObj) {
//        self.dataSource = [responseObj.data mutableCopy];
////        [self.dataSource removeLastObject];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//        });
//    } failure:^(id responseObj, NSError *error) {
//        
//    }];
    
    [self addRefreshHeader:self.tableView];
    [self addRefreshFooter:self.tableView];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDataWithMore:) name:KNOTIFICATION_REFRESH_WAIT_ORDERS object:nil];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshDataWithMore:NO];
}

- (void)refreshDataWithMore:(BOOL)more{
    if (!more) {
        self.page = 1;
    }else{
        self.page++;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"1" forKey:@"orderState"];
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

#pragma mark -- tableViewDataSource && delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListModel *model = [self.dataSource objectAtIndex:indexPath.row];
    MyAllOrderOutCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell setOrderListModel:model];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    CGFloat height = [MyAllOrderOutCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        MyAllOrderOutCell *cell = (MyAllOrderOutCell *)sourceCell;
        [cell setOrderListModel:model];
    }];
    XGLog(@"tableView的高度为:%lf", height);
    return height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


#pragma mark -- OrderOutCellDelegate
- (void)didClickedBigOrder:(OrderListModel *)order atIndexPath:(NSIndexPath *)indexPath{
    
    if ([order.existsChangeProduct isEqualToString:@"1"]) {
        return;
    }
    BigOrderDetailViewController *orderDetailVc = [[BigOrderDetailViewController alloc]init];
    orderDetailVc.bigOrderId   = order.bigOrderId;
    [self.navigationController pushViewController:orderDetailVc animated:YES];
}
//取消大订单
- (void)tableView:(UITableView *)tableView didClickedCancelBigOrder:(OrderListModel *)orderModel{

    self.orderListModel = orderModel;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定取消订单吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate = self;
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [HUDUtils showLoading:@"正在取消订单"];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:self.orderListModel.bigOrderId forKey:@"bigOrderId"];
        
        [PersonalHttpManager cancelBigOrderWithParams:param success:^(CommonModelResult *responseObj) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDUtils hideHud];
                [self refreshDataWithMore:NO];
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_ALL_ORDERS object:nil];
            });
        } failure:^(id responseObj, NSError *error) {
            [HUDUtils hideHud];
            [HUDUtils showError:@"取消失败"];
        }];
    }
}

// 付款
- (void)tableView:(UITableView *)tableView didClickedPayBtn:(OrderListModel *)orderModel{
    BigOrderDetailViewController *orderDetailVc = [[BigOrderDetailViewController alloc]init];
    orderDetailVc.bigOrderId   = orderModel.bigOrderId;

    [self.navigationController pushViewController:orderDetailVc animated:YES];
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
