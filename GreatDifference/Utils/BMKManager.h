//
//  BMKManager.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/1.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@interface BMKManager : NSObject<BMKLocationServiceDelegate>
+ (instancetype)sharedInstance;
- (void)startLocationService;
- (void)stopLocationService;

//- (NSString *)getLocationCity;
@end
