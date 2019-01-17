//
//  ConfirmOrderBottom.h
//  GreatDifference
//
//  Created by 杨旭根 on 2016/12/4.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

@interface ConfirmOrderBottom : UIView
@property (nonatomic, strong) OrderListModel  *bigOrder;

@property (nonatomic, copy) void (^confirmPayBlock)(id model);

- (void)setTotalPrice:(NSString *)price;
- (NSString *)getCurrentPrice;
@end
