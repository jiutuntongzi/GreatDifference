//
//  StoreHeaderView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/9.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "StoreHeaderView.h"
#import "ImageUtils.h"

@interface StoreHeaderView ()
@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UIImageView     *bgImageView;
@property (nonatomic, strong) UIButton        *avatarImage;

@end
@implementation StoreHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.bgImageView];
    [self addSubview:self.avatarImage];
    [self addSubview:self.titleLabel];

    WS(self);
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakself);
        make.height.width.equalTo(@80);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImage.mas_bottom);
        make.centerX.equalTo(self.avatarImage);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"便利店科苑店";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font    = [UIFont boldSystemFontOfSize:17];
    }
    return _titleLabel;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.image = [UIImage imageNamed:@"store_photo"];
    }
    return _bgImageView;
}

- (UIButton *)avatarImage{
    if (!_avatarImage) {
        _avatarImage = [[UIButton alloc]init];
        _avatarImage.layer.cornerRadius     = 40;
        _avatarImage.layer.masksToBounds    = YES;
        _avatarImage.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35];
        [_avatarImage addTarget:self action:@selector(didClickedAvatarBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _avatarImage;
}
- (void)setStoreModel:(StoreModel *)storeModel{
    _storeModel = storeModel;
    self.titleLabel.text    = storeModel.shopName;
    NSString *imageUrl = [IMAGE_BASE_URL stringByAppendingPathComponent:storeModel.shopIcon];
    [ImageUtils loadImageWithUrl:imageUrl button:self.avatarImage placeHolder:[UIImage imageNamed:@"default_store_pic"]];
}

- (void)didClickedAvatarBtn:(UIButton *)btn{
    if (self.clickedAvatarBlock) {
        self.clickedAvatarBlock(btn);
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
