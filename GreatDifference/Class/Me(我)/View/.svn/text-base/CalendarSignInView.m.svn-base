//
//  CalendarSignInView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/16.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "CalendarSignInView.h"
#import "WeekCollectionViewCell.h"
#import "CalendarCollectionViewCell.h"
#import "SignInCollectionHeaderView.h"
#import "SignInCollectionFooterView.h"
#import "SignInModel.h"

@interface CalendarSignInView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView      *collectionView;
@property (nonatomic, strong) NSMutableArray        *dataSource;
@property (nonatomic, strong) NSArray               *weeks;

@end
@implementation CalendarSignInView
static NSString *weekCell       = @"weekReuseCell";
static NSString *cellIdentifier = @"reuseCell";
static NSString *headerView     = @"headerView";
static NSString *footerViewId     = @"footerView";

#pragma mark -- initialization
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dataSource = dataSource;
        [self addSubview:self.collectionView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{

    return [self initWithFrame:frame dataSource:nil];
}

#pragma mark -- getter
- (NSArray *)weeks{
    if (_weeks) {
        return _weeks;
    }
    _weeks = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    return _weeks;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout  = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 8)/7, (SCREEN_WIDTH - 8)/7);
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.30];
        _collectionView.dataSource  = self;
        _collectionView.delegate    = self;
        _collectionView.bounces = YES;
//        _collectionView.fl
        [_collectionView registerClass:[WeekCollectionViewCell class] forCellWithReuseIdentifier:weekCell];
        [_collectionView registerClass:[CalendarCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        [_collectionView registerClass:[SignInCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerView];
        
        [_collectionView registerClass:[SignInCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerViewId];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);

    }
    return _collectionView;
}

#pragma mark -- collectionViewDataSource && delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 7;
    }
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        WeekCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:weekCell forIndexPath:indexPath];
        cell.titleLabel.text = self.weeks[indexPath.row];
        return cell;
    }
    CalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.signDaysModel    = self.dataSource[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        CGSize size = {SCREEN_WIDTH, 40};
        return size;
    }
    else
    {
        CGSize size = {SCREEN_WIDTH, 0};
        return size;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if(section == 1)
    {
        CGSize size = {SCREEN_WIDTH, 180};
        return size;
    }
    else
    {
        CGSize size = {SCREEN_WIDTH, 0};
        return size;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SignInCollectionHeaderView *topView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerView forIndexPath:indexPath];
        topView.timeLabel.text  = self.signInModel.currentDay;
        return topView;
    }else{
        WS(self);
        SignInCollectionFooterView  *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerViewId forIndexPath:indexPath];
        if ([self.signInModel.isSign isEqualToString:@"1"]) {
            footerView.signInBtn.selected = YES;
            footerView.signInBtn.userInteractionEnabled = NO;
            footerView.signInBtn.backgroundColor = [UIColor lightGrayColor];
        }
        __block SignInCollectionFooterView *blockFooter = footerView;
        footerView.signInBlock = ^{
            if ([self.delegate respondsToSelector:@selector(signInView:didClickedSignBtn:)]) {
                [weakself.delegate signInView:self didClickedSignBtn:blockFooter.signInBtn];
            }
        };

        return footerView;
    }

    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark -- configureData

- (void)setSignInModel:(SignInModel *)signInModel{
    _signInModel = signInModel;
    
    
    NSInteger maxIndex = [signInModel.monthFirstDayWeekTag integerValue];
    for (NSInteger index = 0; index < maxIndex-1; index++) {
        SignDaysModel *model = [[SignDaysModel alloc]init];
        model.isSign = @"2";
        [self.dataSource addObject:model];
    }
    [self.dataSource addObjectsFromArray:signInModel.signDays];
    [self.collectionView reloadData];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
