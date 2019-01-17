//
//  CommonModelResult.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/24.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonModelResult : NSObject
@property (nonatomic, copy) NSString  *message;
@property (nonatomic, copy) NSString  *state;   // 1. 成功  0 失败
@property (nonatomic, copy) NSString  *data;
@end
