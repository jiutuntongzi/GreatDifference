//
//  InviteCollectionViewCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/1/6.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "InviteCollectionViewCell.h"
#import "ImageUtils.h"

@interface InviteCollectionViewCell ()
@property (nonatomic, strong) UIImageView     *avatar;

@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UILabel         *detailLabel;
@end
@implementation InviteCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.avatar];
    [self.contentView addSubview:self.titleLabel];
    
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        CGFloat topY = 10;
        if (IS_IPHONE_5) {
            topY = 6;
        }
        make.top.equalTo(@(topY));
        make.width.height.mas_equalTo(55);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.avatar.mas_bottom).offset(5);
//        make.width.height.mas_equalTo(55);
        make.left.right.equalTo(self.contentView);
    }];
}

- (UIImageView *)avatar{
    if (!_avatar) {
        _avatar = [[UIImageView alloc]init];
        _avatar.image = [UIImage imageNamed:@"me_invite_avatar"];
        
    }
    return _avatar;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"李清照";
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = XGFONT(15);
    }
    return _titleLabel;
}

- (void)setInvitateModel:(InvitateUsersModel *)invitateModel{
    _invitateModel = invitateModel;
    self.titleLabel.text    = invitateModel.buyerName;
    [ImageUtils loadImageWithLastComponentUrl:invitateModel.buyerHeadImgUrl imageView:self.avatar placeHolder:[UIImage imageNamed:@"me_invite_avatar"]];
}

@end
