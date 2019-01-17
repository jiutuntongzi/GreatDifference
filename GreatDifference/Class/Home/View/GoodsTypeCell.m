//
//  GoodsTypeCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/9.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "GoodsTypeCell.h"
#import "GoodsTypeModel.h"

@interface GoodsTypeCell ()
@property (nonatomic, strong) UIImageView          *bgView;
@property (nonatomic, strong) UIView               *rightLineView;
@end
@implementation GoodsTypeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.rightLineView];
    
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"storeType_bg"];
    self.selectedBackgroundView = bgView;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    [self.rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.equalTo(self.contentView);
        make.width.mas_equalTo(0.35);
    }];


}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"饮料";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = XGFONT(15);
    }
    return _titleLabel;
}

- (UIView *)rightLineView{
    if (!_rightLineView) {
        _rightLineView = [[UIView alloc]init];
        _rightLineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.65];
    }
    return _rightLineView;
}

- (UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc]init];
    }
    return _bgView;
}
- (void)setGoodsType:(GoodsTypeModel *)goodsType{
    
    _goodsType = goodsType;
    self.titleLabel.text    = goodsType.name;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (!selected) {
        self.titleLabel.textColor = [UIColor blackColor];
        self.rightLineView.hidden   = NO;
    }else{
        self.titleLabel.textColor = [UIColor whiteColor];
        self.rightLineView.hidden   = YES;

    }
    // Configure the view for the selected state
}


- (void)awakeFromNib {
    // Initialization code
}

@end
