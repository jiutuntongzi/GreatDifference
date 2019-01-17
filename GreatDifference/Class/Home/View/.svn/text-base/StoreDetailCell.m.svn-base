//
//  StoreDetailCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/14.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "StoreDetailCell.h"
#import "ImageUtils.h"

@interface StoreDetailCell ()
@property (nonatomic, strong) UIImageView       *avatarImg;

@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UILabel         *detailLabel;
@property (nonatomic, strong) UIImageView       *qrCodeImageView;
@property (nonatomic, assign) CellType          cellType;

@end
@implementation StoreDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(CellType)cellType
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _cellType = cellType;
        [self setupSubviews];
        
    }
    return self;
}


- (void)setupSubviews{
    [self.contentView addSubview:self.titleLabel];
    if (self.cellType == CellTypeAvatar) {
        [self.contentView addSubview:self.avatarImg];
    }else if(self.cellType == CellTypeqrCode){
        [self.contentView addSubview:self.qrCodeImageView];
    }else{
        [self.contentView addSubview:self.detailLabel];
    }
    
    WS(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.top.equalTo(@(kSpace));
        //        make.right.lessThanOrEqualTo(self.detailLabel.mas_left);
        make.bottom.equalTo(@(-kSpace));
    }];
    
    if (self.cellType == CellTypeAvatar) {
        [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself).offset(kSpace);
            make.right.equalTo(weakself).offset(-2*kSpace);
            make.bottom.equalTo(weakself).offset(-kSpace);
            make.width.equalTo(self.avatarImg.mas_height);
        }];
    }
    else if(self.cellType == CellTypeqrCode){
        [self.qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself).offset(kSpace);
            make.right.equalTo(weakself).offset(-2*kSpace);
            make.bottom.equalTo(weakself).offset(-kSpace);
            make.width.equalTo(self.qrCodeImageView.mas_height);
        }];
    }else{
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@90);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.right.equalTo(self.contentView).offset(-2*kSpace);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
    }
    


}

#pragma mark -- getter
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        //        _titleLabel.textColor = [UIColor grayColor];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = [UIFont systemFontOfSize:15];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.textAlignment = NSTextAlignmentRight;
        _detailLabel.numberOfLines = 0;
//        _detailLabel.backgroundColor = [UIColor redColor];
    }
    return _detailLabel;
}

- (UIImageView *)avatarImg{
    if (!_avatarImg) {
        _avatarImg = [[UIImageView alloc]init];
        _avatarImg.image = [UIImage imageNamed:@"5_full"];
    }
    return _avatarImg;
}

- (UIImageView *)qrCodeImageView{
    if (!_qrCodeImageView) {
        _qrCodeImageView = [[UIImageView alloc]init];
        _qrCodeImageView.image = [UIImage imageNamed:@"qrcode_default"];
        //        _qrCodeImageView.backgroundColor = [UIColor redColor];
    }
    return _qrCodeImageView;
}


- (void)didClickedDatePicker:(UIDatePicker *)datePicker{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:datePicker.date];
    self.detailLabel.text = [NSString stringWithFormat:@"%@", dateStr];
}

- (void)setContent:(NSDictionary *)dic
{
    NSString *title = dic[@"title"];
    NSString *detail = dic[@"detail"];
    self.titleLabel.text = title;
    
    if (self.cellType == CellTypeAvatar) {
        NSString *imageUrl = detail;
        NSString *fullImageUrl = [IMAGE_BASE_URL stringByAppendingPathComponent:imageUrl];
        [ImageUtils loadImageWithUrl:fullImageUrl imageView:self.avatarImg placeHolder:[UIImage imageNamed:@"storeDetail__default_icon"]];
        
    }else{
        self.detailLabel.text = detail;
    }
    
    self.detailLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 110;
    
    
}

- (NSString *)getCellTitle{
    return self.titleLabel.text;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
