//
//  PayModel.h
//  GreatDifference
//
//  Created by 杨旭根 on 2017/2/12.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignInfoModel.h"

@interface PayOrderModel : NSObject
@property (nonatomic, copy) NSString    *orderId;
@property (nonatomic, copy) NSString    *orderCode;
@property (nonatomic, copy) NSString    *orderDetails;
@property (nonatomic, copy) NSString    *notifyUrl;
@property (nonatomic, copy) NSString    *payMoney;
@property (nonatomic, copy) NSString    *discountMoney;
@property (nonatomic, copy) NSString    *signInfo;
//@property (nonatomic, strong) SignInfoModel    *signInfo;


/**
 *  支付完成返回的字段
 */
@property (nonatomic, copy) NSString  *createTime;
@property (nonatomic, copy) NSString  *orderPrice;


@end
