//
//  MyAddressCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/18.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MyAddressCell.h"

@interface MyAddressCell ()
@property (nonatomic, strong) UILabel         *nameLabel;
@property (nonatomic, strong) UILabel         *phoneLabel;
@property (nonatomic, strong) UILabel         *addressLabel;
@property (nonatomic, strong) UIButton        *editBtn;

@end
@implementation MyAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.addressLabel];
//    [self.contentView addSubview:self.editBtn];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(kSpace);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.phoneLabel.mas_left).offset(-10);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
//    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(@(-kSpace));
//        make.centerY.equalTo(self.contentView);
//        
//    }];
    
    
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"石丹";
        _nameLabel.font = XGFONT(15);
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
//        _phoneLabel.text    = @"18680346615";
//        _phoneLabel.textColor = [UIColor grayColor];
        _phoneLabel.font = XGFONT(15);

    }
    return _phoneLabel;
}

- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
//        _addressLabel.text = @"[住宅]广东省深圳市南山区白石洲二纺58-6";
        _addressLabel.textColor = [UIColor grayColor];
        _addressLabel.font  = XGFONT(13);
    }
    return _addressLabel;
}

//- (UIButton *)editBtn{
//    if (!_editBtn) {
//        _editBtn = [[UIButton alloc]init];
//        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
//        [_editBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [_editBtn addTarget:self action:@selector(editAddressAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _editBtn;
//}

- (void)setAddress:(AddressModel *)address{
    _address = address;
    if (address == nil) {
        self.nameLabel.text = @"请选择收货地址";
        self.nameLabel.textColor = THEMECOLOR;
        return;
    }
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.text     = address.consignee;
    self.phoneLabel.text    = address.mob;
    self.addressLabel.text  =[NSString stringWithFormat:@"%@%@%@%@",address.province, address.city, address.district, address.address];
}

- (void)setOrderDetail:(OrderModel *)orderDetail{
    _orderDetail = orderDetail;
    self.nameLabel.text = orderDetail.consignee;
    self.phoneLabel.text    = orderDetail.mob;
    self.addressLabel.text  =[NSString stringWithFormat:@"%@%@%@%@",orderDetail.province, orderDetail.city, orderDetail.district, orderDetail.address];
}

- (void)setOrderListModel:(OrderListModel *)orderListModel{
    AddressModel *address = orderListModel.consignee;
    self.nameLabel.text = address.consignee;
    self.phoneLabel.text    = address.mob;
    self.addressLabel.text  =[NSString stringWithFormat:@"%@%@%@%@",address.province, address.city, address.district, address.address];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
