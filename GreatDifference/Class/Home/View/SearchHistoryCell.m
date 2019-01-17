//
//  SearchHistoryCell.m
//  SweePea
//
//  Created by xiaodou_yxg on 16/7/21.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "SearchHistoryCell.h"

@interface SearchHistoryCell ()
@property (nonatomic, strong) UIImageView   *icon;
@end
@implementation SearchHistoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    _icon = [[UIImageView alloc]initWithFrame:CGRectMake(kSpace, kSpace, 20, 20)];
    _icon.image = [UIImage imageNamed:@"search_history_icon"];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame) + kSpace, kSpace, SCREEN_WIDTH - CGRectGetMaxX(self.icon.frame) - kSpace * 2, 20)];
    _titleLabel.textColor =[UIColor grayColor];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.titleLabel];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
