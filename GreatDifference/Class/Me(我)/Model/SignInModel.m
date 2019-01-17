//
//  SignInModel.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/21.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "SignInModel.h"
#import "MJExtension.h"

@implementation SignInModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"signDays": @"SignDaysModel"};
}
@end
