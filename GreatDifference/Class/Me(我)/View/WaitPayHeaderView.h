//
//  WaitPayHeaderView.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/5.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface WaitPayHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) OrderModel      *orderModel;
@end
