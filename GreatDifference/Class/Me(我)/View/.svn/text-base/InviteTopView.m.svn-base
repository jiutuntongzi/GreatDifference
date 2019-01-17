//
//  InviteTopView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/1/6.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "InviteTopView.h"
#import "InvitationModel.h"

@interface InviteTopView ()
@property (nonatomic, strong) UIImageView     *bgImageView;

@property (nonatomic, strong) UILabel         *inviteCodeLabel;
@property (nonatomic, strong) UILabel         *detailLabel;
@property (nonatomic, strong) UIButton        *inviteBtn;
@end
@implementation InviteTopView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.bgImageView];
    [self addSubview:self.inviteCodeLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.inviteBtn];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);

    }];
    
    [self.inviteCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        CGFloat topY = 185;
        if (IS_IPHONE_6SPlus) {
            topY = topY * 1.1;
        }else if (IS_IPHONE_5){
            topY = topY * 0.853;
        }
        make.top.equalTo(@(topY));
        
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        CGFloat topY = 320;
        if (IS_IPHONE_6SPlus) {
            topY = topY * 1.1;
        }else if (IS_IPHONE_5){
            topY = topY * 0.853;
        }
        make.top.equalTo(@(topY));
        make.width.mas_equalTo(SCREEN_WIDTH/2);
    }];
    
    [self.inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(5);
        CGFloat bottomY = -90;
        CGFloat width   = 145;
        CGFloat height  = 45;
        if (IS_IPHONE_6SPlus) {
            bottomY = bottomY * 1.1;
            width = width * 1.1;
            height = height * 1.1;
        }else if (IS_IPHONE_5){
            bottomY = bottomY * 0.853;
            width = width * 0.853;
            height = height * 0.853;
        }
        
        make.bottom.equalTo(self.mas_bottom).offset(bottomY);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
    
}
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.image = [UIImage imageNamed:@"me_invite_bg"];
    }
    return _bgImageView;
}


- (UILabel *)inviteCodeLabel{
    if (!_inviteCodeLabel) {
        _inviteCodeLabel = [[UILabel alloc]init];
        _inviteCodeLabel.textColor = [UIColor redColor];
//        _inviteCodeLabel.font = XGFONT(21);
        _inviteCodeLabel.text = @"88F9";
    }
    return _inviteCodeLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = [UIColor whiteColor];
//        _detailLabel.text = @"邀请好友成功获得积分,好友消费也有返利哦";
        _detailLabel.numberOfLines = 0;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.font = XGFONT(14);
    }
    return _detailLabel;
}

- (UIButton *)inviteBtn{
    if (!_inviteBtn) {
        _inviteBtn = [[UIButton alloc]init];
//        _inviteBtn.backgroundColor = [UIColor yellowColor];
//        _inviteBtn.alpha = 0.2;
        [_inviteBtn addTarget:self action:@selector(inviteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _inviteBtn;
}

- (void)setInvitationModel:(InvitationModel *)invitationModel{
    _invitationModel = invitationModel;
    self.inviteCodeLabel.text   = invitationModel.invicationCode;
//    self.
}

- (void)inviteBtnClicked:(UIButton *)btn{
    if (self.inviteBlock) {
        self.inviteBlock();
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
