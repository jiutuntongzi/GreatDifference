//
//  IdentifyManagerCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/28.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "IdentifyManagerCell.h"
#import "ImageUtils.h"

@interface IdentifyManagerCell ()
@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UILabel         *detailLabel;
@property (nonatomic, strong) UILabel         *detailLabel1;

@property (nonatomic, strong) UIButton        *addPictureBtn;
@property (nonatomic, strong) UIButton        *addPictureBtn1;

@property (nonatomic, strong) UILabel         *remindLabel;
@property (nonatomic, copy) NSString         *cellType;

@end
@implementation IdentifyManagerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellType = reuseIdentifier;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.titleLabel];

    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.detailLabel1];
    [self.contentView addSubview:self.addPictureBtn];
    [self.contentView addSubview:self.addPictureBtn1];

    [self.contentView addSubview:self.remindLabel];
    if (![self.cellType isEqualToString:@"completeCell"]) {
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(10);
            make.height.mas_equalTo(20);
        }];
    }

    
    [self.addPictureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(100);
        
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.addPictureBtn);
        make.top.equalTo(self.addPictureBtn.mas_bottom).offset(5);
        
    }];
    
    [self.addPictureBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addPictureBtn.mas_right).offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.height.mas_equalTo(self.addPictureBtn);
        
    }];
    
    [self.detailLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.addPictureBtn1);
        make.top.equalTo(self.addPictureBtn1.mas_bottom).offset(5);
        
    }];
    
    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addPictureBtn);
        make.right.equalTo(self.addPictureBtn1);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(10);
    
    }];

}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
//        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font   = XGFONT(15);
        _titleLabel.text = @"手持身份证正反面照片";
        
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font   = XGFONT(14);
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.text = @"身份证正面";
    }
    return _detailLabel;
}

- (UILabel *)detailLabel1{
    if (!_detailLabel1) {
        _detailLabel1 = [[UILabel alloc]init];
        _detailLabel1.font   = XGFONT(14);
        _detailLabel1.textColor = [UIColor grayColor];
        _detailLabel1.text = @"身份证反面";

    }
    return _detailLabel1;
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
/**
 *  1-消费者头像；2-商家头像；3-消费者身份证正面；4-消费者身份证反面；5-商家身份证正面；6-商家身份证反面；7-商家营业执照；；8-消费者半身身份证正面照；9-商家半身身份证正面照；10-商品照片；
 *
 *
 */
- (UIButton *)addPictureBtn{
    if (!_addPictureBtn) {
        _addPictureBtn = [[UIButton alloc]init];
        _addPictureBtn.backgroundColor = [UIColor yellowColor];
        [_addPictureBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _addPictureBtn.tag = 3;
        [_addPictureBtn addTarget:self action:@selector(addPictureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addPictureBtn;
}


- (UIButton *)addPictureBtn1{
    if (!_addPictureBtn1) {
        _addPictureBtn1 = [[UIButton alloc]init];
        _addPictureBtn1.backgroundColor = [UIColor greenColor];
        _addPictureBtn1.tag = 4;
        [_addPictureBtn1 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_addPictureBtn1 addTarget:self action:@selector(addPictureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addPictureBtn1;
}

- (void)setContent:(NSDictionary *)dic{
    NSString *frontStr = dic[@"frontPic"];
    NSString *fullFrontUrl = [IMAGE_BASE_URL stringByAppendingPathComponent:frontStr];
    [ImageUtils loadImageWithUrl:fullFrontUrl button:self.addPictureBtn placeHolder:[UIImage imageNamed:@"cha_icon"]];
    
    NSString *reverseStr = dic[@"reversePic"];
    NSString *fullReverseUrl = [IMAGE_BASE_URL stringByAppendingPathComponent:reverseStr];
    [ImageUtils loadImageWithUrl:fullReverseUrl button:self.addPictureBtn1 placeHolder:[UIImage imageNamed:@"cha_icon"]];
}


- (void)addPictureBtnAction:(UIButton *)btn{
    if (self.addPictureBlock) {
        self.addPictureBlock(btn);
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
