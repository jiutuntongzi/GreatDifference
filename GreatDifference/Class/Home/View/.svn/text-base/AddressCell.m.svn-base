//
//  AddressCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/1.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "AddressCell.h"

@interface AddressCell ()
@property (nonatomic, strong) UIImageView     *icon;
@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UILabel         *detailLabel;
@end
@implementation AddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(20);

    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.top.equalTo(@10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        
    }];
    
    
}

- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
        _icon.image = [UIImage imageNamed:@"location_icon"];
    }
    return _icon;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font    = XGFONT(15);
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.font = XGFONT(12);
    }
    return _detailLabel;
}

//- (void)setLocation:(UserLocation *)location{
//    _location = location;
//    self.titleLabel.text = location.name;
//    self.detailLabel.text   = location.address;
//}

- (void)setAddressModel:(AddressModel *)addressModel{
    _addressModel = addressModel;
    self.titleLabel.text    = addressModel.address;
    self.detailLabel.text   = addressModel.name;
    self.icon.image = [UIImage imageNamed:addressModel.locationIcon];

}

//- (void)configureCurrentLocation:(AddressModel *)addressModel{
//    _addressModel = addressModel;
//    self.titleLabel.text    = addressModel.address;
//    self.detailLabel.text   = addressModel.name;
//}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
