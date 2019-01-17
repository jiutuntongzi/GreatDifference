//
//  PersonInfoDetailViewController.h
//  SweePea
//
//  Created by xiaodou_yxg on 16/7/19.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, InputType) {
    InputTypeTextField,
    InputTypeTextView,
};

@interface PersonInfoDetailViewController : UIViewController
- (instancetype)initWithType:(InputType)type andText:(NSString *)text;
@property (nonatomic, copy) void(^saveBlock)(NSString *text);
@end
