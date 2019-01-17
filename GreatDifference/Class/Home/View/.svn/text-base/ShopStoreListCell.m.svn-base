//
//  ShopStoreListCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/7.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ShopStoreListCell.h"
#import "StoreModel.h"
#import "ImageUtils.h"

@interface ShopStoreListCell ()
@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UILabel         *addressLabel;
@property (nonatomic, strong) UILabel         *distanceLabel;
@property (nonatomic, strong) UIImageView     *photoImg;
@end
@implementation ShopStoreListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.distanceLabel];
    [self.contentView addSubview:self.photoImg];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(10);
        make.right.equalTo(self.photoImg.mas_left).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.with.right.equalTo(self.titleLabel);
        
    }];
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressLabel.mas_bottom).offset(10);
        make.left.with.right.equalTo(self.addressLabel);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    [self.photoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.width.height.equalTo(@70);
        
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"便利店海岸城店";
    }
    return _titleLabel;
}

- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.font = XGFONT(14);
        _addressLabel.textColor = [UIColor grayColor];
        _addressLabel.text = @"深圳市南山区文心五路";
    }
    return _addressLabel;
}

- (UILabel *)distanceLabel{
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc]init];
        _distanceLabel.textColor = THEMECOLOR;
        _distanceLabel.text = @"<500m";
    }
    return _distanceLabel;
}

- (UIImageView *)photoImg{
    if (!_photoImg) {
        _photoImg = [[UIImageView alloc]init];
    }
    return _photoImg;
}

- (void)setStoreModel:(StoreModel *)storeModel{
    _storeModel = storeModel;
    self.titleLabel.text        = storeModel.shopName;
    self.addressLabel.text      = storeModel.shopAddress;
    self.distanceLabel.text     = [NSString stringWithFormat:@"%@km",storeModel.distance];
    [ImageUtils loadImageWithLastComponentUrl:storeModel.shopIcon imageView:self.photoImg placeHolder:[UIImage imageNamed:@"default_store_pic"]];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
