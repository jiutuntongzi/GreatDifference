//
//  ConfirmOrderCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/28.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ConfirmOrderCell.h"
#import "PPNumberButton.h"
#import "GoodsModel.h"

@interface ConfirmOrderCell ()<UITextFieldDelegate, UIAlertViewDelegate>
@property (nonatomic, assign) OrderCellType        cellType;
@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UILabel         *detaiLabel;
@property (nonatomic, strong) PPNumberButton  *numberBtn;
@property (nonatomic, assign) NSInteger       maxIntegral;
@end
@implementation ConfirmOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(OrderCellType )cellType{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellType   = cellType;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(70);
    }];
    
    if (self.cellType == OrderCellTypeNormal) {
        [self.contentView addSubview:self.detaiLabel];
        
        [self.detaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(10);
            make.top.equalTo(self.titleLabel);
            make.right.equalTo(self.contentView).offset(-10);
        }];
        
    }else if (self.cellType == OrderCellTypeTextField){
        
        [self.contentView addSubview:self.detailTextField];
        
        [self.detailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(10);
            make.top.equalTo(self.titleLabel);
//            make.centerY.equalTo(self.contentView);
            make.height.mas_greaterThanOrEqualTo(18);
            make.right.equalTo(self.contentView).offset(-10);
        }];
        
    }else if (self.cellType == OrderCellTypeNum){
        
        [self.contentView addSubview:self.numberBtn];
        
        [self.numberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel);
            make.right.equalTo(self.contentView).offset(-10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(25);
        }];
    }

}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}

- (UILabel *)detaiLabel{
    if (!_detaiLabel) {
        _detaiLabel = [[UILabel alloc]init];
        _detaiLabel.textColor = [UIColor grayColor];
        
    }
    return _detaiLabel;
}

- (UITextField *)detailTextField{
    if (!_detailTextField) {
        _detailTextField = [[UITextField alloc]init];
        _detailTextField.placeholder    = @"选填:对本次交易的说明";
        _detailTextField.font = XGFONT(14);
        _detailTextField.delegate = self;
//        _detailTextField.backgroundColor = [UIColor redColor];
    }
    return _detailTextField;
}

- (PPNumberButton *)numberBtn{
    if (!_numberBtn) {
        _numberBtn = [[PPNumberButton alloc]init];
        _numberBtn.frame = CGRectMake(0, 0, 80, 25 );

        [_numberBtn setImageWithincreaseImage:[UIImage imageNamed:@"shopCart_add_icon"] decreaseImage:[UIImage imageNamed:@"shopCart_decrease_icon"]];
        
    }
    return _numberBtn;
}

#pragma mark -- textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.titleLabel.text isEqualToString:@"买家留言"]) {
        return YES;
    }
    return [self validateNumber:string];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    XGLog(@"lkdjs%@",self.titleLabel.text);
    if ([self.titleLabel.text isEqualToString:@"使用积分"]) {
        if ([textField.text integerValue] > self.maxIntegral) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"使用积分不能大于可用积分" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alertView.delegate = self;
            [alertView show];
            return;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_USE_INTEGRAL object:textField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    self.detailTextField.text = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_USE_INTEGRAL object:nil];
}

- (void)setContentDic:(NSDictionary *)dic{
    if (!dic || ![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSString *title = dic[@"title"];
    self.titleLabel.text = title;
    switch (self.cellType) {
        case OrderCellTypeNormal:
            self.detaiLabel.text = dic[@"detail"];
            break;
        case OrderCellTypeNum:
//            self.numberBtn setf
            break;
            
        case OrderCellTypeTextField:
            self.detailTextField.placeholder = dic[@"placeholder"];
            self.detailTextField.text       = dic[@"detail"];
            self.detailTextField.keyboardType = UIKeyboardTypeDefault;
            if ([title isEqualToString:@"使用积分"]) {
                self.detailTextField.keyboardType =UIKeyboardTypeNumberPad;
                self.maxIntegral = [dic[@"maxIntegral"] integerValue];
            }
            break;

        default:
            break;
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
