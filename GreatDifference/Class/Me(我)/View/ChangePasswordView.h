//
//  ChangePasswordView.h
//  SweePea
//
//  Created by xiaodou_yxg on 16/7/2.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  ChangePWDModel;
@interface ChangePasswordView : UIView

@property (nonatomic, strong) void(^SureBlock)(ChangePWDModel *obj);
@end
