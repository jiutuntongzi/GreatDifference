//
//  IntegralModel.h
//  GreatDifference
//
//  Created by 杨旭根 on 2016/12/14.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntegralModel : NSObject

@property (nonatomic, copy) NSString    *commonIntegral;    //普通积分
@property (nonatomic, copy) NSString    *mallIntegral;    //海淘积分
@property (nonatomic, copy) NSString    *totalIntegral;    //海淘积分
@property (nonatomic, copy) NSString    *questionUrl;      //积分问题解答


@property (nonatomic, copy) NSString    *integral;    //使用积分
@property (nonatomic, copy) NSString    *integralType;    //积分类型；1-通用积分；2-海淘积分；
@property (nonatomic, copy) NSString    *consumeType;    //消费类型；1-注册送积分；2-签到送积分；3-消费送积分；4-购买消费积分；5-退货返还积分； 6-退货去除奖励积分；

@property (nonatomic, copy) NSString    *orderCode;    //关联订单编码
@property (nonatomic, copy) NSString    *createTime;    // 消费时间
@property (nonatomic, copy) NSString    *descrip;


@property (nonatomic, copy) NSString    *title;     // 我的积分 我的分润
@property (nonatomic, copy) NSString    *leftTitle;
@property (nonatomic, copy) NSString    *rightTitle;

@property (nonatomic, copy) NSString    *money;// 用于我的钱包
@property (nonatomic, copy) NSString    *canEncashment;// 是否可以提现；1-可以；2-没有完善银行卡信息；

@end
