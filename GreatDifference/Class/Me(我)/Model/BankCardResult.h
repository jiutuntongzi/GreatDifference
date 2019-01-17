//
//  BankCardResult.h
//  GreatDifference-business
//
//  Created by xiaodou_yxg on 2017/1/11.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankCardModel.h"

@interface BankCardResult : NSObject
@property (nonatomic, copy) NSString  *state;
@property (nonatomic, copy) NSString  *message;
@property (nonatomic, strong) BankCardModel      *data;


@end
