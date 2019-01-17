//
//  InvitationView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/25.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "InvitationView.h"

@interface InvitationView ()
@property (nonatomic, strong) UIImageView     *topBackImg;
@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UILabel         *detailLabel;
@property (nonatomic, strong) UILabel         *introduceLabel;
@property (nonatomic, strong) UILabel         *invitationLabel;
@property (nonatomic, strong) UILabel         *invitationCodeLabel;
@property (nonatomic, strong) UIButton        *inviteBtn;
@property (nonatomic, strong) UILabel         *inviteNum;
@property (nonatomic, strong) UIButton        *lookupBtn;
@property (nonatomic, strong) UIImageView     *downbackImg;

@end

@implementation InvitationView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.topBackImg];
    [self.topBackImg addSubview:self.titleLabel];
    [self.topBackImg addSubview:self.detailLabel];
    [self addSubview:self.introduceLabel];
    [self addSubview:self.invitationCodeLabel];
    [self addSubview:self.invitationLabel];
    [self addSubview:self.inviteBtn];
    [self addSubview:self.inviteNum];
    [self addSubview:self.lookupBtn];
    [self addSubview:self.downbackImg];
    
    [self.topBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(SCREEN_HEIGHT/5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.centerY.equalTo(self.topBackImg).offset(kSpace);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self.titleLabel);
        make.height.mas_equalTo(20);
    }];
    
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBackImg.mas_bottom).offset(10);
        make.centerX.equalTo(self);
        
    }];
    
    [self.invitationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.introduceLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self.introduceLabel);
        
    }];
    
    [self.invitationCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.invitationLabel.mas_bottom).offset(5);
        make.centerX.equalTo(self.invitationLabel);
    }];
    
    [self.inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.invitationCodeLabel.mas_bottom).offset(20);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    [self.inviteNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inviteBtn.mas_bottom).offset(50);
        make.centerX.equalTo(self);
    }];
    
    [self.lookupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inviteNum.mas_bottom).offset(10);
        make.centerX.equalTo(self.inviteNum);
    }];
    
    [self.downbackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(SCREEN_HEIGHT/5);
    }];
    
    
}

- (UIImageView *)topBackImg{
    if (!_topBackImg) {
        _topBackImg = [UIImageView new];
        _topBackImg.backgroundColor = THEMECOLOR;
    }
    return _topBackImg;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"我的邀请函";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = XGFONT(23);
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.text   = @"这个平台很不错哦,就想分享给你";
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.font = XGFONT(14);
    }
    return _detailLabel;
}

- (UILabel *)introduceLabel{
    if (!_introduceLabel) {
        _introduceLabel = [UILabel new];
        _introduceLabel.text    = @"邀请好友注册成功获得xx积分\n好友消费也有返利哦!";
        _introduceLabel.numberOfLines = 2;
        _introduceLabel.textColor = [UIColor grayColor];
    }
    return _introduceLabel;
}

- (UILabel *)invitationLabel{
    if (!_invitationLabel) {
        _invitationLabel = [UILabel new];
        _invitationLabel.text = @"邀请函编码";
        _invitationLabel.textColor = [UIColor grayColor];
    }
    return _invitationLabel;
}

- (UILabel *)invitationCodeLabel{
    if (!_invitationCodeLabel) {
        _invitationCodeLabel = [UILabel new];
        _invitationCodeLabel.text    = @"24D3";
        _invitationCodeLabel.font = XGFONT(20);
    }
    return _invitationCodeLabel;
}

- (UILabel *)inviteNum{
    if (!_inviteNum) {
        _inviteNum = [UILabel new];
        _inviteNum.text = @"我共邀请8人";
    }
    return _inviteNum;
}

- (UIButton *)inviteBtn{
    if (!_inviteBtn) {
        _inviteBtn = [[UIButton alloc]init];
        _inviteBtn.backgroundColor = [UIColor redColor];
        [_inviteBtn setTitle:@"发出邀请函" forState:UIControlStateNormal];
        [_inviteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_inviteBtn addTarget:self action:@selector(sendInviteAction:) forControlEvents:UIControlEventTouchUpInside];
        _inviteBtn.tag  = 10;
    }
    return _inviteBtn;
}

- (UIButton *)lookupBtn{
    if (!_lookupBtn) {
        _lookupBtn = [[UIButton alloc]init];
        [_lookupBtn setTitle:@"查看人员明细" forState:UIControlStateNormal];
        [_lookupBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_lookupBtn addTarget:self action:@selector(lookupDetailAction:) forControlEvents:UIControlEventTouchUpInside];
        _inviteBtn.tag  = 11;

    }
    return _lookupBtn;
    
}

- (UIImageView *)downbackImg{
    if (!_downbackImg) {
        _downbackImg = [[UIImageView alloc]init];
        _downbackImg.backgroundColor = THEMECOLOR;
    }
    return _downbackImg;
}

- (void)lookupDetailAction:(UIButton *)btn{
    if (self.sendInviteBlock) {
        self.sendInviteBlock(nil, btn);
    }
}

- (void)sendInviteAction:(UIButton *)btn{
    if (self.sendInviteBlock) {
        self.sendInviteBlock(nil, btn);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
