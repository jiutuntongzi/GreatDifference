//
//  CalendarCollectionViewCell.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/11/16.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "CalendarCollectionViewCell.h"
#import "SignInModel.h"

@interface CalendarCollectionViewCell ()
@property (nonatomic, strong) UILabel           *titleLabel;

@property (nonatomic, strong) UIImageView       *selectImageView;

@end
@implementation CalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.selectImageView];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(5);
        
    }];
    
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.contentView);
        make.width.height.mas_equalTo(25);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = XGFONT(12);
    }
    return _titleLabel;
}

- (UIImageView *)selectImageView{
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc]init];
    }
    return _selectImageView;
}

//- (void)setSignInModel:(SignInModel *)signInModel{
//    _signInModel = signInModel;
//    self.titleLabel.text    = signInModel.time;
//    if (signInModel.signType == SignInTypeNo) {
//        self.selectImageView.image = [UIImage imageNamed:@"icon_chacha"];
//    }else if (signInModel.signType == SignInTypeYes){
//        self.selectImageView.image = [UIImage imageNamed:@"icon_duidui"];
//    }else{
//        self.selectImageView.image = [UIImage imageNamed:@""];
//    }
//
//}

- (void)setSignDaysModel:(SignDaysModel *)signDaysModel{
    _signDaysModel = signDaysModel;
    self.titleLabel.text    = signDaysModel.day;

    if ([signDaysModel.isSign isEqualToString:@"1"]) {
        self.selectImageView.image = [UIImage imageNamed:@"icon_duidui"];
    }else if ([signDaysModel.isSign isEqualToString:@"0"]){
        self.selectImageView.image = [UIImage imageNamed:@"icon_chacha"];

    }else{
        self.selectImageView.image = [UIImage imageNamed:@""];

    }
}

@end
