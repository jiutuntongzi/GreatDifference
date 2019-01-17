//
//  ShopCartSectionView.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/10.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoreModel;
@interface ShopCartSectionView : UIView
@property (nonatomic, copy) void (^sectionBlock)(BOOL isSelect);
@property (nonatomic, strong) StoreModel  *storeModel;

@end
