//
//  AppDelegate.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 16/10/29.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, BMKGeneralDelegate>
{
    BMKMapManager *_mapManager;
}
@property (strong, nonatomic) UIWindow *window;
//@property (nonatomic, strong) MainViewController  *mainVc;

@end

