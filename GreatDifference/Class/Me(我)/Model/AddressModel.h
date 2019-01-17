//
//  AddressModel.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/8.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
@property (nonatomic, copy) NSString  *consignee;   // 收件人姓名
@property (nonatomic, copy) NSString  *mob;
@property (nonatomic, copy) NSString  *province;
@property (nonatomic, copy) NSString  *city;
@property (nonatomic, copy) NSString  *district;
@property (nonatomic, copy) NSString  *address;

@property (nonatomic, copy) NSString  *longitude;       // 经度
@property (nonatomic, copy) NSString  *latitude;        // 纬度
@property (nonatomic, copy) NSString  *name;            // 简短地址名称

@property (nonatomic, copy) NSString  *consigneeAddressId; // 收件人地址记录ID

@property (nonatomic, copy) NSString  *locationIcon;

@end
