//
//  ViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 16/10/29.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationService.h>
@interface ViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate>
@property (nonatomic, strong) BMKMapView  *mapView;
@property (nonatomic, strong) BMKLocationService  *locationService;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = self.mapView;
    [self.locationService startUserLocationService];
    self.mapView.showsUserLocation = YES;

    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    // Do any additional setup after loading the view, typically from a nib.
}

- (BMKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    }
    return _mapView;
}

- (BMKLocationService *)locationService{
    if (!_locationService) {
        _locationService = [[BMKLocationService alloc]init];
    }
    return _locationService;
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
    [self.mapView updateLocationData:userLocation];
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    _locationService.delegate   = self;

}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
