//
//  MyOrderDetailViewController.h
//  GreatDifference
//
//  Created by 杨旭根 on 2016/12/4.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface MyOrderDetailViewController : UIViewController
@property (nonatomic, strong) OrderModel      *orderModel;
@property (nonatomic, copy) NSString  *orderId;
@property (nonatomic, copy) NSString  *orderType;   // 2.待收货  3.已收货  4.退款/退货

@end
