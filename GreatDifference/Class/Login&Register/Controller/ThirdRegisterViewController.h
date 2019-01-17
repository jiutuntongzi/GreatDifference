//
//  ThirdRegisterViewController.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/2/21.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

@interface ThirdRegisterViewController : UIViewController
@property (nonatomic, strong) SSDKUser      *kUser;
@property (nonatomic, copy) NSString        *thirdType;

@end
