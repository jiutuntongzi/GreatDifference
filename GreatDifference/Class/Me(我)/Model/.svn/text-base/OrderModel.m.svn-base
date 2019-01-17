//
//  OrderModel.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/5.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "OrderModel.h"
#import "MJExtension.h"

@implementation OrderModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"products":@"GoodsModel"};
}

- (NSString *)orderStateName{
    NSInteger state = [_orderState integerValue];
    switch (state) {
        case 0:
            return @"等待买家付款";
            break;
        case 1:
            return @"待取货";
            break;
        case 2:
            return @"已收货";
            break;
        case 3:
            return @"退货中";
            break;
        case 4:
            return @"退款中";
            break;
        case 5:
            return @"部分退货";
            break;
        case 6:
            return @"全部退货";
            break;
        case 7:
            return @"消费者取消订单";
            break;
        case 8:
            return @"商家取消订单";
            break;
        case 9:
            return @"已完成";
            break;
        default:
            break;
    }
    return _orderState;
}
@end
