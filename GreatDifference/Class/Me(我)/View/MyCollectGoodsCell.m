//
//  MyCollectGoodsCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/18.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MyCollectGoodsCell.h"
#import "GoodsModel.h"
#import "StoreModel.h"
#import "ImageUtils.h"

@interface MyCollectGoodsCell ()
@property (nonatomic, strong) UIImageView     *pictureImg;
@property (nonatomic, strong) UILabel         *nameLabel;
@property (nonatomic, strong) UILabel         *sourceLabel;
@property (nonatomic, strong) UILabel         *priceLabel;
@property (nonatomic, strong) UIButton        *buyerBtn;


@end
@implementation MyCollectGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.pictureImg];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.sourceLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.buyerBtn];
    
    [self.pictureImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@(kSpace));
        make.bottom.equalTo(@(-kSpace));
        make.width.equalTo(self.pictureImg.mas_height);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pictureImg.mas_right).offset(kSpace);
        make.right.equalTo(self.contentView).offset(-kSpace);
        make.top.equalTo(self.pictureImg);
    }];
    
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(0.5 * kSpace);
        make.left.right.equalTo(self.nameLabel);
        
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-kSpace);
        make.left.equalTo(self.pictureImg.mas_right).offset(kSpace);
        make.height.mas_equalTo(20);
    }];
    
    [self.buyerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.priceLabel);
        make.right.equalTo(self.contentView).offset(-kSpace);
        make.width.height.mas_equalTo(30);
    }];
}

- (UIImageView *)pictureImg{
    if (!_pictureImg) {
        _pictureImg = [[UIImageView alloc]init];
        _pictureImg.image = [UIImage imageNamed:@"default_goods_pic"];
    }
    return _pictureImg;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = XGFONT(15);
        _nameLabel.numberOfLines = 2;
    }
    return _nameLabel;
}

- (UILabel *)sourceLabel{
    if (!_sourceLabel) {
        _sourceLabel = [[UILabel alloc]init];
        _sourceLabel.textColor = [UIColor lightGrayColor];
        _sourceLabel.font = XGFONT(12);
        _sourceLabel.numberOfLines = 2;

    }
    return _sourceLabel;
}
- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = THEMECOLOR;
        _priceLabel.font = XGFONT(12);
    }
    return _priceLabel;
}

- (UIButton *)buyerBtn{
    if (!_buyerBtn) {
        _buyerBtn = [[UIButton alloc]init];
        [_buyerBtn setImage:nil forState:UIControlStateNormal];
        [_buyerBtn addTarget:self action:@selector(buyerAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyerBtn;
}

- (void)buyerAction:(UIButton *)btn{
    
}

- (void)setGoodsModel:(GoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    self.nameLabel.text         = goodsModel.productName;
    self.sourceLabel.text       = goodsModel.standard;
    self.priceLabel.text        = [NSString stringWithFormat:@"￥%@",goodsModel.productPrice];
//    NSString *fullUrl = [IMAGE_BASE_URL stringByAppendingPathComponent:goodsModel.productIcon];
//    [ImageUtils loadImageWithUrl:fullUrl imageView:self.pictureImg placeHolder:[UIImage imageNamed:@"default_goods_pic"]];
    [ImageUtils loadImageWithLastComponentUrl:goodsModel.productIcon imageView:self.pictureImg placeHolder:[UIImage imageNamed:@"default_goods_pic"]];
}

- (void)setStoreModel:(StoreModel *)storeModel{
    _storeModel = storeModel;
    self.nameLabel.text         = storeModel.shopName;
    self.sourceLabel.text       = storeModel.shopAddress;
    [ImageUtils loadImageWithLastComponentUrl:storeModel.shopIcon imageView:self.pictureImg placeHolder:[UIImage imageNamed:@"default_store_pic"]];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
