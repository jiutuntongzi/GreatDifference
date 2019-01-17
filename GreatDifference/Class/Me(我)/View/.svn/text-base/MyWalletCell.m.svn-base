//
//  MyWalletCell.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/11/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MyWalletCell.h"
#import "WalletModel.h"
#import "IntegralModel.h"

@interface MyWalletCell ()
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UILabel       *dateLabel;
@property (nonatomic, strong) UILabel       *contentLabel;
//@property (nonatomic, strong) UIButton      *lookupDetailBtn;

@end
@implementation MyWalletCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.dateLabel];
//    [self.contentView addSubview:self.lookupDetailBtn];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@8);

        make.right.equalTo(self.dateLabel.mas_left);
        make.height.mas_equalTo(20);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.height.equalTo(self.titleLabel);
        
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
//    [self.lookupDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView).offset(-10);
//        make.height.mas_equalTo(20);
//        make.bottom.equalTo(self.contentView).offset(-5);
//    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = XGFONT(15);
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = XGFONT(12);
        _contentLabel.textColor = [UIColor lightGrayColor];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _contentLabel;
}

- (UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.font = XGFONT(12);
        _dateLabel.textColor = [UIColor lightGrayColor];
    }
    return _dateLabel;
}

//- (UIButton *)lookupDetailBtn{
//    if (!_lookupDetailBtn) {
//        _lookupDetailBtn = [[UIButton alloc]init];
//        [_lookupDetailBtn setTitle:@"查看分润详情>" forState:UIControlStateNormal];
//        [_lookupDetailBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal
//         ];
//        _lookupDetailBtn.titleLabel.font    = XGFONT(13);
//    }
//    return _lookupDetailBtn;
//}
//
- (void)setWallet:(WalletModel *)wallet{
    _wallet = wallet;
    self.titleLabel.text        = wallet.title;
    self.contentLabel.text      = wallet.content;
    self.dateLabel.text         = wallet.date;
}

- (void)setIntegralModel:(IntegralModel *)integralModel{
    _integralModel = integralModel;
//    self.titleLabel.text        = integralModel.consumeType;
    self.contentLabel.text      = integralModel.descrip;
    self.dateLabel.text         = integralModel.createTime;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
