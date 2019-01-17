//
//  MeTopCollectionViewCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/21.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MeTopCollectionViewCell.h"

@interface MeTopCollectionViewCell ()

@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UIImageView     *titleIcon;

@end
@implementation MeTopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleIcon];
        [self.contentView addSubview:self.titleLabel];
        [self.titleIcon addSubview:self.iconLabel];
        
        [self.titleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.top.equalTo(@20);
            make.top.equalTo(self.mas_centerY).offset(-20);
            make.centerX.equalTo(self.contentView);
            make.width.height.mas_equalTo(20);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleIcon.mas_bottom).offset(kSpace*0.8);
            make.left.right.equalTo(self.contentView);
        }];
        
        [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.titleIcon).offset(-7);
            make.right.equalTo(self.titleIcon.mas_right).offset(7);
            make.width.height.mas_equalTo(16);
        }];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text    = @"我的钱包";
        _titleLabel.font = XGFONT(14);
        _titleLabel.textColor = HEXCOLOR(0x999999);
    }
    return _titleLabel;
}

- (UIImageView *)titleIcon{
    if (!_titleIcon) {
        _titleIcon = [[UIImageView alloc]init];
    }
    return _titleIcon;
}

- (UILabel *)iconLabel{
    if (!_iconLabel) {
        _iconLabel = [[UILabel alloc]init];
        _iconLabel.backgroundColor = [UIColor redColor];
        _iconLabel.font = XGFONT(10);
        _iconLabel.layer.cornerRadius = 8;
        _iconLabel.layer.masksToBounds  = YES;
        _iconLabel.textColor = [UIColor whiteColor];
        _iconLabel.textAlignment = NSTextAlignmentCenter;
        _iconLabel.text = @"9";
        _iconLabel.hidden = YES;
    }
    return _iconLabel;
}

- (void)setContentDic:(NSDictionary *)contentDic{
    _contentDic = contentDic;
    self.titleLabel.text = [contentDic objectForKey:@"title"];
    self.titleIcon.image    = [UIImage imageNamed:contentDic[@"icon"]];
}

@end
