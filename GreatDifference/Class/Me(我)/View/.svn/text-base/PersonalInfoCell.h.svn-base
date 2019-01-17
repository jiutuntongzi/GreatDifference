//
//  PersonalInfoCell.h
//  SweePea
//
//  Created by xiaodou_yxg on 16/6/28.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
//
//typedef NS_ENUM(NSInteger, CellType) {
//    CellTypeNormal,             //title detail形式
//    CellTypeAvatar,
//    CellTypePicker,
//    CellTypeqrCode,             // 有二维码图标的
//};

typedef void(^didFinishedBlock)(NSString *content);

@interface PersonalInfoCell : UITableViewCell
@property (nonatomic, strong) UIImageView       *avatarImg;
@property (nonatomic, strong) UILabel           *detailLabel;
@property (nonatomic, strong) UITextField       *textField;
@property (nonatomic, copy)  didFinishedBlock  finishedBlock;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(CellType)cellType;
- (void)setContent:(NSDictionary *)dic;
- (NSString *)getCellTitle;
@end
