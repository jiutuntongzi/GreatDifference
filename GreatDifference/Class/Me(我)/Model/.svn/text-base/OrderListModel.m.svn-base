//
//  OrderListModel.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/12/24.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "OrderListModel.h"
#import "MJExtension.h"
#import "OrderModel.h"
#import "GoodsModel.h"

@implementation OrderListModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"orders":@"OrderModel", @"products":@"GoodsModel"};
}


- (NSString *)getOrderStateName{
    if ([_bigOrderState isEqualToString:@"1"]) {
        return @"等待买家付款";
    }else if ([_bigOrderState isEqualToString:@"2"]) {
        return @"支付中";
    }else if ([_bigOrderState isEqualToString:@"3"]) {
        return @"支付失败";
    }
    else if ([_bigOrderState isEqualToString:@"4"]) {
        return @"支付成功";
    }
    return _bigOrderState;
}

@end
