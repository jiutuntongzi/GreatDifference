//
//  ExpressListResult.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/29.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExpressModel.h"

@interface ExpressListResult : NSObject
@property (nonatomic, copy) NSString        *state;
@property (nonatomic, copy) NSString        *message;
@property (nonatomic, strong) NSArray       *data;




@end
