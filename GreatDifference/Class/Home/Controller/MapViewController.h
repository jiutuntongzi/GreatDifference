//
//  MapViewController.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/1.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;

@protocol MapViewControllerDelegate <NSObject>

- (void)didClickedLocation:(AddressModel *)location;

@end
@interface MapViewController : UIViewController
@property (nonatomic, strong) AddressModel  *location;
@property (nonatomic, weak) id<MapViewControllerDelegate>  delegate;
@end
