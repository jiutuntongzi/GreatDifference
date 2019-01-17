//
//  ShopingCartHeaderView.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/10.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoreModel;
@class OrderModel;

@interface ShopingCartHeaderView : UITableViewHeaderFooterView
@property (nonatomic, copy) void (^sectionBlock)(BOOL isSelect);
@property (nonatomic, strong) StoreModel  *storeModel;
@property (nonatomic, strong) OrderModel  *orderModel;

//@property (nonatomic, strong) UIButton        *circleBtn;

@end
