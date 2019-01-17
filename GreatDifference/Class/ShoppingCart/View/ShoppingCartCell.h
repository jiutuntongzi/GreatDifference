//
//  ShoppingCartCell.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/5.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;

@interface ShoppingCartCell : UITableViewCell
@property (nonatomic, strong) GoodsModel  *goodsModel;

@property (nonatomic, copy) void (^didClickedGoodsBlock)(id model);
@property (nonatomic, copy) dispatch_block_t quantityChangeBlock;

@end
