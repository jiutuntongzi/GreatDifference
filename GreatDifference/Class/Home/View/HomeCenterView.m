//
//  HomeCenterView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 16/11/2.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "HomeCenterView.h"
#import "HomeCenterCollectionViewCell.h"
#import "StoreModel.h"

@interface HomeCenterView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) NSMutableArray    *dataSource;
@end
@implementation HomeCenterView
static NSString *cellIdentifier = @"reuseCell";

#pragma mark -- initialization
- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:[HomeCenterCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
}


#pragma mark -- getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 55)/4, (SCREEN_WIDTH - 80)/3);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 10;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:8];
        StoreModel *store1 = [[StoreModel alloc]initWithTitle:@"便利店" imageNamed:@"home_convstore"];
        store1.storeTypeId = @"1";
        StoreModel *store2 = [[StoreModel alloc]initWithTitle:@"母婴店" imageNamed:@"home_baby"];
        store2.storeTypeId = @"2";

        StoreModel *store3 = [[StoreModel alloc]initWithTitle:@"美容" imageNamed:@"home_beauty"];
        store3.storeTypeId = @"3";
        StoreModel *store4 = [[StoreModel alloc]initWithTitle:@"酒店" imageNamed:@"home_hotel"];
        store4.storeTypeId = @"4";

        StoreModel *store5 = [[StoreModel alloc]initWithTitle:@"美食" imageNamed:@"home_food"];
        store5.storeTypeId = @"5";

        StoreModel *store6 = [[StoreModel alloc]initWithTitle:@"健身" imageNamed:@"home_fitness"];
        store6.storeTypeId = @"6";

        StoreModel *store7 = [[StoreModel alloc]initWithTitle:@"生活服务" imageNamed:@"home_life"];
        store7.storeTypeId = @"7";

        [_dataSource addObject:store1];
        [_dataSource addObject:store2];
        [_dataSource addObject:store3];
        [_dataSource addObject:store4];
        [_dataSource addObject:store5];
        [_dataSource addObject:store6];
        [_dataSource addObject:store7];
        
    }
    return _dataSource;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCenterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.storeModel = [self.dataSource objectAtIndex:indexPath.row];
//    cell.backgroundColor = [UIColor redColor];
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake((SCREEN_WIDTH - 55)/4, (SCREEN_WIDTH - 60)/3);
//
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    StoreModel  *model = self.dataSource[indexPath.row];
    if (self.centerCellBlock) {
        self.centerCellBlock(indexPath,model);
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
