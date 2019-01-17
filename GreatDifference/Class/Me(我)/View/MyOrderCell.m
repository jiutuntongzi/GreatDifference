//
//  MyOrderCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/2.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MyOrderCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "ImageUtils.h"

@interface MyOrderCell ()
@property (nonatomic, strong) UIButton        *circleBtn;

@property (nonatomic, strong) UIImageView     *picImgView;
@property (nonatomic, strong) UILabel         *nameLabel;
@property (nonatomic, strong) UILabel         *descriptionLabel;
@property (nonatomic, strong) UILabel         *priceLabel;
@property (nonatomic, strong) UILabel         *qualityLabel;
@property (nonatomic, copy) NSString          *reuseId;

@end
@implementation MyOrderCell
#pragma mark -- intialization
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.reuseId = reuseIdentifier;
        [self setupSubviews];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupSubviews{

    [self.contentView addSubview:self.picImgView];
    [self.contentView addSubview:self.priceLabel];

    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.descriptionLabel];
    [self.contentView addSubview:self.qualityLabel];
    if ([self.reuseId isEqualToString:@"orderCellId"]) {
        [self.contentView addSubview:self.circleBtn];
        [self.circleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.centerY.equalTo(self);
            make.width.height.mas_equalTo(20);
        }];
    }

    
    [self.picImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        if ([self.reuseId isEqualToString:@"orderCellId"]) {
            make.left.equalTo(self.circleBtn.mas_right).offset(10);
            make.width.height.equalTo(@70);

        }else{
            make.left.equalTo(self.contentView).offset(10);
            make.width.height.equalTo(@50);
        }

    }];
    


    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.nameLabel.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.picImgView);
//        make.width.priorityMedium();
        make.width.mas_greaterThanOrEqualTo(40);

    }];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picImgView.mas_right).offset(10);
        //        make.top.equalTo(self.picImgView);
        make.top.equalTo(self.priceLabel);
        //        make.width.mas_greaterThanOrEqualTo(30);
        make.right.equalTo(self.priceLabel.mas_left).offset(-10);
        
        
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
    }];
    


    
    [self.qualityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.priceLabel);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(10);
    }];
    
    self.hyb_lastViewInCell = self.picImgView;
    self.hyb_bottomOffsetToCell = 10;

}

#pragma mark -- getter
- (UIButton *)circleBtn{
    if (!_circleBtn) {
        _circleBtn = [UIButton new];
        UIImage *image = [UIImage imageNamed:@"circle_unSelect"];
        UIImage *selectImage = [UIImage imageNamed:@"circle_select"];
        
        [_circleBtn setImage:image forState:UIControlStateNormal];
        [_circleBtn setImage:selectImage forState:UIControlStateSelected];
        [_circleBtn addTarget:self action:@selector(didClickedSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _circleBtn;
}

- (UIImageView *)picImgView{
    if (!_picImgView) {
        _picImgView = [[UIImageView alloc]init];
        _picImgView.backgroundColor = [UIColor greenColor];
    }
    return _picImgView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"这是一只奶牛";
        _nameLabel.font = XGFONT(14);
//        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.text = @"￥3888";
        _priceLabel.textColor = [UIColor grayColor];
        [_priceLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        //设置label1的content hugging 为1000
        [_priceLabel setContentHuggingPriority:UILayoutPriorityRequired
                                   forAxis:UILayoutConstraintAxisHorizontal];
        _priceLabel.font = XGFONT(14);
    }
    return _priceLabel;
}

- (UILabel *)descriptionLabel{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc]init];
        _descriptionLabel.textColor = [UIColor grayColor];
        _descriptionLabel.font = XGFONT(14);

        _descriptionLabel.text = @"500kg";
    }
    return _descriptionLabel;
}

- (UILabel *)qualityLabel{
    if (!_qualityLabel) {
        _qualityLabel = [[UILabel alloc]init];
        _qualityLabel.text = @"x1";
        _qualityLabel.font = XGFONT(14);

    }
    return _qualityLabel;
}

- (void)configCellWithModel:(GoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    self.priceLabel.text        = [NSString stringWithFormat:@"￥%@",goodsModel.productPrice];

    self.nameLabel.text = goodsModel.productName;
    self.descriptionLabel.text  = goodsModel.standard;
    self.qualityLabel.text      = [NSString stringWithFormat:@"×%@", goodsModel.num];
    [ImageUtils loadImageWithLastComponentUrl:goodsModel.productIcon imageView:self.picImgView placeHolder:[UIImage imageNamed:@"default_goods_pic"]];
    
    if (goodsModel.isSelect) {
        self.circleBtn.selected = YES;
    }else{
        self.circleBtn.selected = NO;
    }

}


- (void)didClickedSelectBtn:(UIButton *)btn{
    self.goodsModel.isSelect = !btn.selected;
    if (self.didClickedGoodsBlock) {
        self.didClickedGoodsBlock(self.goodsModel);
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
