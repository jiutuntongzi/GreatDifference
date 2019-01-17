//
//  MeHeaderView.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/11/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MeHeaderView.h"
#import "UserInfo.h"
#import "ImageUtils.h"

@interface MeHeaderView ()
@property (nonatomic, strong) UIImageView          *avatarImageView;
@property (nonatomic, strong) UILabel              *nameLabel;

@end
@implementation MeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = THEMECOLOR;
        [self addSubview:self.avatarImageView];
        [self addSubview:self.nameLabel];
        
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.height.equalTo(@(SCREEN_WIDTH/5));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarImageView.mas_bottom).offset(5);
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

- (UIImageView *)avatarImageView{
    if (!_avatarImageView) {
        _avatarImageView = [UIImageView new];
        _avatarImageView.layer.cornerRadius = SCREEN_WIDTH/10;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.backgroundColor = [UIColor greenColor];
        _avatarImageView.image = [UIImage imageNamed:@"me_default_icon"];
    }
    return _avatarImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.text = @"昵称";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}


- (void)setUser:(UserInfo *)user{
    _user = user;
    self.nameLabel.text = user.name;
    [ImageUtils loadImageWithLastComponentUrl:user.headImgUrl imageView:self.avatarImageView placeHolder:[UIImage imageNamed:@"me_default_icon"]];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
