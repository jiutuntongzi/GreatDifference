//
//  BigOrderDetailViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/27.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "BigOrderDetailViewController.h"
#import "OrderDetailTopCell.h"
#import "MyOrderCell.h"
#import "MyAddressCell.h"
#import "ShopingCartHeaderView.h"
#import "OrderDetailFooterView.h"
#import "OrderDetailBottomView.h"
#import "PersonalHttpManager.h"
#import "OrderDetailResult.h"
#import "BigOrderDetailResult.h"
#import "ConfirmBigOrderViewController.h"
#import "PersonalHttpManager.h"
#import "ConfirmOrderViewController.h"

@interface BigOrderDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *dataSource;
@property (nonatomic, strong) OrderListModel        *bigOrderDetail;
@end

@implementation BigOrderDetailViewController
static NSString *topCellId              = @"topCellId";
static NSString *addressCellId          = @"addressCellId";
static NSString *orderCellId            = @"bigOrderCellId";
static NSString *sectionHeaderId        = @"sectionHeaderId";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[OrderDetailTopCell class] forCellReuseIdentifier:topCellId];
    [self.tableView registerClass:[MyAddressCell class] forCellReuseIdentifier:addressCellId];
    [self.tableView registerClass:[ShopingCartHeaderView class] forHeaderFooterViewReuseIdentifier:sectionHeaderId];
    
    [self fetchData];
    
    
    // Do any additional setup after loading the view.
}

- (void)setupFooterView{
    
    OrderDetailFooterView *footer = [[OrderDetailFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    footer.backgroundColor = [UIColor whiteColor];
    footer.bigOrder = self.bigOrderDetail;
    self.tableView.tableFooterView  = footer;
    
    OrderDetailBottomView *bottomView = [[OrderDetailBottomView alloc]initWithFrame:CGRectMake(1, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    [self.view addSubview:bottomView];
    bottomView.OrderOperationBlock = ^(OrderOperationType type){
        if (type == OrderOperationTypeCancel) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定取消订单吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.delegate = self;
            [alertView show];
            
//            [HUDUtils showAlert:@"点击了取消订单按钮"];
        }else if (type == OrderOperationTypePay){
            
            
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setValue:self.bigOrderId forKey:@"bigOrderId"];
//
            [PersonalHttpManager getUnPayOrderDetailWithParams:param success:^(BigOrderDetailResult *responseObj) {
                ConfirmOrderViewController *confirmOrderVc = [[ConfirmOrderViewController alloc]init];
                confirmOrderVc.bigOrder = responseObj.data;
                confirmOrderVc.fromOrderDetail = YES;
                [self.navigationController pushViewController:confirmOrderVc animated:YES];
            } failure:^(id responseObj, NSError *error) {
                
            }];
            
//            ConfirmBigOrderViewController *confirmOrderVc = [[ConfirmBigOrderViewController alloc]init];
//            confirmOrderVc.bigOrder = self.bigOrderDetail;
//            [self.navigationController pushViewController:confirmOrderVc animated:YES];
            
//            [HUDUtils showAlert:@"点击了付款按钮"];
        }
    };
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [HUDUtils showLoading:@"正在取消订单"];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:self.bigOrderDetail.bigOrderId forKey:@"bigOrderId"];
        
        [PersonalHttpManager cancelBigOrderWithParams:param success:^(CommonModelResult *responseObj) {
            dispatch_async(dispatch_get_main_queue(), ^{

                [HUDUtils hideHud];
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_WAIT_ORDERS object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            });
        } failure:^(id responseObj, NSError *error) {
            [HUDUtils hideHud];
            [HUDUtils showError:@"取消失败"];
        }];
    }
}


- (void)fetchData{

        NSMutableDictionary *param1 = [NSMutableDictionary dictionary];
        [param1 setValue:self.bigOrderId forKey:@"bigOrderId"];
        [PersonalHttpManager getMyBigOrderDetailWithParams:param1 success:^(BigOrderDetailResult *responseObj) {
            self.bigOrderDetail = responseObj.data;
            [self createDataSourceWithBigOrder:self.bigOrderDetail];
            [self setupFooterView];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } failure:^(id responseObj, NSError *error) {
            
        }];
        
}

- (void)createDataSourceWithBigOrder:(OrderListModel *)orderDetail{
    

    [self.dataSource addObject:orderDetail];
    if ([orderDetail.orderType isEqualToString:@"2"]) {
        AddressModel *model = [[AddressModel alloc]init];
        [self.dataSource addObject:model];
    }
    [self.dataSource addObjectsFromArray:orderDetail.orders];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource   = self;
        _tableView.tableFooterView  = [UIView new];
        _tableView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35];
        
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    
    if ([self.bigOrderDetail.orderType isEqualToString:@"2"]) {
        if (section == 1) {
            return 1;
        }
    }
    OrderModel *order = self.dataSource[section];
    return order.products.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        OrderDetailTopCell *cell = [tableView dequeueReusableCellWithIdentifier:topCellId];
        OrderListModel *bigOrder = self.dataSource[indexPath.section];
        cell.orderListModel = bigOrder;
        return cell;
    }
    id  tempModel  = [self.dataSource objectAtIndex:indexPath.section];
    if ([tempModel isKindOfClass:[AddressModel class]]) {
//        GoodsModel *goods = (AddressModel *)tempModel;
        MyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCellId];
        OrderListModel *bigOrder = self.dataSource[indexPath.section];
        cell.orderListModel = bigOrder;
        return cell;
    }
    else{
        
        OrderModel *orderModel = self.dataSource[indexPath.section];
        GoodsModel *goods = orderModel.products[indexPath.row];
        MyOrderCell
        *cell = [tableView dequeueReusableCellWithIdentifier:orderCellId];
        if (cell == nil) {
            cell = [[MyOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCellId];
        }
        [cell configCellWithModel:goods];
        
        return cell;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 70;
    }else if (indexPath.section == 1){
        return 70;
    }
    
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    if (section == 1) {
        if ([self.bigOrderDetail.orderType isEqualToString:@"2"]) {
            return 0;
        }
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section<1) {
        return nil;
    }
    OrderModel *order = self.dataSource[section];
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 20)];
    titleLabel.font = XGFONT(14);
    [header addSubview:titleLabel];
    titleLabel.text = order.shopName;
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle != UITableViewCellEditingStyleDelete) {
        return;
    }
    OrderModel *order = self.dataSource[indexPath.section];
    GoodsModel *goodsModel = order.products[indexPath.row];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:goodsModel.orderProductId forKey:@"orderProductId"];
    [params setValue:self.bigOrderDetail.bigOrderId forKey:@"bigOrderId"];
    
    [PersonalHttpManager deleteBigOrderProductsWithParams:params success:^(CommonModelResult *responseObj) {
        [order.products removeObject:goodsModel];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } failure:^(id responseObj, NSError *error) {
        
    }];
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
