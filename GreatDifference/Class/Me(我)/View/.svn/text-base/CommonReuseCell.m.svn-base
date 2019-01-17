//
//  CommonReuseCell.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/12/20.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "CommonReuseCell.h"

@interface CommonReuseCell ()<UITextFieldDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) UILabel           *titleLabel;
@property (nonatomic, strong) UILabel           *detailLabel;
@property (nonatomic, strong) UITextField       *detailTextField;
@property (nonatomic, assign) CommonCellType        cellType;



@end
@implementation CommonReuseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(CommonCellType )cellType{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellType = cellType;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{

    switch (self.cellType) {
        case CommonCellTypeNormal:{
            [self.contentView addSubview:self.titleLabel];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@10);
                make.centerY.equalTo(self);
            }];
            
            [self.contentView addSubview:self.detailLabel];
            [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-10);
                make.top.equalTo(@10);
            }];
        }
            break;
        case CommonCellTypeTF:{
            [self.contentView addSubview:self.detailTextField];
            [self.detailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView.mas_right).offset(-10);
                make.centerY.equalTo(self.contentView);
                make.height.mas_equalTo(30);
            }];
            [self.contentView addSubview:self.titleLabel];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@10);
                make.right.equalTo(self.detailTextField.mas_left).offset(-10);
                make.centerY.equalTo(self.detailTextField);
            }];
            
        }
            break;
            
        default:
            break;
    }
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
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

- (UITextField *)detailTextField{
    if (!_detailTextField) {
        _detailTextField = [UITextField new];
        _detailTextField.font = XGFONT(15);
        _detailTextField.textAlignment = NSTextAlignmentRight;
        _detailTextField.delegate   = self;
//        _detailTextField.backgroundColor = [UIColor redColor];
    }
    return _detailTextField;
}

#pragma mark -- textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (![self.titleLabel.text isEqualToString:@"提现金额"]) {
        return YES;
    }
    return [self validateNumber:string];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (![self.titleLabel.text isEqualToString:@"提现金额"]) {
        return;
    }
//    if ([textField.text integerValue] < 500) {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提现金额不能小于500" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        alertView.delegate = self;
//        [alertView show];
//    }
//
//    NSInteger leftCount = [textField.text integerValue]%100;
//    
//    if (leftCount !=0) {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提现金额必须为100的整数" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        alertView.delegate = self;
//        [alertView show];
//    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    self.detailTextField.text = @"";
}
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (void)setContentDict:(NSDictionary *)dict{
    self.titleLabel.text    = dict[@"title"];
    if (self.cellType == CommonCellTypeNormal) {
        self.detailLabel.text   = dict[@"detail"];
    }else if (self.cellType == CommonCellTypeTF){
        self.detailTextField.text   = dict[@"detail"];
        self.detailTextField.placeholder = dict[@"placeHolder"];
    }
    
    if ([self.titleLabel.text isEqualToString:@"提现密码"]) {
        self.detailTextField.secureTextEntry = YES;
    }else{
        self.detailTextField.secureTextEntry = NO;
        
    }
    
    if ([self.titleLabel.text isEqualToString:@"提现金额"]) {
        self.detailTextField.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        self.detailTextField.keyboardType = UIKeyboardTypeDefault;

    }
}

- (NSString *)getCellTitle{
    return self.titleLabel.text;
}

- (NSString *)getCellDetail{
    return self.detailTextField.text;
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
