//
//  GoodsCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/9.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "GoodsCell.h"
#import "GoodsModel.h"
#import "ImageUtils.h"

@interface GoodsCell ()
@property (nonatomic, strong) UILabel         *nameLabel;
@property (nonatomic, strong) UILabel         *introduceLabel;
@property (nonatomic, strong) UIImageView     *photoImg;
@property (nonatomic, strong) UIButton        *addBtn;
@property (nonatomic, strong) UILabel         *priceLabel;

@end
@implementation GoodsCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.introduceLabel];
    [self.contentView addSubview:self.photoImg];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.addBtn];
    
    WS(self);
    [self.photoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakself).offset(10);
        make.bottom.equalTo(weakself.mas_bottom).offset(-10);
        make.width.equalTo(self.photoImg.mas_height);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.photoImg.mas_right).offset(10);
        make.top.equalTo(weakself.photoImg);
        make.right.equalTo(weakself.addBtn.mas_left).offset(-5);
        make.height.mas_equalTo(20);
    }];
    
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.nameLabel);
        make.top.equalTo(weakself.nameLabel.mas_bottom);
        make.right.equalTo(weakself.nameLabel);
        make.height.mas_equalTo(20);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.nameLabel);
        make.top.equalTo(weakself.introduceLabel.mas_bottom);
        make.right.equalTo(weakself.mas_right).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(30);
    }];
    
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"便利店海岸城店";
        _nameLabel.font = XGFONT(14);
    }
    return _nameLabel;
}

- (UILabel *)introduceLabel{
    if (!_introduceLabel) {
        _introduceLabel = [[UILabel alloc]init];
        _introduceLabel.font = XGFONT(12);
        _introduceLabel.textColor = [UIColor grayColor];
        _introduceLabel.text = @"深圳市南山区文心五路";
    }
    return _introduceLabel;
}

- (UIImageView *)photoImg{
    if (!_photoImg) {
        _photoImg = [[UIImageView alloc]init];
    }
    return _photoImg;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = THEMECOLOR;
        _priceLabel.text = @"50元";
        _priceLabel.font = XGFONT(14);
    }
    return _priceLabel;
}

- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc]init];
        [_addBtn setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addGoodsAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
- (void)setGoodsModel:(GoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    self.nameLabel.text         = goodsModel.productName;
    self.introduceLabel.text    = goodsModel.standard;
    self.priceLabel.text        = [NSString stringWithFormat:@"￥%@",goodsModel.productPrice];
    [ImageUtils loadImageWithLastComponentUrl:goodsModel.productIcon imageView:self.photoImg placeHolder:[UIImage imageNamed:@"default_goods_pic"]];
}

- (void)addGoodsAction{
    if (self.addGoodsBlock) {
        self.addGoodsBlock(self.goodsModel);
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
