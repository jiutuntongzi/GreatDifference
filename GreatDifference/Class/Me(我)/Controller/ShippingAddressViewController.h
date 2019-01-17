//
//  ShippingAddressViewController.h
//  GreatDifference
//
//  Created by 杨旭根 on 2016/11/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@interface ShippingAddressViewController : UIViewController
@property (nonatomic, assign) BOOL     isSelectAddress;
@property (nonatomic, copy) void(^selectAddressBlock)(AddressModel *address);

@end
