//
//  ShoppingCartCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/5.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "GoodsModel.h"
#import "PPNumberButton.h"
#import "ImageUtils.h"

@interface ShoppingCartCell ()
@property (nonatomic, strong) UIButton        *circleBtn;
@property (nonatomic, strong) UIImageView     *iconImg;
@property (nonatomic, strong) UILabel         *nameLabel;
@property (nonatomic, strong) UILabel         *priceLabel;
@property (nonatomic, strong) UILabel         *introduceLabel;
@property (nonatomic, strong) PPNumberButton  *numberButton;
@property (nonatomic, strong) UILabel         *remindLabel;

@end
@implementation ShoppingCartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.circleBtn];
    [self.contentView addSubview:self.iconImg];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.introduceLabel];
    [self.contentView addSubview:self.numberButton];
    [self.contentView addSubview:self.remindLabel];
    
    [self.circleBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(@5);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.circleBtn.mas_right).offset(5);
        make.centerY.equalTo(self.circleBtn);
        make.width.equalTo(self.iconImg.mas_height);
        make.top.equalTo(@10);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(10);
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(-10);
        
    }];
    
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.left.equalTo(self.nameLabel);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.numberButton.mas_left).offset(-5);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.introduceLabel.mas_bottom);
        make.left.equalTo(self.introduceLabel);
        make.height.mas_equalTo(20);
    }];
    
    [self.numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.introduceLabel).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
    }];
    
}

- (UIButton *)circleBtn{
    if (!_circleBtn) {
        _circleBtn = [UIButton new];
        UIImage *image = [UIImage imageNamed:@"circle_unSelect"];
        UIImage *selectImage = [UIImage imageNamed:@"circle_select"];
        _circleBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [_circleBtn setImage:image forState:UIControlStateNormal];
        [_circleBtn setImage:selectImage forState:UIControlStateSelected];
        [_circleBtn addTarget:self action:@selector(didClickedSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _circleBtn;
}

- (UIImageView *)iconImg{
    if (!_iconImg) {
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"2_full"];
    }
    return _iconImg;
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
    }
    return _introduceLabel;
}

- (PPNumberButton *)numberButton{
    if (!_numberButton) {
        WS(self);
        _numberButton = [[PPNumberButton alloc]init];
        _numberButton.frame = CGRectMake(0, 0, 80, 25 );
//        [_numberButton setTitleWithIncreaseTitle:@"+" decreaseTitle:@"-"];
        [_numberButton setImageWithincreaseImage:[UIImage imageNamed:@"shopCart_add_icon"] decreaseImage:[UIImage imageNamed:@"shopCart_decrease_icon"]];
        _numberButton.isEdit    = NO;
        _numberButton.numberBlock = ^(NSString *text){
            weakself.goodsModel.num = text;
            if (weakself.quantityChangeBlock) {
                weakself.quantityChangeBlock();
            }
        };
    }
    return _numberButton;
}

- (UILabel *)remindLabel{
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc]init];
        _remindLabel.backgroundColor = LineColor;
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        _remindLabel.font = XGFONT(14);
        _remindLabel.textColor = [UIColor whiteColor];
        _remindLabel.text = @"失效";
        _remindLabel.hidden = YES;
        _remindLabel.layer.cornerRadius = 2;
        _remindLabel.layer.masksToBounds = YES;
    }
    return _remindLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)didClickedSelectBtn:(UIButton *)btn{
//    btn.selected = !btn.selected;
    self.goodsModel.isSelect = !btn.selected;
    if (self.didClickedGoodsBlock) {
        self.didClickedGoodsBlock(self.goodsModel);
    }
    
}


- (void)setGoodsModel:(GoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    self.nameLabel.text             = goodsModel.productName;
    self.introduceLabel.text        = goodsModel.standard;
    self.priceLabel.text            = [NSString stringWithFormat:@"￥%@", goodsModel.productPrice];
    NSString *fullUrl = [IMAGE_BASE_URL stringByAppendingPathComponent:goodsModel.productIcon];
    [ImageUtils loadImageWithUrl:fullUrl imageView:self.iconImg placeHolder:[UIImage imageNamed:@"default_goods_pic"]];
    if (goodsModel.isSelect) {
        self.circleBtn.selected = YES;
    }else{
        self.circleBtn.selected = NO;
    }
    
    if ([goodsModel.existsChange isEqualToString:@"1"]) {
        self.remindLabel.hidden = NO;
        self.circleBtn.hidden = YES;
    }else{
        self.remindLabel.hidden = YES;
        self.circleBtn.hidden = NO;

    }
    [self.numberButton setIntialNum:goodsModel.num];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
