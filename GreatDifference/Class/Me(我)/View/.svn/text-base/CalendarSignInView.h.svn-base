//
//  CalendarSignInView.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/16.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SignInModel;

@class CalendarSignInView;
@protocol SignInDelegate <NSObject>

- (void)signInView:(CalendarSignInView *)signInView didClickedSignBtn:(id )model;

@end
@interface CalendarSignInView : UIView
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource;
@property (nonatomic, strong) SignInModel      *signInModel;
@property (nonatomic, weak) id<SignInDelegate>  delegate;
@end
