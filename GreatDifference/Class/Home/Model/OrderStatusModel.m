//
//  OrderStatusModel.m
//  GreatDifference-business
//
//  Created by xiaodou_yxg on 2017/1/12.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "OrderStatusModel.h"

@implementation OrderStatusModel

- (NSString *)type{
    NSInteger tp = [_type integerValue];
    switch (tp) {
        case 1:
            return @"下单成功";
            break;
        case 2:
            return @"支付成功";
            break;
        case 3:
            return @"消费者确认订单";
            break;
        case 4:
            return @"商家接受订单";
            break;
        case 5:
            return @"消费者取消订单";
            break;
        case 6:
            return @"商家取消订单";
            break;
        case 7:
            return @"退货申请";
            break;
        case 8:
            return @"取消退货";
            break;
        case 9:
            return @"退货驳回";
            break;
        case 10:
            return @"退款完成";
            break;
        case 11:
            return @"订单完成";
            break;
        case 12:
            return @"物流";
            break;
        default:
            break;
    }
    return _type;
}
@end
