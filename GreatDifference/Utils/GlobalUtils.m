//
//  GlobalUtils.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/8.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "GlobalUtils.h"

@interface GlobalUtils ()
@property (nonatomic, strong) AddressModel        *userLocation;

@end
@implementation GlobalUtils

+ (AddressModel *)getUserLocationFromBMKLocation:(BMKUserLocation *)bmkLocation{
    
    CLLocationCoordinate2D coordinate  = bmkLocation.location.coordinate;
    NSString *longitudeStr  = [NSString stringWithFormat:@"%.7f", coordinate.longitude];
    NSString *latitudeStr  = [NSString stringWithFormat:@"%.7f", coordinate.latitude];
    

    AddressModel * userLocation= [[AddressModel alloc]init];
    userLocation.longitude = longitudeStr;
    userLocation.latitude  = latitudeStr;
    return userLocation;
}

@end
