//
//  NewFeatureView.m
//  SweePea
//
//  Created by xiaodou_yxg on 16/7/12.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "NewFeatureView.h"

@interface NewFeatureView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView      *scrollView;
@property (nonatomic, strong) UIPageControl     *pageControl;
@property (nonatomic, strong) UIButton          *beginBtn;

@property (nonatomic, strong) NSArray  *images;
@end
@implementation NewFeatureView
- (instancetype)initWithFrame:(CGRect )frame images:(NSArray *)images{
    self = [super initWithFrame:frame];
    if (self) {
        _images = images;
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame images:nil];
}

- (instancetype)init{
    
    return [self initWithFrame:CGRectZero];
}

- (void)setupSubviews{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    self.scrollView.contentSize = CGSizeMake(self.images.count*SCREEN_WIDTH, SCREEN_HEIGHT);
//    for (NSInteger index = 0; index < self.images.count; index++) {
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(index * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        imageView.userInteractionEnabled = YES;
//        NSString *imageName = [NSString stringWithFormat:@"bg_welcome0%ld",(long)index+1];
//        imageView.image = [UIImage imageNamed:imageName];
//        if (index == 3) {
//            [imageView addSubview:self.beginBtn];
//        }
//        [self.scrollView addSubview:imageView];
//        
//    }
    
    [self.images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(idx * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imageView.userInteractionEnabled = YES;
        NSString *imageName = obj;
        imageView.image = [UIImage imageNamed:imageName];
        if (idx == self.images.count - 1) {
            [imageView addSubview:self.beginBtn];
        }
        [self.scrollView addSubview:imageView];
    }];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, SCREEN_HEIGHT *0.85, 100, 20)];
        _pageControl.numberOfPages = self.images.count;
        _pageControl.currentPageIndicatorTintColor = THEMECOLOR;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    }
    return _pageControl;
}

- (UIButton *)beginBtn{

    if (!_beginBtn) {
        _beginBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 80)/2, SCREEN_HEIGHT *0.85, 80, 40)];
        [_beginBtn setTitle:@"开始体验" forState:UIControlStateNormal];
        _beginBtn.layer.cornerRadius = 3;
        [_beginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _beginBtn.backgroundColor = THEMECOLOR;
        [_beginBtn addTarget:self action:@selector(didClickedBeginBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _beginBtn;
}

#pragma mark -- scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offSet = scrollView.contentOffset;
    NSInteger index = round(offSet.x/SCREEN_WIDTH);
    if (index>2) {
        self.pageControl.hidden = YES;
    }else{
        self.pageControl.hidden = NO;
    }
    self.pageControl.currentPage = index;
}

- (void)didClickedBeginBtn:(UIButton *)btn{
    if (self.beginBlock) {
        self.beginBlock();
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
