//
//  GoodsTypeCell.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/9.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsTypeModel;
@interface GoodsTypeCell : UITableViewCell
@property (nonatomic, strong) UILabel         *titleLabel;

@property (nonatomic, strong) GoodsTypeModel  *goodsType;
@end
