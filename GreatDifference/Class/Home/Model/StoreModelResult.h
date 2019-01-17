//
//  StoreModelResult.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/9.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreModel.h"
@interface StoreModelResult : NSObject
@property (nonatomic, copy) NSString   *state;
@property (nonatomic, copy) NSString   *message;

@property (nonatomic, strong) StoreModel  *data;
@end
