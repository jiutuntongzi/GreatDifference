//
//  GoodsDetailBottomBar.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/28.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

typedef NS_ENUM(NSInteger, BottomBarType) {
    BottomBarTypeLeave = 100,
    BottomBarTypeCollect,
    BottomBarTypeShopCart,
    BottomBarTypeAddShopCart,
    BottomBarTypeBuy,
};


@interface GoodsDetailBottomBar : UIView
@property (nonatomic, strong) CustomButton        *collectBtn;
@property (nonatomic, strong) UILabel             *dotLabel;

@property (nonatomic, copy) void(^bottomBarBlock)(id model, BottomBarType type);

@end
