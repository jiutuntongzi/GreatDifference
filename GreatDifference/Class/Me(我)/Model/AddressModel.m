//
//  AddressModel.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/8.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "AddressModel.h"
#import "StringUtils.h"
@implementation AddressModel

- (NSString *)province{
    if ([StringUtils isEmpty:_province]) {
        return @"";
    }
    return _province;
}

- (NSString *)city{
    if ([StringUtils isEmpty:_city]) {
        return @"";
    }
    return _city;
}

- (NSString *)district{
    if ([StringUtils isEmpty:_district]) {
        return @"";
    }
    return _district;
}
@end
