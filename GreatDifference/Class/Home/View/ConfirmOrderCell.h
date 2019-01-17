//
//  ConfirmOrderCell.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/28.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;

typedef NS_ENUM(NSInteger, OrderCellType) {
    OrderCellTypeNormal,  // detailLabel
    OrderCellTypeNum,
    OrderCellTypeTextField,
    OrderCellTypePic,
//    CellTypeJump,
};
@interface ConfirmOrderCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(OrderCellType)cellType;
- (void)setContentDic:(NSDictionary *)dic;
@property (nonatomic, strong) GoodsModel      *goods;
@property (nonatomic, strong) UITextField     *detailTextField;

@end
