//
//  MeCollectionViewCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MeCollectionViewCell.h"

@interface MeCollectionViewCell ()
@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UIImageView     *titleIcon;

@end
@implementation MeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleIcon];
        [self.contentView addSubview:self.titleLabel];
        
        [self.titleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@20);
            make.top.equalTo(self.mas_centerY).offset(-28);
            make.centerX.equalTo(self.contentView);
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(22);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleIcon.mas_bottom).offset(kSpace);
            make.left.right.equalTo(self.contentView);
        }];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text    = @"我的钱包";
        _titleLabel.font = XGFONT(15);
        _titleLabel.textColor = HEXCOLOR(0x666666);
    }
    return _titleLabel;
}

- (UIImageView *)titleIcon{
    if (!_titleIcon) {
        _titleIcon = [[UIImageView alloc]init];
    }
    return _titleIcon;
}

- (void)setContentDic:(NSDictionary *)contentDic{
    _contentDic = contentDic;
    self.titleLabel.text = [contentDic objectForKey:@"title"];
    self.titleIcon.image    = [UIImage imageNamed:contentDic[@"icon"]];
}
@end
