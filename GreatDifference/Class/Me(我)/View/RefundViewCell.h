//
//  RefundViewCell.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/17.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefundViewCell : UITableViewCell

@property (nonatomic, strong) UITextField     *tapTextField;

@property (nonatomic, copy) void (^finishBlock)(NSString *text);

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(CellType )cellType;

- (void)setContentDict:(NSDictionary *)dic;
- (void)setDataSource:(NSArray *)dataSource;
- (NSString *)getCellDetail;
@end
