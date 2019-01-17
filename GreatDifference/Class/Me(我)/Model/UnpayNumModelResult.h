//
//  UnpayNumModelResult.h
//  GreatDifference
//
//  Created by 杨旭根 on 2017/2/27.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnpayNumModel.h"

@interface UnpayNumModelResult : NSObject
@property (nonatomic, copy) NSString    *state;
@property (nonatomic, copy) NSString    *message;
@property (nonatomic, strong) UnpayNumModel        *data;

@end
