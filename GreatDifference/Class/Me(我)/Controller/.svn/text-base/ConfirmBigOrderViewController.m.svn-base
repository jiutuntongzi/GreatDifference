//
//  ConfirmBigOrderViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/2/16.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "ConfirmBigOrderViewController.h"
#import "ConfirmOrderCell.h"
#import "ConfirmOrderPicCell.h"
#import "MyAddressCell.h"
#import "UIUtils.h"
#import "PayTypeView.h"
#import "ShippingAddressViewController.h"
#import "ShoppingHttpManager.h"
#import "PaySuccessViewController.h"

#import "ConfirmOrderBottom.h"
#import "PayOrderResult.h"

@interface ConfirmBigOrderViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *dataSource;
@property (nonatomic, strong) ConfirmOrderBottom    *bottomBar;
@property (nonatomic, strong) UITextField           *textField;
@property (nonatomic, strong) PayTypeView           *payTypeView;
@property (nonatomic, strong) UIView                *coverView;
@end

@implementation ConfirmBigOrderViewController

static NSString *cellIdentifier = @"reuseCell";
static NSString *picCellIdentifier = @"picCellIdentifier";

static NSString *addressCellId       = @"addressCell";
#pragma mark -- initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title  = @"确认订单";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.textField];
    self.textField.inputView    = self.payTypeView;
    

    WS(self);
    self.payTypeView.closeBlock = ^{
        [weakself.textField resignFirstResponder];
        [weakself.coverView removeFromSuperview];
    };
    
    self.payTypeView.didClickedPayTypeBlock = ^(id model, NSIndexPath *indexPath){
        [weakself.textField resignFirstResponder];
        [weakself.coverView removeFromSuperview];
        if (indexPath.row == 0) {
            [weakself payWithIntegral];// 余额支付
        }else if (indexPath.row == 1){
            [weakself payWithAlipay];
        }else{
            [weakself payWithWxPay];
        }
        
    };
    
    [self fetchData];
    [self.tableView reloadData];
    [self.tableView registerClass:[MyAddressCell class] forCellReuseIdentifier:addressCellId];
    [self setBottomView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(useIntegralChanged:) name:KNOTIFICATION_USE_INTEGRAL object:nil];
    
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

- (void)setBottomView{
    WS(self);
    _bottomBar = [[ConfirmOrderBottom alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    _bottomBar.bigOrder = self.bigOrder;
    [self.view addSubview:self.bottomBar];
    
    _bottomBar.confirmPayBlock = ^(id model){
        [weakself.textField becomeFirstResponder];
        [weakself.navigationController.view addSubview:weakself.coverView];
        
    };
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //    UIColor *color = THEMECOLOR;
    //    UIImage *image = [UIUtils navigationBarFromColor:color];
    //    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.clipsToBounds   = NO;
    
}

#pragma mark -- getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50) style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource   = self;
        _tableView.delegate     = self;
        
    }
    return _tableView;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.inputView = self.payTypeView;
        
    }
    return _textField;
}

- (PayTypeView *)payTypeView{
    if (!_payTypeView) {
        _payTypeView = [[PayTypeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 216)];
    }
    return _payTypeView;
}

#pragma mark -- configureData
- (void)fetchData{
    self.dataSource = [NSMutableArray array];
    
    if ([self.bigOrder.orderType isEqualToString:@"2"]) {
        //        NSMutableArray *array1 = [NSMutableArray array];
        if (self.bigOrder.consignee) {
            [self.dataSource addObject:self.bigOrder.consignee];
        }else{
            AddressModel *model = [[AddressModel alloc]init];
            [self.dataSource addObject:model];
        }
    }
    
    NSMutableArray *array2 = [NSMutableArray array];
    
//    if (self.bigOrder.orders.count) {
//        array2 = [self.bigOrder.orders mutableCopy];
//        
//    }
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setValue:@"使用积分" forKey:@"title"];
    [dic3 setValue:@"" forKey:@"detail"];
    [dic3 setValue:@"2" forKey:@"cellType"];
    [dic3 setValue:self.bigOrder.maxIntegral forKey:@"maxIntegral"];
    
    NSString *integral = [NSString stringWithFormat:@"您共有%@积分,本次可用%@积分", self.bigOrder.integral, self.bigOrder.maxIntegral];
    [dic3 setValue:integral forKey:@"placeholder"];
    
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    [dic4 setValue:@"买家留言" forKey:@"title"];
    [dic4 setValue:@"" forKey:@"detail"];
    [dic4 setValue:@"2" forKey:@"cellType"];
    [dic4 setValue:@"选填: 对本次交易的说明" forKey:@"placeholder"];
    
    NSMutableArray *array3 = [NSMutableArray array];
    
    [array3 addObject:dic3];
    [array3 addObject:dic4];
    
    [self.dataSource addObjectsFromArray:self.bigOrder.orders];
    [self.dataSource addObject:array3];
    
}

#pragma mark-- tableViewDataSource && delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.bigOrder.orderType isEqualToString:@"2"]) {
        if (section == 0) {
            return 1;
        }
    }
    
    if (section == self.dataSource.count - 1) {
        NSArray *tempArray = [self.dataSource objectAtIndex:section];
        
        return tempArray.count;
    }
    
    OrderModel *order = self.dataSource[section];
    return order.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.bigOrder.orderType isEqualToString:@"2"]) {
        if (indexPath.section == 0) {
            MyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.address = self.bigOrder.consignee;
            return cell;
        }
    }
    
    id  tempModel  = [self.dataSource objectAtIndex:indexPath.section];
    if ([tempModel isKindOfClass:[OrderModel class]]) {
        OrderModel *order = (OrderModel *)tempModel;
        GoodsModel *goods = order.products[indexPath.row];
        ConfirmOrderPicCell *cell = [tableView dequeueReusableCellWithIdentifier:picCellIdentifier];
        if (!cell) {
            cell = [[ConfirmOrderPicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:picCellIdentifier];
        }
        cell.goodsModel = goods;
        return cell;
    }else{
        
        NSDictionary *content   = [self.dataSource objectAtIndex:indexPath.section][indexPath.row];
        ConfirmOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell = [[ConfirmOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier cellType:OrderCellTypeTextField];
        
        [cell setContentDic:content];
        
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (![self.bigOrder.orderType isEqualToString:@"2"]) {
            return 90;
        }
        return 60;
    }
    
    id  tempModel  = [self.dataSource objectAtIndex:indexPath.section];
    if ([tempModel isKindOfClass:[OrderModel class]]) {
        return 90;
    }else{
        return 40;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (![self.bigOrder.orderType isEqualToString:@"2"]) {
            return 40;
        }
        return 0;
    }
    id  tempModel  = [self.dataSource objectAtIndex:section];
    if ([tempModel isKindOfClass:[OrderModel class]]) {
        return 40;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0 && [self.bigOrder.orderType isEqualToString:@"2"]) {
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
    if ([self.bigOrder.orderType isEqualToString:@"1"]) {
        return;
    }
    if (indexPath.section == 0) {
        ShippingAddressViewController *shippingAddressVc = [[ShippingAddressViewController alloc]init];
        shippingAddressVc.isSelectAddress = YES;
        [self.navigationController pushViewController:shippingAddressVc animated:YES];
        
        shippingAddressVc.selectAddressBlock = ^(AddressModel *model){
            MyAddressCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.address = model;
        };
        
    }
}
- (void)tapCoverView{
    [self.textField resignFirstResponder];
    [self.coverView removeFromSuperview];
}

/**
 余额支付
 */
- (void)payWithIntegral{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    ConfirmOrderCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    ConfirmOrderCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    
    [params setValue:self.bigOrder.orderType forKey:@"orderType"];
    [params setValue:cell.detailTextField.text forKey:@"payIntegral"];
    [params setValue:cell1.detailTextField.text forKey:@"remark"];
    [params setValue:self.bigOrder.orderId forKey:@"orderId"];
    [params setValue:@"0" forKey:@"fromUnpay"];
    [params setValue:[self.bottomBar getCurrentPrice] forKey:@"payMoney"];
    
    [HUDUtils showAlert:@"正在支付"];
    [ShoppingHttpManager IntegralPayGoodsWithParams:params success:^(PayOrderResult *responseObj) {
        [HUDUtils hideHud];
        PaySuccessViewController *paySuccessVc = [[PaySuccessViewController alloc]init];
        paySuccessVc.payOrder = responseObj.data;
        
        [self.navigationController pushViewController:paySuccessVc animated:YES];
        
    } failure:^(id responseObj, NSError *error) {
        [HUDUtils hideHud];
        NSString *message = [responseObj objectForKey:@"message"];
        [HUDUtils showAlert:message];
        
    }];
}

- (void)payWithAlipay{
    PaySuccessViewController *paySuccessVc = [[PaySuccessViewController alloc]init];
    [self.navigationController pushViewController:paySuccessVc animated:YES];
}


- (void)payWithWxPay{
    
}

- (void)useIntegralChanged:(NSNotification *)notification{
    NSString *integral = notification.object;
    float currentPrice = [self.bigOrder.orderPrice floatValue] - [integral floatValue];
    NSString *currentPriceStr = [NSString stringWithFormat:@"%.2f",currentPrice];
    [self.bottomBar setTotalPrice:currentPriceStr];
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
