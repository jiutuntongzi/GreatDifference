//
//  CalendarCollectionViewCell.h
//  GreatDifference
//
//  Created by 杨旭根 on 2016/11/16.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SignDaysModel;
@class SignInModel;

@interface CalendarCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) SignInModel  *signInModel;
@property (nonatomic, strong) SignDaysModel  *signDaysModel;

@end
