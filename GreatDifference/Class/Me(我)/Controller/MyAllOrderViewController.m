//
//  MyAllOrderViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/5.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MyAllOrderViewController.h"
#import "MyAllOrderOutCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "PersonalHttpManager.h"
#import "BigOrderDetailViewController.h"
#import "MyOrderDetailViewController.h"
#import "ApplyForRefundViewController.h"
#import "ShopEvaluationViewController.h"
#import "StoreDetailViewController.h"

#import "OrderModel.h"
#import "OrderLIstResult.h"

@interface MyAllOrderViewController ()<UITableViewDataSource, UITableViewDelegate, OrderOutCellDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, strong) NSMutableArray   *dataSource;
@property (nonatomic, strong) UITextField      *tapTextField;

@property (nonatomic, strong) NSArray         *pickerDataSource;
@property (nonatomic, strong) UIView          *pickerAccessoryView;

@property (nonatomic, strong) UIPickerView    *pickerView;

@property (nonatomic, copy) NSString           *reasonStr;
@property (nonatomic, strong) OrderListModel   *orderListModel;
@property (nonatomic, strong) OrderModel       *orderModel;
@property (nonatomic, assign) NSInteger        page;
@property (nonatomic, strong) UIView                *coverView;

@end

@implementation MyAllOrderViewController
static NSString *cellIdentifier            = @"waitPayCell";
static NSString *waitReceiveCellId         = @"waitReceiveCell";
static NSString *finishOrderCellId         = @"finishOrderCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.tapTextField];
    
    [self.tableView registerClass:[MyAllOrderOutCell class]
           forCellReuseIdentifier:cellIdentifier];
    [self.tableView registerClass:[MyAllOrderOutCell class] forCellReuseIdentifier:waitReceiveCellId];

    [self.tableView registerClass:[MyAllOrderOutCell class] forCellReuseIdentifier:finishOrderCellId];

    // Do any additional setup after loading the view.
    [self addRefreshHeader:self.tableView];
    [self addRefreshFooter:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDataWithMore:) name:KNOTIFICATION_REFRESH_ALL_ORDERS object:nil];
    self.reasonStr = [self.pickerDataSource firstObject];
}

- (void)refreshDataWithMore:(BOOL)more{
    if (!more) {
        self.page = 1;
    }else{
        self.page++;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"0" forKey:@"orderState"];
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

- (UITextField *)tapTextField{
    if (!_tapTextField) {
        _tapTextField = [UITextField new];
        _tapTextField.inputView = self.pickerView;
        _tapTextField.inputAccessoryView = self.pickerAccessoryView;
    }
    return _tapTextField;
}

- (NSArray *)pickerDataSource{
    if (!_pickerDataSource) {
        _pickerDataSource = @[@"我不想买了", @"信息填写错误,重新拍", @"卖家缺货", @"同城见面交易", @"其他原因"];
    }
    return _pickerDataSource;
}

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UIView *)pickerAccessoryView
{
    if (!_pickerAccessoryView) {
        _pickerAccessoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        _pickerAccessoryView.backgroundColor = [UIColor grayColor];
        
        UIButton *finishBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 10, 50, 25)];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [finishBtn addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
        [_pickerAccessoryView addSubview:finishBtn];
    }
    return _pickerAccessoryView;
}


- (UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc]initWithFrame:self.view.bounds];
        _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
        _coverView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCoverView)];
        [_coverView addGestureRecognizer:tap];
        //        _coverView.hidden = YES;
    }
    return _coverView;
}


#pragma mark -- tableViewDataSource && delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListModel *model = [self.dataSource objectAtIndex:indexPath.row];
    MyAllOrderOutCell *cell;
    if ([model.bigOrderState isEqualToString:@"1"]) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }else if ([model.bigOrderState isEqualToString:@"2"]){
        cell = [tableView dequeueReusableCellWithIdentifier:waitReceiveCellId];

    }else if ([model.bigOrderState isEqualToString:@"4"]){
        cell = [tableView dequeueReusableCellWithIdentifier:finishOrderCellId];
 
    }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark -- UIPickerViewDataSource && delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerDataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.pickerDataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *content = self.pickerDataSource[row];
    self.reasonStr = content;
}

#pragma mark -- clickedAction 取消小订单
- (void)finishAction:(UIButton *)btn
{
    [self.tapTextField resignFirstResponder];
    [self.coverView removeFromSuperview];

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setValue:self.orderModel.orderId forKey:@"orderId"];
    [params setValue:self.reasonStr forKey:@"returnReason"];
    
    [PersonalHttpManager cancelMyOrderWithParams:params success:^(CommonModelResult *responseObj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshDataWithMore:NO];

            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_WAIT_RECEIVE_ORDERS object:nil];

        });
    } failure:^(id responseObj, NSError *error) {
        
    }];
    
}

#pragma mark -- OrderOutCellDelegate
/**
 *  点击了小订单
 */
- (void)didClickedOrder:(OrderModel *)order atIndexPath:(NSIndexPath *)indexPath{
    MyOrderDetailViewController *orderDetailVc = [[MyOrderDetailViewController alloc]init];
    orderDetailVc.orderId = order.orderId;
    orderDetailVc.orderModel = order;
    NSString *type = @"2";
    if ([order.orderState isEqualToString:@"1"]) {
        type = @"2";
    }else if ([order.orderState isEqualToString:@"2"]) {
        type = @"3";
    }else if ([order.orderState isEqualToString:@"9"]){
        type = @"5";
    }else{
        type = @"4";
    }
    orderDetailVc.orderType = type;
    [self.navigationController pushViewController:orderDetailVc animated:YES];
}

/**
 *  点击了大订单
 */
- (void)didClickedBigOrder:(OrderListModel *)bigOrder atIndexPath:(NSIndexPath *)indexPath{
    BigOrderDetailViewController *orderDetailVc = [[BigOrderDetailViewController alloc]init];
    orderDetailVc.bigOrderId   = bigOrder.bigOrderId;
    [self.navigationController pushViewController:orderDetailVc animated:YES];
}

/**
 *  取消大订单   待支付
 *
 *  @param tableView  tableView
 *  @param orderModel 大订单
 */
- (void)tableView:(UITableView *)tableView didClickedCancelBigOrder:(OrderListModel *)orderListModel{
    self.orderListModel = orderListModel;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定取消订单吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate = self;
    alertView.tag = 100;
    [alertView show];
}

/**
 *  取消小订单
 *
 *  @param tableView  tableView
 *  @param orderModel 大订单
 */
- (void)tableView:(UITableView *)tableView didClickedCancelOrder:(OrderModel *)orderModel{
    self.orderModel = orderModel;
    if ([orderModel.orderState isEqualToString:@"9"]) {
        
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

        return;
    }
//    [self.tapTextField becomeFirstResponder];
//    
//    [self.navigationController.view addSubview:self.coverView];
    
    if ([orderModel.orderType isEqualToString:@"2"]) {
        self.orderModel = orderModel;
        [self.tapTextField becomeFirstResponder];
        [self.navigationController.view addSubview:self.coverView];
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请直接联系店家线下处理" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *lookupAction = [UIAlertAction actionWithTitle:@"查看店铺信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        StoreDetailViewController *storeDetailVc = [[StoreDetailViewController alloc]init];
        storeDetailVc.shopId = orderModel.shopId;
        [self.navigationController pushViewController:storeDetailVc animated:YES];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:lookupAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

- (void)tableView:(UITableView *)tableView didClickedConfirmReceive:(OrderModel *)orderModel{
    self.orderModel = orderModel;
//    if ([orderModel.orderState isEqualToString:@"9"]) {
//
//        ShopEvaluationViewController *shopEvaluationVc = [[ShopEvaluationViewController alloc]init];
//        shopEvaluationVc.orderId = orderModel.orderId;
//        [self.navigationController pushViewController:shopEvaluationVc animated:YES];
//        return;
//    }
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认收货吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.delegate = self;
    alertView.tag = 101;
    [alertView show];
}

- (void)tableView:(UITableView *)tableView didClickedEvaluateBtn:(OrderModel *)orderModel{
    
    ShopEvaluationViewController *shopEvaluationVc = [[ShopEvaluationViewController alloc]init];
    shopEvaluationVc.orderId = orderModel.orderId;
    [self.navigationController pushViewController:shopEvaluationVc animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if (alertView.tag == 100) { // 取消待支付
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setValue:self.orderListModel.bigOrderId forKey:@"bigOrderId"];
    
            [PersonalHttpManager cancelBigOrderWithParams:param success:^(CommonModelResult *responseObj) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [HUDUtils hideHud];
                    [self refreshDataWithMore:NO];
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_WAIT_ORDERS object:nil];

                });
            } failure:^(id responseObj, NSError *error) {
                [HUDUtils hideHud];
                [HUDUtils showError:@"取消失败"];
            }];

        }else{
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setValue:self.orderModel.orderId forKey:@"orderId"];
            [PersonalHttpManager confirmReceiveOrderWithParams:param success:^(CommonModelResult *responseObj) {
                
            } failure:^(id responseObj, NSError *error) {
                
            }];
        }

    }
}

- (void)tableView:(UITableView *)tableView didClickedRefundBtn:(OrderModel *)orderModel{
    ApplyForRefundViewController *refundVc = [[ApplyForRefundViewController alloc]init];
    refundVc.Order = orderModel;
    [self.navigationController pushViewController:refundVc animated:YES];
}

- (void)tableView:(UITableView *)tableView didClickedPayBtn:(OrderListModel *)orderModel{
    BigOrderDetailViewController *orderDetailVc = [[BigOrderDetailViewController alloc]init];
    orderDetailVc.bigOrderId = orderModel.bigOrderId;
    [self.navigationController pushViewController:orderDetailVc animated:YES];
}


- (void)tapCoverView{
    [self.tapTextField resignFirstResponder];
    [self.coverView removeFromSuperview];
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
