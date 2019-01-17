//
//  AddPictureCollectionViewCell.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/12/19.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "AddPictureCollectionViewCell.h"

@interface AddPictureCollectionViewCell ()


@end
@implementation AddPictureCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.addPicBtn];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(10);
        
    }];
    
    [self.addPicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.text    = @"商品图片";
    }
    return _titleLabel;
}

- (UIButton *)addPicBtn{
    if (!_addPicBtn) {
        _addPicBtn = [[UIButton alloc]init];
        [_addPicBtn setTitle:@"+" forState:UIControlStateNormal];
        _addPicBtn.backgroundColor = [UIColor clearColor];
//        [_addPicBtn setImage:[UIImage imageNamed:@"add_picture_icon"] forState:UIControlStateNormal];
        _addPicBtn.userInteractionEnabled = NO;
//        [_addPicBtn addTarget:self action:@selector(addPictureAction:) forControlEvents:UIControlEventTouchUpInside];
        _addPicBtn.layer.borderColor = LineColor.CGColor;
        _addPicBtn.layer.borderWidth = 1;
    }
    return _addPicBtn;
}

- (void)addPictureAction:(UIButton *)btn{


}
@end
