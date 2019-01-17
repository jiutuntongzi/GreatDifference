//
//  EditAddressCell.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/18.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EditAddressCellType) {
    EditAddressCellTypeNormal,             //title detailtextfield形式
    EditAddressCellTypeJump,
    EditAddressCellTypeSelect,
};
@interface EditAddressCell : UITableViewCell
@property (nonatomic, strong) UILabel           *detailLabel;
@property (nonatomic, strong) UITextView       *detailTextView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(EditAddressCellType )cellType;
- (void)setContentDic:(NSDictionary *)dic;
- (NSString *)getCellTitle;
@end

@interface AddressTypeView : UIView
@property (nonatomic, strong) UIButton        *companyBtn;
@property (nonatomic, strong) UIButton        *houseBtn;
@property (nonatomic, strong) UIButton        *schoolBtn;
@property (nonatomic, strong) UIButton        *otherBtn;

@end
