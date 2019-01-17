//
//  RegisterModel.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/23.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterModel : NSObject
@property (nonatomic, copy) NSString  *mob;             //手机号
@property (nonatomic, copy) NSString  *verifyCode;      // 验证码
@property (nonatomic, copy) NSString  *password;        // 密码
@property (nonatomic, copy) NSString  *invitationCode;  // 邀请码  非必填



@end
