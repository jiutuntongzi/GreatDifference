//
//  ConfirmOrderPicCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/28.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ConfirmOrderPicCell.h"
#import "ImageUtils.h"

@interface ConfirmOrderPicCell()
@property (nonatomic, strong) UIImageView     *picImg;
@property (nonatomic, strong) UILabel         *nameLabel;
@property (nonatomic, strong) UILabel         *priceLabel;
@property (nonatomic, strong) UILabel         *introduceLabel;
@property (nonatomic, strong) UILabel         *qualityLabel;

@end
@implementation ConfirmOrderPicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.picImg];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.introduceLabel];
    [self.contentView addSubview:self.qualityLabel];
    
    [self.picImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
        make.width.equalTo(self.picImg.mas_height);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picImg.mas_right).offset(10);
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(-10);
        
    }];
    
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.left.right.equalTo(self.nameLabel);
//        make.height.mas_equalTo(20);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.introduceLabel.mas_bottom);
        make.left.equalTo(self.introduceLabel);
        make.height.mas_equalTo(20);
    }];

    [self.qualityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-10);
        
    }];
    // Initialization code
}

- (UIImageView *)picImg{
    if (!_picImg) {
        _picImg = [UIImageView new];
        _picImg.image = [UIImage imageNamed:@"2_full"];
    }
    return _picImg;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.text = @"格子衬衫男长袖青少年韩版修身型";
        _nameLabel.font = XGFONT(14);
        _nameLabel.numberOfLines = 2;
    }
    return _nameLabel;
}


- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.textColor = THEMECOLOR;
        _priceLabel.text = @"￥69.9";
        _priceLabel.font = XGFONT(14);
        
    }
    return _priceLabel;
}

- (UILabel *)introduceLabel{
    if (!_introduceLabel) {
        _introduceLabel = [[UILabel alloc]init];
        _introduceLabel.font = XGFONT(12);
        _introduceLabel.textColor = [UIColor lightGrayColor];
        _introduceLabel.text = @"商品规格";
        _introduceLabel.numberOfLines = 1;
    }
    return _introduceLabel;
}

- (UILabel *)qualityLabel{
    if (!_qualityLabel) {
        _qualityLabel = [[UILabel alloc]init];
        _qualityLabel.font = XGFONT(12);
        _qualityLabel.textColor = [UIColor lightGrayColor];
        _qualityLabel.text = @"X12";
    }
    return _qualityLabel;
}

- (void)setGoodsModel:(GoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    self.nameLabel.text = goodsModel.productName;
    self.introduceLabel.text    = goodsModel.standard;
    self.priceLabel.text        = [NSString stringWithFormat:@"￥%@", goodsModel.productPrice];
    self.qualityLabel.text      = [NSString stringWithFormat:@"×%@", goodsModel.num];
    
    [ImageUtils loadImageWithLastComponentUrl:goodsModel.productIcon imageView:self.picImg placeHolder:[UIImage imageNamed:@"default_goods_pic"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
