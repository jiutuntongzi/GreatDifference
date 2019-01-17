//
//  MyOrderCell.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/2.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"

@interface MyOrderCell : UITableViewCell
@property (nonatomic, strong) GoodsModel      *goodsModel;
@property (nonatomic, copy) void (^didClickedGoodsBlock)(id model);

- (void)configCellWithModel:(GoodsModel *)goodsModel;

@end
