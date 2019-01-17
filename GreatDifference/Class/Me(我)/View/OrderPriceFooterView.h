//
//  OrderPriceFooterView.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/2/9.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderModel;
@interface OrderPriceFooterView : UITableViewHeaderFooterView
@property (nonatomic, strong) OrderModel      *orderModel;

@end
