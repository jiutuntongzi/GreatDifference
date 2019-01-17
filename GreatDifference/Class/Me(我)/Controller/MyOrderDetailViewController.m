//
//  MyOrderDetailViewController.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/12/4.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MyOrderDetailViewController.h"
#import "OrderDetailTopCell.h"
#import "MyOrderCell.h"
#import "MyAddressCell.h"
#import "ShopingCartHeaderView.h"
#import "OrderDetailFooterView.h"
#import "OrderDetailBottomView.h"
#import "PersonalHttpManager.h"
#import "OrderDetailResult.h"
#import "BigOrderDetailResult.h"
#import "ApplyForRefundViewController.h"
#import "BindCardViewController.h"
#import "ShopEvaluationViewController.h"
#import "LogisticsCell.h"
#import "CancelOrderCell.h"
#import "OrderStateViewController.h"

@interface MyOrderDetailViewController ()<UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *dataSource;
@property (nonatomic, strong) OrderModel            *orderDetail;
@property (nonatomic, strong) OrderListModel        *bigOrderDetail;
@property (nonatomic, strong) NSMutableArray        *selectArray;
@property (nonatomic, strong) OrderDetailBottomView *bottomView;

@property (nonatomic, copy) NSString           *reasonStr;
@property (nonatomic, strong) UITextField      *tapTextField;

@property (nonatomic, strong) NSArray         *pickerDataSource;
@property (nonatomic, strong) UIView          *pickerAccessoryView;

@property (nonatomic, strong) UIPickerView    *pickerView;
@property (nonatomic, assign) NSInteger        page;
@property (nonatomic, strong) UIView                *coverView;
@end

@implementation MyOrderDetailViewController

static NSString *topCellId              = @"topCellId";
static NSString *logisticsCellId        = @"logisticsCellId";
static NSString *cancelOrderId            = @"cancelOrderId";

static NSString *addressCellId          = @"addressCellId";
static NSString *orderCellId            = @"orderCellId";
static NSString *bigOrderCellId            = @"bigOrderCellId";

static NSString *sectionHeaderId        = @"sectionHeaderId";

#pragma mark -- initialization(初始化)
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.tapTextField];

    [self.tableView registerClass:[OrderDetailTopCell class] forCellReuseIdentifier:topCellId];
    [self.tableView registerClass:[LogisticsCell  class] forCellReuseIdentifier:logisticsCellId];
    [self.tableView registerClass:[CancelOrderCell  class] forCellReuseIdentifier:cancelOrderId];
    [self.tableView registerClass:[MyAddressCell class] forCellReuseIdentifier:addressCellId];
    [self.tableView registerClass:[ShopingCartHeaderView class] forHeaderFooterViewReuseIdentifier:sectionHeaderId];
    
    [self fetchData];
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"订单状态" style:UIBarButtonItemStylePlain target:self action: @selector(orderStateList)];
    
    // Do any additional setup after loading the view.
}

- (void)orderStateList{
    OrderStateViewController *orderStateVc = [[OrderStateViewController alloc]init];
    orderStateVc.orderId = self.orderId;
    [self.navigationController pushViewController:orderStateVc animated:YES];
}

- (void)setupFooterView{
    
    OrderDetailFooterView *footer = [[OrderDetailFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    footer.orderModel = self.orderDetail;
    footer.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView  = footer;
    
    OrderDetailBottomView *bottomView = [[OrderDetailBottomView alloc]initWithFrame:CGRectMake(1, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    self.bottomView = bottomView;
    [self.view addSubview:bottomView];
    if ([self.orderType isEqualToString:@"2"]) {
        [bottomView.payBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        if ([self.orderModel.sellerComplete isEqualToString:@"1"]) {
            bottomView.cancelOrderBtn.hidden = YES;
        }
    }else if ([self.orderType isEqualToString:@"3"]){
        [bottomView.payBtn setTitle:@"评价" forState:UIControlStateNormal];
        [bottomView.cancelOrderBtn setTitle:@"退货" forState:UIControlStateNormal];
        
        if ([self.orderModel.orderType isEqualToString:@"1"]) {
            bottomView.cancelOrderBtn.hidden = YES;
//            bottomView.hidden = YES;
            self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

//            bottomView
        }
    }
    else if ([self.orderType isEqualToString:@"4"]){
        [bottomView.payBtn setTitle:@"取消退货" forState:UIControlStateNormal];
        bottomView.cancelOrderBtn.hidden = YES;
        
        if ([self.orderModel.orderState isEqualToString:@"4"]) {
            bottomView.payBtn.hidden = YES;
            self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            bottomView.hidden = YES;
        }
        
        if ([self.orderModel.orderState isEqualToString:@"5"] || [self.orderModel.orderState isEqualToString:@"6"] || [self.orderModel.orderState isEqualToString:@"7"] || [self.orderModel.orderState isEqualToString:@"8"]) {
            self.bottomView.payBtn.hidden = YES;
            bottomView.cancelOrderBtn.hidden = NO;
            [bottomView.cancelOrderBtn setTitle:@"删除订单" forState:UIControlStateNormal];

            [bottomView.cancelOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bottomView).offset(10);
                make.right.equalTo(bottomView).offset(-10);
                make.height.mas_equalTo(25);
                make.width.mas_equalTo(70);
            }];
        }

        
        
    }
    else if ([self.orderType isEqualToString:@"5"]){
        [bottomView.payBtn setTitle:@"评价" forState:UIControlStateNormal];
        [bottomView.cancelOrderBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        self.orderDetail.hasEvalute = @"1";
        if ([self.orderDetail.hasEvalute isEqualToString:@"1"]) {
            self.bottomView.payBtn.hidden = YES;
            [bottomView.cancelOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bottomView).offset(10);
                make.right.equalTo(bottomView).offset(-10);
                make.height.mas_equalTo(25);
                make.width.mas_equalTo(70);
            }];
        }
        
    }
    bottomView.OrderOperationBlock = ^(OrderOperationType type){
        if (type == OrderOperationTypeCancel) {
//            [HUDUtils showAlert:@"点击了取消订单按钮"];
            switch ([self.orderType integerValue]) {
                case 2:
                    [self cancelOrder];
                    break;
                case 3:
                    [self refundOrder]; //退货
                    break;
                case 4:
//                    [self cancelRefund]; //取消退货
                    [self deleteOrder];
                    break;
                case 5:
                    [self deleteOrder];// 删除订单
                    break;
                default:
                    break;
            }
        }else if (type == OrderOperationTypePay){
            switch ([self.orderType integerValue]) {
                case 2:
                    [self confirmReceive];
                    break;
                case 3:
                    [self evaluateOrder]; //评价
                    break;
                case 4:
                    [self cancelRefund]; //取消退货
                    break;
                case 5:
                    [self evaluateOrder];
                    break;
                default:
                    break;
            }
//            [HUDUtils showAlert:@"点击了付款按钮"];
        }
    };
}

#pragma mark -- configureData
- (void)fetchData{
//    if (self.orderId) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:self.orderId forKey:@"orderId"];
        [PersonalHttpManager getMyOrderDetailWithParams:param success:^(OrderDetailResult *responseObj) {
            self.orderDetail = responseObj.data;
            [self createDataSource:self.orderDetail];
            [self setupFooterView];
    
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } failure:^(id responseObj, NSError *error) {
            NSString *message = responseObj[@"message"];
            [HUDUtils showAlert:message];
        }];
}

- (void)createDataSource:(OrderModel *)orderDetail{
    if (!orderDetail) {
        return;
    }
    [self.dataSource addObject:orderDetail];
    if ([self.orderModel.orderType isEqualToString:@"2"]) {
//        AddressModel *address = [[AddressModel alloc]init];
        [self.dataSource addObject:orderDetail];
    }
    
    if ([self.orderType isEqualToString:@"4"]) {
        [self.dataSource addObject:orderDetail];

    }
    
    if (!orderDetail.products.count) {
        return;
    }
    [self.dataSource addObject:orderDetail.products];
}

//- (void)createDataSourceWithBigOrder:(OrderListModel *)orderDetail{
//
//    [self.dataSource addObject:orderDetail];
//    [self.dataSource addObject:orderDetail];
//    [self.dataSource addObjectsFromArray:orderDetail.orders];
//}

#pragma mark -- getter
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

// 选中的商品
- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
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

#pragma mark -- tableViewDataSource && Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == self.dataSource.count - 1) {
        NSArray *tempArray = self.dataSource[section];
        return tempArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        OrderDetailTopCell *cell = [tableView dequeueReusableCellWithIdentifier:topCellId];
        OrderModel *order = self.dataSource[indexPath.section];
        cell.orderModel = order;
        return cell;
    }
    
    if ([self.orderType isEqualToString:@"4"]&& indexPath.section == 1) {
        if ([self.orderModel.orderState isEqualToString:@"3"]) {
            LogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:logisticsCellId];
            OrderModel *order = self.dataSource[indexPath.section];
            cell.orderModel = order;
            return cell;
        }
        CancelOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cancelOrderId];
        OrderModel *order = self.dataSource[indexPath.section];
        cell.orderModel = order;
        return cell;
    }else{
    
        if (([self.orderModel.orderType isEqualToString:@"2"]&&indexPath.section == 1) || (indexPath.section == 2&& [self.orderModel.orderType isEqualToString:@"2"]&&[self.orderType isEqualToString:@"4"])){
            
            MyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCellId];
            OrderModel *order = self.dataSource[indexPath.section];
            cell.orderDetail = order;
            return cell;
            
            //            if (indexPath.section == 1) {
            //
            //                MyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCellId];
            //                OrderModel *order = self.dataSource[indexPath.section];
            //                cell.orderDetail = order;
            //                return cell;
            //            }
            //        }
            
        }else{
            
            GoodsModel *goods = self.dataSource[indexPath.section][indexPath.row];
            NSString *cellId = bigOrderCellId;
            if ([self.orderType isEqualToString:@"3"]&&[self.orderModel.orderType isEqualToString:@"2"]) {
                cellId = orderCellId;
            }
            MyOrderCell
            *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[MyOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            [cell configCellWithModel:goods];
            
            __weak typeof(MyOrderCell *)weakCell = cell;
            cell.didClickedGoodsBlock = ^(GoodsModel *model){
                
                if (model.isSelect) {
                    [self.selectArray addObject: model];
                    //                [self.selectIndexs addObject:model];
                }else{
                    [self.selectArray removeObject:model];
                    //                [self.selectIndexs removeObject:model];
                }
                [weakCell configCellWithModel:model];
                NSArray *tempArray = self.dataSource[indexPath.section];
                
                if (self.selectArray.count == tempArray.count) {
                    //                OrderModel.isSelect = YES;
                    //                ShopingCartHeaderView *sectionView = (ShopingCartHeaderView *)[tableView headerViewForSection:indexPath.section];
                    //                sectionView.storeModel = storeModel;
                    //                [self.selectStores addObject:storeModel];
                    self.orderDetail.isSelect = YES;
                    ShopingCartHeaderView *sectionView = (ShopingCartHeaderView *)[tableView headerViewForSection:indexPath.section];
                    sectionView.orderModel = self.orderDetail;
                    
                }else{
                    self.orderDetail.isSelect = NO;
                    ShopingCartHeaderView *sectionView = (ShopingCartHeaderView *)[tableView headerViewForSection:indexPath.section];
                    sectionView.orderModel = self.orderDetail;
                }
                
            };
            return cell;
            
        }

    }
//    OrderModel *order = self.dataSource[indexPath.section];

//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 130;
    }else if (indexPath.section == 1){
        if ([self.orderType isEqualToString:@"4"]) {
            if ([self.orderModel.orderState isEqualToString:@"3"]) {
                return 190;
            }
            return 150;
        }
        if ([self.orderModel.orderType isEqualToString:@"2"]) {
            return 60;
        }
        return 90;
    }else if (indexPath.section == 2){
//        if ([self.orderType isEqualToString:@"4"]) {
//            return 60;
//        }
        return 90;
    }
    
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == self.dataSource.count - 1) {
        return 40;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *header = [[UIView alloc]init];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 20)];
    titleLabel.text =  self.orderDetail.shopName;
    [header addSubview:titleLabel];
    if ([self.orderType isEqualToString:@"3"]&& [self.orderModel.orderType isEqualToString:@"2"]) {
        ShopingCartHeaderView *shopHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionHeaderId];
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        shopHeader.backgroundView = view;
        shopHeader.orderModel = self.orderDetail;
        shopHeader.sectionBlock = ^(BOOL isSelect){
            self.orderDetail.isSelect = !self.orderDetail.isSelect;

            [self.orderDetail.products enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                GoodsModel *goods = (GoodsModel *)obj;
                goods.isSelect = NO;
                if (self.orderDetail.isSelect) {
                    goods.isSelect = YES;
                }
            }];
            
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];

        };
        return shopHeader;
    }
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

#pragma mark -- ClickedAction(点击事件)
- (void)confirmReceive{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认收货吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.delegate = self;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if ([self.orderType isEqualToString:@"2"]) {
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setValue:self.orderModel.orderId forKey:@"orderId"];
            [PersonalHttpManager confirmReceiveOrderWithParams:param success:^(CommonModelResult *responseObj) {
               dispatch_async(dispatch_get_main_queue(), ^{
                   [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_WAIT_RECEIVE_ORDERS object:nil];
                   [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_ALL_ORDERS object:nil];
                   [self.navigationController popViewControllerAnimated:YES];
               });

            } failure:^(id responseObj, NSError *error) {
                
            }];
        }else if ([self.orderType isEqualToString:@"3"]){
            if (buttonIndex == 1) {
                BindCardViewController *completeVc = [[BindCardViewController alloc]init];
                [self.navigationController pushViewController:completeVc animated:YES];
            }
        }else if ([self.orderType isEqualToString:@"4"]){
            if (buttonIndex == 1) {
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                [params setValue:self.orderModel.orderId forKey:@"orderId"];
                
                [PersonalHttpManager cancelRefundOrderWithParams:params success:^(CommonModelResult *responseObj) {
                    [HUDUtils showAlert:@"取消退货成功"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_REFUND_ORDERS object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_ALL_ORDERS object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                } failure:^(id responseObj, NSError *error) {
                    XGLog(@"取消退货失败");
                }];
//                BindCardViewController *completeVc = [[BindCardViewController alloc]init];
//                [self.navigationController pushViewController:completeVc animated:YES];
            }
        }else if ([self.orderType isEqualToString:@"5"]){
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setValue:self.orderModel.orderId forKey:@"orderId"];
            
            [PersonalHttpManager deleteMyOrderWithParams:params success:^(CommonModelResult *responseObj) {
                XGLog(@"删除订单成功");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_FINISH_ORDERS object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_ALL_ORDERS object:nil];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                });

            } failure:^(id responseObj, NSError *error) {
                XGLog(@"删除订单失败");

            }];
        }

    }
}

/**
 *  取消订单
 */
- (void)cancelOrder{
    
    [self.tapTextField becomeFirstResponder];
    [self.navigationController.view addSubview:self.coverView];
}

// 退货
- (void)refundOrder{
    
    if ([self.orderModel.canReturn isEqualToString:@"2"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未完善善银行卡信息,需完善信息才可完成退货" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去完善", nil];
        alert.delegate = self;
        [alert show];
        return;
    }
    
    if ([self.orderModel.canReturn isEqualToString:@"0"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请直接联系商家退货,谢谢" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    ApplyForRefundViewController *refundVc = [[ApplyForRefundViewController alloc]init];
    refundVc.Order = self.orderModel;
    refundVc.selectArrays = self.selectArray;
    [self.navigationController pushViewController:refundVc animated:YES];
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 1) {
//        BindCardViewController *completeVc = [[BindCardViewController alloc]init];
//        [self.navigationController pushViewController:completeVc animated:YES];
//    }
//}


// 取消退货
- (void)cancelRefund{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确认取消退货吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.delegate = self;
    [alert show];
}

- (void)deleteOrder{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认删除订单?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.delegate = self;
    [alert show];

}

- (void)evaluateOrder{
    ShopEvaluationViewController *evaluateVc = [[ShopEvaluationViewController alloc]init];
    evaluateVc.orderId = self.orderId;
    [self.navigationController pushViewController:evaluateVc animated:YES];
}


#pragma mark -- clickedAction
- (void)finishAction:(UIButton *)btn
{
    [self.tapTextField resignFirstResponder];
    [self.coverView removeFromSuperview];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setValue:self.orderModel.orderId forKey:@"orderId"];
    [params setValue:self.reasonStr forKey:@"returnReason"];
    
    [PersonalHttpManager cancelMyOrderWithParams:params success:^(CommonModelResult *responseObj) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_WAIT_RECEIVE_ORDERS object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_ALL_ORDERS object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(id responseObj, NSError *error) {
        
    }];
    
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
