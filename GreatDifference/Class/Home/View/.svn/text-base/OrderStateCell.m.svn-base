//
//  OrderStateCell.m
//  GreatDifference-business
//
//  Created by xiaodou_yxg on 2017/1/3.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "OrderStateCell.h"
#import "OrderStatusModel.h"
#import "RefundImgCollectionViewCell.h"
#import "ImageUtils.h"
@interface OrderStateCell ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UIView          *lineView;
@property (nonatomic, strong) UILabel         *dotLabel;
@property (nonatomic, strong) UIImageView     *stateIcon;

@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UILabel         *detailLabel;
@property (nonatomic, strong) UILabel         *timeLabel;
@property (nonatomic, strong) UICollectionView      *collectionView;
@property (nonatomic, strong) NSArray      *imagesArray;
@end
@implementation OrderStateCell
static NSString *cellIdentifeir = @"reuseCell";

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.dotLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.collectionView];

    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(1);
        
    }];
    
    [self.dotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(6.5);
        make.top.equalTo(@10);
        make.height.width.mas_equalTo(8);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView.mas_right).offset(10);
        make.top.equalTo(self.dotLabel);
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.titleLabel);
        
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        
    }];
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = THEMECOLOR;
    }
    return _lineView;
}

- (UILabel *)dotLabel{
    if (!_dotLabel) {
        _dotLabel = [[UILabel alloc]init];
        _dotLabel.backgroundColor = THEMECOLOR;
        _dotLabel.layer.cornerRadius = 4;
        _dotLabel.layer.masksToBounds = YES;
    }
    return _dotLabel;
}

- (UIImageView *)stateIcon{
    if (!_stateIcon) {
        _stateIcon = [[UIImageView alloc]init];
        
    }
    return _stateIcon;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        //        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font    = XGFONT(15);
        _titleLabel.text    = @"买家下单";
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font    = XGFONT(15);
        _timeLabel.text = @"2016-12-30 16:20";
    }
    return _timeLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.font    = XGFONT(15);
        _detailLabel.text    = @"等待商家确认";

    }
    return _detailLabel;
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 55)/3, (SCREEN_WIDTH - 55)/3);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        flowLayout.minimumInteritemSpacing = 10;
        //        flowLayout.minimumLineSpacing = 20;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10);
        _collectionView.dataSource = self;
        _collectionView.delegate    = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifeir];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[RefundImgCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifeir];
    }
    return _collectionView;
}

#pragma mark -- collectionViewDataSource  && Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imagesArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //    NSDictionary *dic = self.imagesArray[indexPath.section];
    RefundImgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifeir forIndexPath:indexPath];
    NSString *imageStr = self.imagesArray[indexPath.row];
    [ImageUtils loadImageWithLastComponentUrl:imageStr imageView:cell.picImg placeHolder:nil];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)setOrderStatus:(OrderStatusModel *)orderStatus{
    _orderStatus = orderStatus;
    //    orderStatus.content = @"我爱你亲爱的姑娘见到你心就发凉哦ljlasj拉接收到了老师看见的分拉近";
    self.titleLabel.text    = orderStatus.type;
    self.detailLabel.text   = orderStatus.content;
    self.timeLabel.text     = orderStatus.createTime;
    
    self.detailLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - CGRectGetMaxX(self.lineView.frame) - 20;
    
    self.imagesArray = orderStatus.images;
    if (self.imagesArray.count>0) {
        [self.collectionView reloadData];
    }
    
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).offset(10);
        if (self.imagesArray.count>0) {
            make.height.mas_equalTo((SCREEN_WIDTH - 50)/3);
        }else{
            make.height.mas_equalTo(0);
        }
        make.left.equalTo(self.detailLabel);
        make.right.bottom.equalTo(self.contentView);
    }];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
