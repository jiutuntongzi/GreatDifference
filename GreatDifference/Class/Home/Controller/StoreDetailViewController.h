//
//  StoreDetailViewController.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/1.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModelResult.h"

@interface StoreDetailViewController : UIViewController
@property (nonatomic, copy) NSString  *shopId;
@property (nonatomic, assign) BOOL     fromScan;
@property (nonatomic, strong) StoreModel            *storeModel;

@end
