//
//  RefundViewCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/17.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "RefundViewCell.h"
#import "ExpressModel.h"

@interface RefundViewCell ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UILabel         *detailLabel;
@property (nonatomic, strong) UITextField     *textField;
@property (nonatomic, strong) NSArray         *pickerDataSource;
@property (nonatomic, strong) UIView          *pickerAccessoryView;

@property (nonatomic, strong) UIPickerView    *pickerView;
@property (nonatomic, assign) CellType        type;
@property (nonatomic, strong) ExpressModel      *selectExpress;
@end
@implementation RefundViewCell

#pragma mark
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(CellType )cellType{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _type = cellType;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.tapTextField];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.width.mas_equalTo(90);
    }];
    if (self.type == CellTypeNormal) {
        
        [self.contentView addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(10);
            make.top.equalTo(self.titleLabel);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
    }else if (self.type == CellTypeAvatar){
        
        [self.contentView addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(10);
            make.top.equalTo(self.titleLabel);
            make.right.equalTo(self.contentView.mas_right).offset(0);
        }];
    }

    
    
}

#pragma mark -- getter
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = XGFONT(15);

    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.font = XGFONT(15);

    }
    return _detailLabel;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [UITextField new];
        _textField.font = XGFONT(15);
        _textField.textColor = [UIColor grayColor];
    }
    return _textField;
}

- (UITextField *)tapTextField{
    if (!_tapTextField) {
        _tapTextField = [UITextField new];
        _tapTextField.inputView = self.pickerView;
        _tapTextField.inputAccessoryView = self.pickerAccessoryView;
    }
    return _tapTextField;
}

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
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



#pragma mark -- UIPickerViewDataSource && delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerDataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if ([self.titleLabel.text isEqualToString:@"物流公司:"]) {
        ExpressModel *model = self.pickerDataSource[row];
        return model.expressCompanyName;
    }
    return self.pickerDataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if ([self.titleLabel.text isEqualToString:@"物流公司:"]) {
        ExpressModel *model = self.pickerDataSource[row];
        self.selectExpress = model;
        self.detailLabel.text = model.expressCompanyName;

    }else{
        NSString *content = self.pickerDataSource[row];
        self.detailLabel.text = content;
    }

}

#pragma mark -- configureData
- (void)setContentDict:(NSDictionary *)dic{
    self.titleLabel.text    = dic[@"title"];
    self.textField.text     = dic[@"detail"];
    
}

- (void)setDataSource:(NSArray *)dataSource{
    _pickerDataSource = dataSource;
    
}

- (NSString *)getCellDetail{
    
    return self.textField.text;
}

#pragma mark -- clickedAction
- (void)finishAction:(UIButton *)btn
{
    [self.tapTextField resignFirstResponder];
    if (self.finishBlock) {
        NSString *detail = self.detailLabel.text;
        if ([self.titleLabel.text isEqualToString:@"物流公司:"]) {
            detail = self.selectExpress.expressCompanyId;
        }
        self.finishBlock(detail);
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
