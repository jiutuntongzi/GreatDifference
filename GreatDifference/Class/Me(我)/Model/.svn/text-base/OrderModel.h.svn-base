//
//  OrderModel.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/5.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"
#import "StoreModel.h"

@interface OrderModel : NSObject
@property (nonatomic, copy) NSString  *orderno;
@property (nonatomic, copy) NSString  *state;
@property (nonatomic, strong) NSArray   *data;


/** 接口中对应的字段**/
@property (nonatomic, copy) NSString    *orderId;
@property (nonatomic, copy) NSString    *shopId;
@property (nonatomic, copy) NSString    *shopName;

@property (nonatomic, copy) NSString    *buyerId;
@property (nonatomic, copy) NSString    *buyerName;
@property (nonatomic, copy) NSString    *orderCode; //订单号
@property (nonatomic, copy) NSString    *orderPrice;
@property (nonatomic, copy) NSString    *existsChangeProduct;

/**
 *  订单状态；1-待取货（支付成功）；2-已收货；3-退货中；4-退款中；5-部分退货；6-全部退货；7-消费者取消订单；8-商家取消订单；9-已完成；
 状态显示：
 1-显示确认收货、取消订单按钮；
 2-显示退货（商城订单消费者确认后）、再次购买按钮；
 3-取消退货按钮；
 4-无任何按钮；
 5/6/7/8/9-删除订单、再次购买按钮；
 */
@property (nonatomic, copy) NSString    *orderState;
@property (nonatomic, copy) NSString    *createTime;    //下单时间
@property (nonatomic, copy) NSString    *applicationTime;
@property (nonatomic, copy) NSString    *buyerComplete;
@property (nonatomic, copy) NSString    *buyerHeadImgUrl;
@property (nonatomic, copy) NSString    *sellerComplete;  // 商家确认订单；1-已确认；0-未确认；
@property (nonatomic, copy) NSString    *hasEvalute;    // 是否已评价；1-已评价；0-未评价；



@property (nonatomic, copy) NSString        *payMoney;
@property (nonatomic, copy) NSString        *payIntegral;
@property (nonatomic, copy) NSString        *commonIntegral;    //奖励通用积分数量
@property (nonatomic, copy) NSString        *mallIntegral;    //奖励商城积分数量
@property (nonatomic, copy) NSString        *returnMoney;       //返还用户现金
@property (nonatomic, copy) NSString        *returnIntegral;    //返还用户积分
@property (nonatomic, copy) NSString        *returnReason;     //取消订单/退货原因
@property (nonatomic, copy) NSString        *returnCommonIntegral;     //返还平台普通积分
@property (nonatomic, copy) NSString        *returnMallIntegral;     //返还平台商城积分
@property (nonatomic, copy) NSString        *returnFeeSplitting;     //返还用户分润
@property (nonatomic, copy) NSString        *expressName;     //快递公司
@property (nonatomic, copy) NSString        *expressNo;     //快递单号

@property (nonatomic, strong) NSMutableArray    *products;

/**
 *  订单详情里额外的字段
 */

//@property (nonatomic, copy) NSString  *commonIntegral;
//@property (nonatomic, copy) NSString  *mallIntegral;
@property (nonatomic, copy) NSString  *consignee;
@property (nonatomic, copy) NSString  *mob;
@property (nonatomic, copy) NSString  *province;
@property (nonatomic, copy) NSString  *city;
@property (nonatomic, copy) NSString  *district;
@property (nonatomic, copy) NSString  *address;
@property (nonatomic, copy) NSString  *remark;
@property (nonatomic, copy) NSString  *sellerCompleteTime;
@property (nonatomic, copy) NSString  *buyerCompleteTime;
@property (nonatomic, copy) NSString  *canReturn;
@property (nonatomic, copy) NSString  *goodsNum;
@property (nonatomic, copy) NSString  *orderType;   //  订单类型；1-普通订单；2-海淘订单；

@property (nonatomic, assign) BOOL    isSelect;

- (NSString *)orderStateName;
@end
