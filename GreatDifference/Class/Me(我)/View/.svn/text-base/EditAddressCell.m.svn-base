//
//  EditAddressCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/18.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "EditAddressCell.h"
#import "UIUtils.h"

@interface EditAddressCell ()
@property (nonatomic, strong) UILabel               *titleLabel;
@property (nonatomic, strong) AddressTypeView       *typeView;
@property (nonatomic, assign) EditAddressCellType    cellType;
@end
@implementation EditAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(EditAddressCellType )cellType
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
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(kSpace);
        make.bottom.equalTo(self.contentView).offset(-kSpace);
    }];
    
    switch (self.cellType) {
        case EditAddressCellTypeNormal:{
            [self.contentView addSubview:self.detailTextView];
            
            [self.detailTextView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(90);
                make.top.equalTo(self.titleLabel).offset(-5);
                make.right.equalTo(self.contentView).offset(-20);
                make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            }];
        }
            break;
        case EditAddressCellTypeJump:{
            [self.contentView addSubview:self.detailLabel];
            [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(95);
                make.top.bottom.equalTo(self.titleLabel);
                make.right.equalTo(self.contentView).offset(-20);
            }];
        }
            break;
        case EditAddressCellTypeSelect:{
            [self.contentView addSubview:self.typeView];
            [self.typeView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(90);
                make.top.bottom.right.equalTo(self.contentView);
            }];
        }
            break;
    }
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font    = XGFONT(15);
        
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.font    = XGFONT(15);

    }
    return _detailLabel;
}

- (UITextView *)detailTextView{
    if (!_detailTextView) {
        _detailTextView = [[UITextView alloc]init];
        _detailTextView.textColor = [UIColor grayColor];
        _detailTextView.font = XGFONT(15);
        [_detailTextView sizeToFit];
        [_detailTextView sizeThatFits:CGSizeMake(SCREEN_WIDTH/2, MAXFLOAT)];
        [_detailTextView setScrollEnabled:NO];
    }
    return _detailTextView;
}

- (AddressTypeView *)typeView{
    if (!_typeView) {
        _typeView = [[AddressTypeView alloc]init];
    }
    return _typeView;
}

- (void)setContentDic:(NSDictionary *)dic{
    self.titleLabel.text    = dic[@"title"];
    switch (self.cellType) {
        case EditAddressCellTypeNormal:{
            self.detailTextView.text   = dic[@"detail"];
        }
            break;
        case EditAddressCellTypeJump:{

            self.detailLabel.text   = dic[@"detail"];
        }
            break;
        case EditAddressCellTypeSelect:{
            
        }
            break;
    }
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


@implementation AddressTypeView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.companyBtn];
        [self addSubview:self.houseBtn];
        [self addSubview:self.schoolBtn];
        [self addSubview:self.otherBtn];
        
        [self.companyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(10);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(25);
        }];
        
        [self.houseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.companyBtn.mas_right).offset(10);
            make.top.width.height.equalTo(self.companyBtn);
        }];
        
        [self.schoolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.houseBtn.mas_right).offset(10);
            make.top.width.height.equalTo(self.companyBtn);
        }];
        
        [self.otherBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.schoolBtn.mas_right).offset(10);
            make.top.width.height.equalTo(self.companyBtn);
        }];
    }
    return self;
}

- (UIButton *)companyBtn{
    if (!_companyBtn) {
        _companyBtn = [[UIButton alloc]init];
        [_companyBtn setTitle:@"公司" forState:UIControlStateNormal];
        [_companyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_companyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _companyBtn.selected = YES;
        _companyBtn.titleLabel.font = XGFONT(15);
        [_companyBtn setBackgroundImage:[self getBackImage] forState:UIControlStateSelected];
        _companyBtn.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35].CGColor;
        _companyBtn.layer.borderWidth = 0.5;
        _companyBtn.tag     = 100;
        [_companyBtn addTarget:self action:@selector(didClickedAddressType:) forControlEvents:UIControlEventTouchUpInside];


        
    }
    return _companyBtn;
}

- (UIButton *)houseBtn{
    if (!_houseBtn) {
        _houseBtn = [[UIButton alloc]init];
        [_houseBtn setTitle:@"住宅" forState:UIControlStateNormal];
        [_houseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_houseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_houseBtn setBackgroundImage:[self getBackImage] forState:UIControlStateSelected];
        _houseBtn.titleLabel.font = XGFONT(15);
        _houseBtn.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35].CGColor;
        _houseBtn.layer.borderWidth = 0.5;
        _houseBtn.tag     = 101;

        [_houseBtn addTarget:self action:@selector(didClickedAddressType:) forControlEvents:UIControlEventTouchUpInside];


    }
    return _houseBtn;
}

- (UIButton *)schoolBtn{
    if (!_schoolBtn) {
        _schoolBtn = [[UIButton alloc]init];
        [_schoolBtn setTitle:@"学校" forState:UIControlStateNormal];
        _schoolBtn.backgroundColor = [UIColor whiteColor];
        [_schoolBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_schoolBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_schoolBtn setBackgroundImage:[self getBackImage] forState:UIControlStateSelected];
        _schoolBtn.titleLabel.font = XGFONT(15);
        _schoolBtn.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35].CGColor;
        _schoolBtn.layer.borderWidth = 0.5;
        [_schoolBtn addTarget:self action:@selector(didClickedAddressType:) forControlEvents:UIControlEventTouchUpInside];
        _schoolBtn.tag = 102;

    }
    return _schoolBtn;
}
- (UIButton *)otherBtn{
    if (!_otherBtn) {
        _otherBtn = [[UIButton alloc]init];
        [_otherBtn setTitle:@"其他" forState:UIControlStateNormal];
        [_otherBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_otherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_otherBtn setBackgroundImage:[self getBackImage] forState:UIControlStateSelected];
        _otherBtn.titleLabel.font = XGFONT(15);
        _otherBtn.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35].CGColor;
        _otherBtn.layer.borderWidth = 0.5;
        
        [_otherBtn addTarget:self action:@selector(didClickedAddressType:) forControlEvents:UIControlEventTouchUpInside];
        _otherBtn.tag   = 103;


    }
    return _otherBtn;
}

- (void)didClickedAddressType:(UIButton *)btn{
    switch (btn.tag) {
        case 100:
            self.companyBtn.selected   = YES;
            self.houseBtn.selected = NO;
            self.schoolBtn.selected = NO;
            self.otherBtn.selected  = NO;
            break;
        case 101:
            self.companyBtn.selected   = NO;
            self.houseBtn.selected = YES;
            self.schoolBtn.selected = NO;
            self.otherBtn.selected  = NO;
            break;
        case 102:
            self.companyBtn.selected   = NO;
            self.houseBtn.selected = NO;
            self.schoolBtn.selected = YES;
            self.otherBtn.selected  = NO;
            break;
        case 103:
            self.companyBtn.selected   = NO;
            self.houseBtn.selected = NO;
            self.schoolBtn.selected = NO;
            self.otherBtn.selected  = YES;
            break;

    }
}

- (UIImage *)getBackImage{
    UIImage *image =[UIUtils imageWithFrame:CGRectMake(0, 0, 45, 25) color:THEMECOLOR];
    return image;
}
@end
