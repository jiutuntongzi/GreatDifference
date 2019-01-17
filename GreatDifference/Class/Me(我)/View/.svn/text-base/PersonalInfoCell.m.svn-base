//
//  PersonalInfoCell.m
//  SweePea
//
//  Created by xiaodou_yxg on 16/6/28.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "PersonalInfoCell.h"
#import "ImageUtils.h"

#define kAvatarWidth    60


@interface PersonalInfoCell ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) UILabel           *titleLabel;
@property (nonatomic, strong) UIView            *pickerAccessoryView;

@property (nonatomic, strong) UIPickerView      *pickerView;
@property (nonatomic, strong) NSArray           *pickerDataSource;
@property (nonatomic, assign) CellType          cellType;
@property (nonatomic, strong) UIImageView       *qrCodeImageView;

@end

@implementation PersonalInfoCell

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
    
    if (self.cellType == CellTypePicker) {
        [self.contentView addSubview:self.textField];
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
        _detailLabel.numberOfLines = 3;
//        _detailLabel.backgroundColor = [UIColor redColor];
    }
    return _detailLabel;
}

- (UIImageView *)avatarImg{
    if (!_avatarImg) {
        _avatarImg = [[UIImageView alloc]init];
        _avatarImg.layer.cornerRadius = kAvatarWidth/2;
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

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.userInteractionEnabled = YES;
        _textField.enabled = YES;
//        _textField.
    }
    return _textField;
}

- (UIView *)pickerAccessoryView
{
    if (!_pickerAccessoryView) {
        _pickerAccessoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        _pickerAccessoryView.backgroundColor = [UIColor grayColor];
        
        UIButton *finishBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 10, 50, 25)];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [finishBtn addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
        [_pickerAccessoryView addSubview:finishBtn];
    }
    return _pickerAccessoryView;
}

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (NSArray *)pickerDataSource{
    if (!_pickerDataSource) {
        _pickerDataSource = @[@"---", @"男", @"女"];
    }
    return _pickerDataSource;
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)updateConstraints
{
    WS(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.top.equalTo(@(kSpace));
//        make.right.lessThanOrEqualTo(self.detailLabel.mas_left);
        make.bottom.equalTo(@(-kSpace));
    }];

    if (self.cellType == CellTypeAvatar) {
        [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself).offset(kSpace);
            make.right.equalTo(weakself).offset(-3*kSpace);
            make.bottom.equalTo(weakself).offset(-kSpace);
            make.width.equalTo(self.avatarImg.mas_height);
        }];
    }
    else if(self.cellType == CellTypeqrCode){
        [self.qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself).offset(kSpace);
            make.right.equalTo(weakself).offset(-3*kSpace);
            make.bottom.equalTo(weakself).offset(-kSpace);
            make.width.equalTo(self.qrCodeImageView.mas_height);
        }];
    }else{
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(2*kSpace);
            make.top.bottom.equalTo(self.titleLabel);
            make.right.equalTo(weakself).offset(-3*kSpace);
            make.width.mas_greaterThanOrEqualTo(30);
        }];
    }

    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.preferredMaxLayoutWidth = SCREEN_WIDTH/3;
    self.detailLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - CGRectGetMaxX(self.titleLabel.frame) - 4*kSpace;
    [super layoutSubviews];
    
}

- (void)didClickedDatePicker:(UIDatePicker *)datePicker{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:datePicker.date];
    self.detailLabel.text = [NSString stringWithFormat:@"%@", dateStr];
}
- (void)finishAction:(UIButton *)btn
{
    [self.textField resignFirstResponder];
    if (self.finishedBlock) {
        NSString *detail = @"2";
        if ([self.detailLabel.text isEqualToString:@"男"]) {
            detail = @"1";
        }else if ([self.detailLabel.text isEqualToString:@"女"]){
            detail = @"0";
        }
        self.finishedBlock(detail);
    }
}


- (void)setContent:(NSDictionary *)dic
{
    NSString *title = dic[@"title"];
    NSString *detail = dic[@"detail"];
    self.titleLabel.text = title;
    
    if (self.cellType == CellTypeAvatar) {
        NSString *imageUrl = detail;
        NSString *fullImageUrl = [IMAGE_BASE_URL stringByAppendingPathComponent:imageUrl];
        [ImageUtils loadImageWithUrl:fullImageUrl imageView:self.avatarImg placeHolder:[UIImage imageNamed:@"me_default_icon"]];
        
    }else{
        self.detailLabel.text = detail;
    }
    
    if (self.cellType == CellTypePicker) {
        if ([title isEqualToString:@"性别"]) {
            self.textField.inputView = self.pickerView;
            
        }
        NSInteger row = 0;
        if ([detail isEqualToString:@"女"]) {
            row = 2;
        }else if ([detail isEqualToString:@"男"]){
            row = 1;
        }
        [self.pickerView selectRow:row inComponent:0 animated:YES];
        self.textField.inputAccessoryView = self.pickerAccessoryView;
    }
}

- (NSString *)getCellTitle{
    return self.titleLabel.text;
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerDataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    return self.pickerDataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *content = self.pickerDataSource[row];
    self.detailLabel.text = [content isEqualToString:@"---"]?@"":content;
}


- (NSString *)filtString:(NSString *)imageStr{
    return [imageStr stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
