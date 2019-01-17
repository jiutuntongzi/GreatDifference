//
//  OrderListModel.h
//  GreatDifference
//
//  Created by 杨旭根 on 2016/12/24.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"

@interface OrderListModel : NSObject
/** 接口中对应的字段**/
@property (nonatomic, copy) NSString    *bigOrderId;
@property (nonatomic, copy) NSString    *orderId;

@property (nonatomic, copy) NSString    *bigOrderCode;
@property (nonatomic, copy) NSString    *orderPrice;
/**
 大订单状态；1-未支付；2-支付中；3-支付失败；4-支付成功；
 1和3- 显示支付按钮；
 2- 显示商家订单列表；
 4- 显示商家订单列表；
 */
@property (nonatomic, copy) NSString    *bigOrderState;
@property (nonatomic, copy) NSString    *payMoney;
@property (nonatomic, copy) NSString    *payIntegral;
@property (nonatomic, copy) NSString    *createTime;
@property (nonatomic, copy) NSString    *payType;
@property (nonatomic, copy) NSString    *orderType; // 订单类型；1-普通订单；2-海淘订单；

@property (nonatomic, copy) NSString    *siteOrderCode;

@property (nonatomic, strong) NSArray   *orders;

//提交商品生成订单
@property (nonatomic, strong) NSArray       *products;
@property (nonatomic, copy) NSString        *integral;
@property (nonatomic, copy) NSString        *maxIntegral;
@property (nonatomic, copy) NSString        *money;
@property (nonatomic, copy) NSString        *goodsNum;
@property (nonatomic, copy) NSString        *existsChangeProduct;


/**
 *  生成订单时返回的推荐收件人
 *
 *  @return 只有海淘有
 */

@property (nonatomic, strong) AddressModel      *consignee;

- (NSString *)getOrderStateName;
@end
