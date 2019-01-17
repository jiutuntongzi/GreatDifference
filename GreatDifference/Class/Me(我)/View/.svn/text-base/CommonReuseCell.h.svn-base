//
//  CommonReuseCell.h
//  GreatDifference
//
//  Created by 杨旭根 on 2016/12/20.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CommonCellType) {
    CommonCellTypeNormal,             //title detailLabel形式
    CommonCellTypeTF,                 // title textField
    CommonCellTypeJump,               // 跳转到下一个界面
};

@interface CommonReuseCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(CommonCellType )cellType;

- (void)setContentDict:(NSDictionary *)dict;
- (NSString *)getCellTitle;
- (NSString *)getCellDetail; //

@end
