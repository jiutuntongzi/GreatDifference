//
//  GoodsModelResult.h
//  GreatDifference
//
//  Created by 杨旭根 on 2016/12/11.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"

@interface GoodsModelResult : NSObject
@property (nonatomic, copy) NSString    *message;
@property (nonatomic, copy) NSString    *state;
@property (nonatomic, strong) GoodsModel    *data;



@end
