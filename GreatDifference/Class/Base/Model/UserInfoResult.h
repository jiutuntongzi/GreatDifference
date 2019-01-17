//
//  UserInfoResult.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/24.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface UserInfoResult : NSObject
@property (nonatomic, copy) NSString  *state;
@property (nonatomic, copy) NSString  *message;
@property (nonatomic, strong) UserInfo  *data;


@end
