//
//  BigOrderDetailResult.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/27.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderListModel.h"
@interface BigOrderDetailResult : NSObject
@property (nonatomic, copy) NSString  *message;
@property (nonatomic, copy) NSString  *state;
@property (nonatomic, strong) OrderListModel      *data;


@end
