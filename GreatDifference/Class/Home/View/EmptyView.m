//
//  EmptyView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/25.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "EmptyView.h"

@interface EmptyView ()
@property (nonatomic, strong) UIImageView     *imageView;
@property (nonatomic, strong) UILabel         *remindLabel;

@end
@implementation EmptyView

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.imageView];
    [self addSubview:self.remindLabel];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).multipliedBy(0.60);
        make.width.height.mas_equalTo(90);
    }];
    
    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom);
        make.centerX.equalTo(self.imageView);
//        make.left.equalTo(@10);
    }];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:@"cha_icon"];
    }
    return _imageView;
}

- (UILabel *)remindLabel{
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc]init];
        _remindLabel.textColor = [UIColor grayColor];
        _remindLabel.text = @"暂无消息";
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _remindLabel;
}

- (void)setRemindMessage:(NSString *)remindMessage{
    self.remindLabel.text   =   remindMessage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
