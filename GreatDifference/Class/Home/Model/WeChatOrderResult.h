//
//  WeChatOrderResult.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/3/15.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeChatOrderModel.h"

@interface WeChatOrderResult : NSObject
@property (nonatomic, copy) NSString    *message;
@property (nonatomic, copy) NSString    *state;
@property (nonatomic, strong) WeChatOrderModel    *data;
@end
