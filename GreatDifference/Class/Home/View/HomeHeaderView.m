//
//  HomeHeaderView.m
//  SweePea
//
//  Created by xiaodou_yxg on 16/6/24.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "HomeHeaderView.h"
#import "HeadCollectionViewCell.h"
//
#import "ImageUtils.h"
#import "SDWebImageManager.h"
#import "BannerModel.h"

@interface HomeHeaderView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) UIPageControl     *pageControl;
@property (nonatomic, strong) NSArray           *dataSource;
@property (nonatomic, strong) NSTimer           *timer;
@property (nonatomic, assign) BannerType        type;
@end
@implementation HomeHeaderView

static NSString *cellIdentifier = @"reuseCell";
static NSInteger kMultiples     = 1000;

#pragma mark -- initialization 初始化
- (instancetype)initWithFrame:(CGRect)frame bannerType:(BannerType )type
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
        self.type = type;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self setupSubviews];
    }
    return self;
}

#pragma mark -- getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = self.size;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.dataSource = self;
        collectionView.delegate   = self;
        [collectionView registerClass:[HeadCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        _collectionView = collectionView;
        _collectionView.backgroundColor = [UIColor yellowColor];
        _collectionView.bounces = NO;
        _collectionView.pagingEnabled = YES;
    }
    return _collectionView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20)];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.defersCurrentPageDisplay = YES;
        _pageControl.numberOfPages = self.dataSource.count;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSArray alloc]init];
    }
    return _dataSource;
}

#pragma mark -- setupSubviews
- (void)setupSubviews
{
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
}

- (void)setupTimer
{
    if ([self respondsToSelector:@selector(updateTimer:)]) {
        if (!_timer) {
            if (self.dataSource.count<2) {
                return;
            }
            _timer = [NSTimer timerWithTimeInterval:4.8f target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        }
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count * kMultiples;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    BannerModel *banner = [self.dataSource objectAtIndex:indexPath.row%self.dataSource.count];
    UIImage *locaImage = [UIImage imageNamed:banner.bannerIcon];
    if (locaImage) {
        cell.imageView.image = locaImage;
        return cell;
    }
    NSString *imageStr = [IMAGE_BASE_URL stringByAppendingPathComponent:banner.bannerIcon];
    
    NSURL *imageUrl = [NSURL URLWithString:imageStr];
    [ImageUtils loadImageWithUrl:imageStr imageView:cell.imageView placeHolder:nil];
    if (self.type == BannerTypeHome) {
        return cell;
    }
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    BOOL existBool = [manager diskImageExistsForURL:imageUrl];//判断是否有缓存
    UIImage * image;
    if (existBool) {
        image = [[manager imageCache] imageFromDiskCacheForKey:imageUrl.absoluteString];
    }else{
        NSData *data = [NSData dataWithContentsOfURL:imageUrl];
        image = [UIImage imageWithData:data];
    }
    if (!image) {
        return cell;
    }
    CGFloat itemH = self.size.height;
    CGFloat itemW = self.size.width;
    //根据image的比例来设置宽带
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    if (imageWidth/itemW>imageHeight/itemH) {
//        itemW = imageWidth / imageHeight * itemH;
        itemH = itemW / imageWidth * imageHeight;

    }else{
        itemW = itemH / imageHeight * imageWidth;
    }

    cell.imageView.frame = CGRectMake((self.size.width-itemW)/2, (self.size.height-itemH)/2, itemW, itemH);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

}

- (void)updateTimer:(NSTimer *)timer
{
    CGFloat offset = self.collectionView.contentOffset.x;
    NSInteger row = ((offset + self.collectionView.frame.size.width) * (self.dataSource.count * kMultiples))/self.collectionView.contentSize.width;
    if (row<0 || row> 10000) {
        return;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger count = self.dataSource.count;
    NSInteger index = (NSInteger)(round(scrollView.contentOffset.x /self.collectionView.bounds.size.width )) %count;

    self.pageControl.currentPage = index;
    
    NSInteger item = scrollView.contentOffset.x/self.collectionView.size.width;
    if (item == self.dataSource.count * kMultiples - 1 || item == 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count * kMultiples * 0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];

    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.frame;
    
    if (self.dataSource.count) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count * kMultiples * 0.5f inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }

    CGRect pageControlFrame = self.pageControl.frame;
    pageControlFrame.origin.x = 0;
    pageControlFrame.origin.y = self.height - 30;
    pageControlFrame.size = CGSizeMake(self.width, 20);
    self.pageControl.frame = pageControlFrame;
    
}

- (void)setDataSources:(NSArray *)images{
    self.dataSource = images;
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = self.dataSource.count;
    [self setupTimer];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
