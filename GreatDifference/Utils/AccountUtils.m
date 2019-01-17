//
//  AccountUtils.m
//  SweePea
//
//  Created by xiaodou_yxg on 16/7/20.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "AccountUtils.h"

#define AccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation AccountUtils


+ (void)save:(UserInfo *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:AccountFilepath];
//    [USER_DEFAULTS setObject:account.uid forKey:LOGIN_USERID];
}

+ (UserInfo *)account{
    UserInfo *user = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountFilepath];
    return user;
}


// 优惠券处用的userid
+ (NSString *)getUserId{
    NSString *userId = [self account].userId;
    return userId;
}

+ (NSString *)getUserName{
    UserInfo *user = [self account];
    return user.name;
}

+ (NSString *)getUserAvatar{
    UserInfo *user = [self account];
    return user.icon;
}




@end
