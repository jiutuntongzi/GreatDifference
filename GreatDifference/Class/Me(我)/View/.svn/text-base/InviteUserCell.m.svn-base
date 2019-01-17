//
//  InviteUserCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/3/20.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "InviteUserCell.h"
#import "ImageUtils.h"

@interface InviteUserCell ()
@property (nonatomic, strong) UILabel         *nameLabel;
@property (nonatomic, strong) UIImageView     *avatar;

@end
@implementation InviteUserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self.contentView addSubview:self.avatar];
    [self.contentView addSubview:self.nameLabel];
    
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.height.width.mas_equalTo(50);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)awakeFromNib {
    // Initialization code
}

- (UIImageView *)avatar{
    if (!_avatar) {
        _avatar = [[UIImageView alloc]init];
        _avatar.image = [UIImage imageNamed:@"me_invite_avatar"];
        
    }
    return _avatar;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"李清照";
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = XGFONT(15);
    }
    return _nameLabel;
}

- (void)setInvitateModel:(InvitateUsersModel *)invitateModel{
    _invitateModel = invitateModel;
    self.nameLabel.text    = invitateModel.buyerName;
    [ImageUtils loadImageWithLastComponentUrl:invitateModel.buyerHeadImgUrl imageView:self.avatar placeHolder:[UIImage imageNamed:@"me_invite_avatar"]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
