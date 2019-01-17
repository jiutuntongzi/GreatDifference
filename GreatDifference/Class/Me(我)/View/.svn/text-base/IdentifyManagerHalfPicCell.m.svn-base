//
//  IdentifyManagerHalfPicCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/13.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "IdentifyManagerHalfPicCell.h"
#import "ImageUtils.h"

@interface IdentifyManagerHalfPicCell ()
@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UILabel         *detailLabel;
@property (nonatomic, strong) UIButton        *addPictureBtn;

@property (nonatomic, strong) UILabel         *remindLabel;


@end
@implementation IdentifyManagerHalfPicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.addPictureBtn];
    [self.contentView addSubview:self.remindLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [self.addPictureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo((SCREEN_WIDTH-20)/2);
        
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.addPictureBtn);
        make.top.equalTo(self.addPictureBtn.mas_bottom).offset(5);
    }];
    
    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addPictureBtn);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(10);
        
    }];
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
//        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font   = XGFONT(15);
        _titleLabel.text = @"手持身份证半身照";
        
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font   = XGFONT(14);
        _detailLabel.text = @"手持身份证半身照";
        _detailLabel.textColor = [UIColor grayColor];
    }
    return _detailLabel;
}

- (UILabel *)remindLabel{
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc]init];
        _remindLabel.textColor = [UIColor grayColor];
        _remindLabel.font = XGFONT(15);
        _remindLabel.numberOfLines = 2;
        _remindLabel.text = @"温馨提示: 请上传元素比例的身份证正反面，请勿裁剪涂改，保证身份证信息清晰显示";
    }
    return _remindLabel;
}

- (UIButton *)addPictureBtn{
    if (!_addPictureBtn) {
        _addPictureBtn = [[UIButton alloc]init];
        _addPictureBtn.backgroundColor = [UIColor yellowColor];
        [_addPictureBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_addPictureBtn addTarget:self action:@selector(addPictureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _addPictureBtn.tag = 8;
    }
    return _addPictureBtn;
}

- (void)addPictureBtnAction:(UIButton *)btn{
    if (self.addPictureBlock) {
        self.addPictureBlock(btn);
    }
}

- (void)setContent:(NSDictionary *)dic{
    NSString *halfStr = dic[@"halfPic"];
    NSString *fullhalfUrl = [IMAGE_BASE_URL stringByAppendingPathComponent:halfStr];
    [ImageUtils loadImageWithUrl:fullhalfUrl button:self.addPictureBtn placeHolder:[UIImage imageNamed:@"cha_icon"]];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
