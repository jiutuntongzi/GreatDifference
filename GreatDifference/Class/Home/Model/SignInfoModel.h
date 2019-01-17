//
//  SignInfoModel.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/3/15.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignInfoModel : NSObject
@property (nonatomic, copy) NSString  *appid;
@property (nonatomic, copy) NSString  *package;
@property (nonatomic, copy) NSString  *partnerid;
@property (nonatomic, copy) NSString  *sign;
@property (nonatomic, copy) NSString  *noncestr;
@property (nonatomic, copy) NSString  *prepayid;
@property (nonatomic, copy) NSString  *timestamp;


@end
