//
//  OrderDetailBottomView.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/7.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OrderOperationType) {
    OrderOperationTypeCancel = 100,   // 取消订单
    OrderOperationTypeModify,         // 修改地址
    OrderOperationTypePay,            // 付款
};
@interface OrderDetailBottomView : UIView

@property (nonatomic, strong) UIButton         *cancelOrderBtn;
@property (nonatomic, strong) UIButton         *payBtn;
@property (nonatomic, copy) void(^OrderOperationBlock)(OrderOperationType type);

@end
