//
//  IDIdentifySectionHeaderView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "IDIdentifySectionHeaderView.h"

@interface IDIdentifySectionHeaderView ()
@property (nonatomic, strong) UILabel               *titleLabel;
@property (nonatomic, strong) UIImageView           *icon;
@end
@implementation IDIdentifySectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
//        UIView *view = [UIView new];
//        view.backgroundColor = [UIColor whiteColor];
//        self.backgroundView  = view;
        
        [self setupSubviews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.titleLabel];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
        make.width.height.mas_equalTo(20);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(5);
        make.top.equalTo(self.icon);
    }];
}

- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
        _icon.image = [UIImage imageNamed:@"right_arrow_icon"];
    }
    return _icon;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = XGFONT(15);
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text    = title;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
