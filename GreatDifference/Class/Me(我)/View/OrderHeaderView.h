//
//  OrderHeaderView.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/2.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

@interface OrderHeaderView : UIView
@property (nonatomic, strong) OrderListModel      *orderListModel;
@property (nonatomic, strong) UILabel             *shopNameLabel;

@end
