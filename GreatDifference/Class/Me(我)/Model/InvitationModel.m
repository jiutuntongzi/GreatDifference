//
//  InvitationModel.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/2/6.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "InvitationModel.h"
#import "MJExtension.h"

@implementation InvitationModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"invicateUsers": @"InvitateUsersModel"};
}
@end
