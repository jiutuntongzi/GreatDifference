//
//  ConfirmOrderViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/28.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "ConfirmOrderCell.h"
#import "ConfirmOrderPicCell.h"
#import "MyAddressCell.h"
#import "UIUtils.h"
#import "PayTypeView.h"
#import "ShippingAddressViewController.h"
#import "ShoppingHttpManager.h"
#import "PaySuccessViewController.h"
#import "PayOrderResult.h"
#import "StringUtils.h"

#import "ConfirmOrderBottom.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "WeChatOrderResult.h"

@interface ConfirmOrderViewController ()<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *dataSource;
@property (nonatomic, strong) ConfirmOrderBottom    *bottomBar;
@property (nonatomic, strong) UITextField           *textField;
@property (nonatomic, strong) PayTypeView           *payTypeView;
@property (nonatomic, strong) UIView                *coverView;
@property (nonatomic, copy) NSString                *consigneeAddressId;
@property (nonatomic, strong) PayOrderModel         *payOrder;
@property (nonatomic, strong) WeChatOrderModel      *WXOrderModel;
@end

@implementation ConfirmOrderViewController
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    tap.delegate =self;
    [self.view addGestureRecognizer:tap];
        
//    }

    self.textField.inputView    = self.payTypeView;
//    self.bigOrder.consignee = nil;
    self.consigneeAddressId = self.bigOrder.consignee.consigneeAddressId;
    

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chargeSuccess:) name:kNOTIFICATION_CHARGE_SUCCESS object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chargeCancel:) name:kNOTIFICATION_CHARGE_CANCEL_PAY object:nil];

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
        UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 218)];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = XGCOLOR(236, 236, 236);
        [footer addSubview:lineView];
        _tableView.tableFooterView = footer;
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

    if (self.bigOrder.products.count) {
        array2 = [self.bigOrder.products mutableCopy];

    }
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
    
    [self.dataSource addObject:array2];
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

    NSArray *orders = self.dataSource[section];
    return orders.count;
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

    id  tempModel  = [self.dataSource objectAtIndex:indexPath.section][indexPath.row];
    if ([tempModel isKindOfClass:[GoodsModel class]]) {
        GoodsModel *goods = (GoodsModel *)tempModel;
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
    else if (indexPath.section == 1){
        if (![self.bigOrder.orderType isEqualToString:@"2"]) {
            return 40;
        }
        
        return 90;
    }else{
        return 40;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];

    if ([self.bigOrder.orderType isEqualToString:@"1"]) {
        return;
    }
    
    if (indexPath.section == 0) {
        if (self.fromOrderDetail) {
            return;
        }
        
        ShippingAddressViewController *shippingAddressVc = [[ShippingAddressViewController alloc]init];
        shippingAddressVc.isSelectAddress = YES;
        
        [self.navigationController pushViewController:shippingAddressVc animated:YES];
        
        shippingAddressVc.selectAddressBlock = ^(AddressModel *model){
            MyAddressCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            self.consigneeAddressId = model.consigneeAddressId;
            cell.address = model;
        };
        
    }
}
- (void)tapCoverView{
    [self.textField resignFirstResponder];
    [self.coverView removeFromSuperview];
}

#pragma mark -- 支付操作
/**
 余额支付
 */
- (void)payWithIntegral{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    CGFloat section = 1;
    if ([self.bigOrder.orderType isEqualToString:@"2"]) {
        if ([StringUtils isEmpty:self.consigneeAddressId]) {
            [HUDUtils showAlert:@"请选择收货人地址"];
            return;
        }
        [params setValue:self.consigneeAddressId forKey:@"consigneeAddressId"];
        section = 2;
    }
    ConfirmOrderCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    
    ConfirmOrderCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:section]];
    
    [params setValue:self.bigOrder.orderType forKey:@"orderType"];
    [params setValue:cell.detailTextField.text forKey:@"payIntegral"];
    [params setValue:cell1.detailTextField.text forKey:@"remark"];
    [params setValue:self.bigOrder.orderId forKey:@"orderId"];
    NSString *fromUnpay = @"0";
    if (self.fromOrderDetail) {
        fromUnpay = @"1";
    }
    [params setValue:fromUnpay forKey:@"fromUnpay"];
    [params setValue:[self.bottomBar getCurrentPrice] forKey:@"payMoney"];

    [HUDUtils showLoading:@"正在支付"];
    [ShoppingHttpManager IntegralPayGoodsWithParams:params success:^(PayOrderResult *responseObj) {
        [HUDUtils hideHud];
        dispatch_async(dispatch_get_main_queue(), ^{
            PaySuccessViewController *paySuccessVc = [[PaySuccessViewController alloc]init];
            paySuccessVc.payOrder = responseObj.data;
            [self.navigationController pushViewController:paySuccessVc animated:YES];
        });

    } failure:^(id responseObj, NSError *error) {
        [HUDUtils hideHud];
        
        NSString *message = [responseObj objectForKey:@"message"];
        [HUDUtils showAlert:message];
        
    }];
}

- (void)payWithAlipay{
  
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //[params setValue:self.bigOrder.orderId forKey:@"bigOrderId"];
    
    //[ShoppingHttpManager payGoodsWithParams:params success:^(BigOrderDetailResult *responseObj) {
        
    //} failure:^(id responseObj, NSError *error) {
        
   // }];
    
    CGFloat section = 1;
    if ([self.bigOrder.orderType isEqualToString:@"2"]) {
        section = 2;
        [params setValue:self.bigOrder.consignee.consigneeAddressId forKey:@"consigneeAddressId"];
    }
    ConfirmOrderCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    
    ConfirmOrderCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:section]];
    
    [params setValue:self.bigOrder.orderType forKey:@"orderType"];
    [params setValue:cell.detailTextField.text forKey:@"payIntegral"];
    [params setValue:cell1.detailTextField.text forKey:@"remark"];
    [params setValue:self.bigOrder.orderId forKey:@"orderId"];
    [params setValue:[self.bottomBar getCurrentPrice] forKey:@"payMoney"];
    [params setValue:@"2" forKey:@"payType"];
    
    NSString *fromUnpay = @"0";
    if (self.fromOrderDetail) {
        fromUnpay = @"1";
    }
    [params setValue:fromUnpay forKey:@"fromUnpay"];

//    [HUDUtils showAlert:@"正在支付"];
    [ShoppingHttpManager getAlipayPayGoodsWithParams:params success:^(PayOrderResult *responseObj) {
        [HUDUtils hideHud];
        
        PayOrderModel *pay = responseObj.data;
        self.payOrder = pay;
        NSString *signInfo  = pay.signInfo;

        
        NSString *appScheme = @"GreatDifference";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
      //  NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",

        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:signInfo fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            
            NSInteger resultCode = [[resultDic objectForKey:@"resultStatus"] integerValue];
            NSString *result = [resultDic objectForKey:@"result"];
            if (resultCode ==9000) {
                if ([result rangeOfString:@"success=\"true\""].location!=NSNotFound){
                    XGLog(@"订单支付成功");

                    PaySuccessViewController *paySuccessVc = [[PaySuccessViewController alloc]init];
                    paySuccessVc.payOrder = responseObj.data;
                    [self.navigationController pushViewController:paySuccessVc animated:YES];}else{
                    XGLog(@"订单支付失败");
//                    [self chargeFailAlert];
                }

            }
            XGLog(@"reslut = %@",resultDic);
        }];

    } failure:^(id responseObj, NSError *error) {
        [HUDUtils hideHud];
        NSString *message = [responseObj objectForKey:@"message"];
        [HUDUtils showAlert:message];
        
    }];


}


- (void)payWithWxPay{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    
    CGFloat section = 1;
    if ([self.bigOrder.orderType isEqualToString:@"2"]) {
        section = 2;
        [params setValue:self.bigOrder.consignee.consigneeAddressId forKey:@"consigneeAddressId"];
    }
    ConfirmOrderCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    
    ConfirmOrderCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:section]];
    
    [params setValue:self.bigOrder.orderType forKey:@"orderType"];
    [params setValue:cell.detailTextField.text forKey:@"payIntegral"];
    [params setValue:cell1.detailTextField.text forKey:@"remark"];
    [params setValue:self.bigOrder.orderId forKey:@"orderId"];
    [params setValue:[self.bottomBar getCurrentPrice] forKey:@"payMoney"];
    [params setValue:@"1" forKey:@"payType"];
    
    NSString *fromUnpay = @"0";
    if (self.fromOrderDetail) {
        fromUnpay = @"1";
    }
    [params setValue:fromUnpay forKey:@"fromUnpay"];
    
    //    [HUDUtils showAlert:@"正在支付"];
    [ShoppingHttpManager getWeChatPayGoodsWithParams:params success:^(WeChatOrderResult *responseObj) {
        [HUDUtils hideHud];
        WeChatOrderModel *orderModel = responseObj.data;
        self.WXOrderModel = orderModel;
        SignInfoModel *signModel = orderModel.signInfo;
        
        
        PayReq *req = [[PayReq alloc]init];
        NSInteger intStamp = [signModel.timestamp integerValue];
        
        req.partnerId = signModel.partnerid;
        req.prepayId    = signModel.prepayid;
        req.nonceStr    = signModel.noncestr;
        req.timeStamp   = (UInt32)intStamp;
        req.package     = signModel.package;
        req.sign        = signModel.sign;
//        PayOrderModel *pay = responseObj.data;
//        self.payOrder = pay;
//        NSString *signInfo  = pay.signInfo;
        
        
//        NSString *appScheme = @"GreatDifference";
        [WXApi sendReq:req];


        
    } failure:^(id responseObj, NSError *error) {
        [HUDUtils hideHud];
        NSString *message = [responseObj objectForKey:@"message"];
        [HUDUtils showAlert:message];
        
    }];
    
    

}

#pragma mark -- Notification
- (void)useIntegralChanged:(NSNotification *)notification{
    NSString *integral = notification.object;
    float currentPrice = [self.bigOrder.orderPrice floatValue] - [integral floatValue];
    NSString *currentPriceStr = [NSString stringWithFormat:@"%.2f",currentPrice];
    [self.bottomBar setTotalPrice:currentPriceStr];
}

- (void)chargeSuccess:(NSNotification *)notification{
    
    PaySuccessViewController *paySuccessVc = [[PaySuccessViewController alloc]init];
    self.payOrder = [[PayOrderModel alloc]init];
    self.payOrder.createTime = self.WXOrderModel.createTime;
    self.payOrder.orderCode = self.WXOrderModel.orderCode;
    self.payOrder.orderPrice = self.WXOrderModel.payMoney;
    paySuccessVc.payOrder = self.payOrder;
    
    [self.navigationController pushViewController:paySuccessVc animated:YES];
}

- (void)chargeCancel:(NSNotification *)notification{
    
}

- (void)tapAction{
    [self.view endEditing:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
        
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
