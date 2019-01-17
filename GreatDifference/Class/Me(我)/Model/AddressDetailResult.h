//
//  AddressDetailResult.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/8.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"

@interface AddressDetailResult : NSObject
@property (nonatomic, copy) NSString  *message;
@property (nonatomic, copy) NSString  *state;
@property (nonatomic, strong) AddressModel  *data;
@end
