//
//  MyWalletHeaderView.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/16.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntegralModel.h"
typedef void(^integralBlock)(IntegralModel  *model);
@interface MyWalletHeaderView : UIView
@property (nonatomic, copy) integralBlock leftBlock;
@property (nonatomic, copy) integralBlock rightBlock;

@property (nonatomic, strong) IntegralModel  *model;

- (instancetype)initWithFrame:(CGRect )frame type:(NSString *)type;
- (void)setWalletModel:(IntegralModel *)wallet;
@end
