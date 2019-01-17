//
//  SignInModel.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/21.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignDaysModel.h"

typedef NS_ENUM(NSInteger, SignInType) {
    SignInTypeNoYet,    // 还未到
    SignInTypeNo,       // 未签到
    SignInTypeYes,      // 已签到
};
@interface SignInModel : NSObject
@property (nonatomic, copy) NSString  *time;
//@property (nonatomic, assign) SignInType  signType;


@property (nonatomic, strong) NSArray  *signDays;
@property (nonatomic, copy) NSString   *isSign;
@property (nonatomic, copy) NSString   *currentDay;
@property (nonatomic, copy) NSString   *monthFirstDayWeekTag;// 0表示周日




@end
