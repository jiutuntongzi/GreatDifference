//
//  GoodsDetailCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/28.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "GoodsDetailCell.h"

@interface GoodsDetailCell ()
@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UILabel         *detailLabel;
@end
@implementation GoodsDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(90);
        make.top.equalTo(self.titleLabel);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font   = XGFONT(15);

    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font   = XGFONT(15);
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

- (void)setContentDic:(NSDictionary *)dic{
    if (!dic) {
        return;
    }
    
    self.titleLabel.text    = dic[@"title"];
    self.detailLabel.text   = dic[@"detail"];
    
    self.detailLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 100;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
