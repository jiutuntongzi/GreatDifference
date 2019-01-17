//
//  BMKManager.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/1.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "BMKManager.h"
#import "XGHttpManager.h"
#import "AddressModel.h"

@interface BMKManager ()
@property (nonatomic, strong) BMKLocationService  *locationService;
@property (nonatomic, strong) AddressModel        *userLocation;
@property (nonatomic, assign) BOOL                city;
@end
@implementation BMKManager
static BMKManager *sharedInstance;
+ (instancetype)sharedInstance{
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

- (BMKLocationService *)locationService{
    if (!_locationService) {
        _locationService    = [[BMKLocationService alloc]init];
        _locationService.delegate   = self;
    }
    return _locationService;
}

- (AddressModel *)userLocation{
    if (!_userLocation) {
        _userLocation = [[AddressModel alloc]init];
    }
    return _userLocation;
}

- (void)startLocationService{
    [self.locationService startUserLocationService];
}

- (void)stopLocationService{
    [self.locationService stopUserLocationService];
}

#pragma mark --  BMKLocationServiceDelegate
- (void)willStartLocatingUser{
    
}

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser{
    
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_UPDATE_USERHEAD object:userLocation];

}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_UPDATE_LOCATION object:userLocation];
}



/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */

- (void)didFailToLocateUserWithError:(NSError *)error{
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOCATION_FAIL object:error];

}


@end
