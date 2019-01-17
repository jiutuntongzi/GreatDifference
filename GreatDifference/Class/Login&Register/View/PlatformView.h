//
//  PlatformView.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/14.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ThirdLoginType) {
    ThirdLoginTypeQQ,
    ThirdLoginTypeeWechat,
    ThirdLoginTypeSina,
};

@interface PlatformView : UIView
@property (nonatomic, copy) void(^thirdLoginBlock)(ThirdLoginType skipType);

@end
