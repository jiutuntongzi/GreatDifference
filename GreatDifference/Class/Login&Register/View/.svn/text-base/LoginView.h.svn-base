//
//  LoginView.h
//  GreatDifference
//
//  Created by 杨旭根 on 2016/11/13.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlatformView.h"

typedef void(^LoginBlock)(NSString *userName, NSString *password);
@interface LoginView : UIView
@property (nonatomic, copy) LoginBlock      loginBlock;
@property (nonatomic, copy) dispatch_block_t    protocolBlock;
@property (nonatomic, copy) dispatch_block_t    forgetPwdBlock;

@property (nonatomic, strong) PlatformView      *platformView;


@end
