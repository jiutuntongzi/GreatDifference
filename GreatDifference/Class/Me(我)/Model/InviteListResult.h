//
//  InviteListResult.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/3/20.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InvitateUsersModel.h"

@interface InviteListResult : NSObject
@property (nonatomic, copy) NSString  *message;
@property (nonatomic, copy) NSString  *state;
@property (nonatomic, strong) NSArray      *data;


@end
