//
//  UserLocation.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/1.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLocation : NSObject
@property (nonatomic, copy) NSString  *longitude;       // 经度
@property (nonatomic, copy) NSString  *latitude;        // 纬度

@property (nonatomic, copy) NSString  *province;        // 省
@property (nonatomic, copy) NSString  *city;            // 市
@property (nonatomic, copy) NSString  *district;        // 区/县

@property (nonatomic, copy) NSString  *name;            // 经度
@property (nonatomic, copy) NSString  *address;         // 地址

@end
