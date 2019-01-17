//
//  CompleteInfoCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "CompleteInfoCell.h"

@interface CompleteInfoCell ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel           *titleLabel;
//@property (nonatomic, strong) UILabel         *detailLabel;
@property (nonatomic, strong) UIImageView       *icon;
@property (nonatomic, assign) CompleteCellType  cellType;
@end
@implementation CompleteInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(CompleteCellType )cellType{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellType = cellType;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    if (self.cellType == CompleteCellTypeNormal) {
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.titleLabel];
        
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(10);
            make.width.height.mas_equalTo(20);
            
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(5);
            make.top.equalTo(self.icon);
        }];
    }else{
    
        [self.contentView addSubview:self.detailTextField];
        [self.detailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(10);
            make.bottom.right.equalTo(self.contentView).offset(-10);
        }];
    }


}

- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = XGFONT(15);
    }
    return _titleLabel;
}

- (UITextField *)detailTextField{
    if (!_detailTextField) {
        _detailTextField = [UITextField new];
        _detailTextField.font = XGFONT(15);
        _detailTextField.delegate = self;
    }
    return _detailTextField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.cellType == CompleteCellTypeTextField) {
        [self.contentDict setValue:textField.text forKey:@"detail"];
    }
}

- (void)setContentDict:(NSDictionary *)dic{
    _contentDict = dic;
    if (self.cellType == CompleteCellTypeNormal) {
        self.titleLabel.text = dic[@"title"];
        self.icon.image = [UIImage imageNamed:dic[@"icon"]];
    }else{
        self.detailTextField.placeholder = dic[@"placeHolder"];
        self.detailTextField.text        = dic[@"detail"];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
