//
//  BannerModelResult.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/24.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Banners.h"

@interface BannerModelResult : NSObject
@property (nonatomic, copy) NSString   *state;
@property (nonatomic, strong) Banners  *data;

@end
