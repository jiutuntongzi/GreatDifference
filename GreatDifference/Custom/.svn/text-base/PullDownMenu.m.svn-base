//
//  PopView.m
//  SweePea
//
//  Created by xiaodou_yxg on 16/6/29.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "PullDownMenu.h"
#import "StoreModel.h"

#define kCellHeight         40          //单个cell高度
#define kMaxCellOfNumber    8           //cell最多显示的个数
#define kTitleButtonTag     1000        
#define kTopBarHeight       40
#define kMaskViewBackColor  [UIColor colorWithRed:40/255 green:40/255 blue:40/255 alpha:.2]

@interface PullDownMenu ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray        *titleArray;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, strong) UIView         *maskView;
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) UITableView    *tableView1;
@property (nonatomic, strong) UIButton       *tempButton;

@property (nonatomic, assign) CGFloat        selfOriginalHeight;
@property (nonatomic, assign) CGFloat        tableViewMaxHeight;
@property (nonatomic, assign) NSInteger      selectedIndex;
@property (nonatomic, copy) NSString         *title1;

@property (nonatomic, strong) UIImageView    *arrowImageView;
@property (nonatomic, assign) CGFloat        titleBtnWidth;

@end
@implementation PullDownMenu

#pragma mark -- initialization
- (instancetype)initWithFrame:(CGRect)frame menuTitleArray:(NSArray *)titleArray
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleArray = titleArray;
        _tableViewMaxHeight = kCellHeight * kMaxCellOfNumber;
        _selfOriginalHeight = self.frame.size.height;
        _selectedIndex = 0;
        self.titleBtnWidth = SCREEN_WIDTH /self.titleArray.count;

        [self setupSubviews];
        
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero menuTitleArray:nil];
}

#pragma mark -- getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.frame.size.height + 1, SCREEN_WIDTH, 0)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        _tableView.rowHeight= kCellHeight;
        _tableView.layer.borderColor = [UIColor redColor].CGColor;
        _tableView.layer.borderWidth = 0;
    }
    return _tableView;
}

- (UITableView *)tableView1
{
    if (!_tableView1) {
        _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, self.frame.size.height + 1, SCREEN_WIDTH/2, 0)];
        _tableView1.delegate=self;
        _tableView1.dataSource=self;
        _tableView1.backgroundColor=[UIColor groupTableViewBackgroundColor];
        _tableView1.rowHeight= kCellHeight;
        _tableView.layer.borderColor = [UIColor redColor].CGColor;
        _tableView.layer.borderWidth = 0;
    }
    return _tableView1;
}

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView =[[UIView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width, SCREEN_HEIGHT - self.frame.origin.y)];
        _maskView.backgroundColor=kMaskViewBackColor;
        _maskView.hidden=YES;
        _maskView.userInteractionEnabled=YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickedMaskView:)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.image = [UIImage imageNamed:@"pullDownArrow"];
    }
    return _arrowImageView;
}

-(NSMutableArray *)buttonArray
{
    if (_buttonArray) {
        return _buttonArray;
    }
    self.buttonArray =[[NSMutableArray alloc]init];
    
    return self.buttonArray;
}

#pragma mark -- setupSubviews
- (void)setupSubviews
{
    [self addSubview:self.maskView];
    [self configTopBar];
    [self addSubview:self.tableView];
//    [self addSubview:self.tableView1];
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    StoreModel *storeModel = [dataSource firstObject];
    storeModel.isSelect = YES;
    
    [self.tableView reloadData];
    self.title1 = @"全部店铺";
}

- (void)configTopBar
{
    CGFloat width = SCREEN_WIDTH /self.titleArray.count;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kTopBarHeight)];
    view.backgroundColor=[UIColor whiteColor];
    
    [self addSubview:view];
    for (int index=0; index<self.titleArray.count; index++) {
        
        UIButton *titleButton=[UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = self.titleArray[index];

        titleButton.frame= CGRectMake((width+0.5) * index, 0, width-0.5, kTopBarHeight-1);
//        titleButton.backgroundColor =[UIColor magentaColor];
        [titleButton setTitle:self.titleArray[index] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        titleButton.tag =kTitleButtonTag + index ;
        [titleButton addTarget:self action:@selector(didClickedTitleButton:) forControlEvents:UIControlEventTouchUpInside];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        [titleButton setImage:[UIImage imageNamed:@"pullDownArrow"] forState:UIControlStateNormal];
//        [titleButton setAdjustsImageWhenHighlighted:NO];
        [self addSubview:titleButton];

        CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName: XGFONT(15)}];
        
        if (index == 0) {
            //            titleButton.backgroundColor = [UIColor redColor];
            self.tempButton = titleButton;
            [titleButton addSubview:self.arrowImageView];
            self.arrowImageView.frame = CGRectMake(width/2+titleSize.width/2 + 5 , 10, 15, 15);
        }
//        titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 130, 0, 0);
//        titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
        [self.buttonArray addObject:titleButton];
        
    }
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kTopBarHeight, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = XGCOLOR(228, 228, 228);
    [view addSubview:lineView];

}

#pragma mark -- tableViewDataSource & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return self.dataSource.count;
    }
    if (self.dataSource.count<1) {
        return 0;
    }
//    GradeModel *grade = self.dataSource[self.selectedIndex];
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        StoreModel *storeType = self.dataSource[indexPath.row];

        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
//        cell.backgroundColor = XGCOLOR(228, 228, 228);
        if (storeType.isSelect) {
            cell.textLabel.textColor = THEMECOLOR;
        }else
        {
            cell.textLabel.textColor = [UIColor blackColor];
        }
//        cell.contentView.backgroundColor =  XDColor(228, 228, 228);
        cell.textLabel.text = storeType.name;
        return cell;
        
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.tableView == tableView) {
        
        self.selectedIndex = indexPath.row;
        self.title1 = cell.textLabel.text;
        
        for (NSInteger index = 0; index < self.dataSource.count; index++) {
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
            cell.textLabel.textColor = [UIColor blackColor];
            StoreModel *tempGrade = self.dataSource[index];
            tempGrade.isSelect = NO;
        }
        
        StoreModel *store = self.dataSource[indexPath.row];
        store.isSelect = YES;
        [self shrinkTableView];
        NSString *title = cell.textLabel.text;
        CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName: XGFONT(15)}];
        self.arrowImageView.frame = CGRectMake(self.titleBtnWidth/2+titleSize.width/2 + 5 , 10, 15, 15);
        title = [NSString stringWithFormat:@"%@",self.title1];

        [self.tempButton setTitle:title forState:UIControlStateNormal];
        if (self.callBack) {
            self.callBack(store.sellerTypeId);
        }

//        [self.tableView1 reloadData];
    }
    cell.textLabel.textColor = THEMECOLOR;

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor blackColor];
    
        StoreModel *grade = self.dataSource[indexPath.row];
        grade.isSelect = NO;

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView == tableView) {
//        UIView *view = [[UIView alloc]init];
//        view.backgroundColor = [UIColor whiteColor];
//        cell.selectedBackgroundView = view;
//        GradeModel *grade = self.dataSource[indexPath.row];
//        if (grade.isSelected) {
//            cell.textLabel.textColor = ThemeBarColor;
//        }
    }
}

#pragma mark -- clickedEvent;
//- (void)changeButtonState:(UIButton *)button TransformAngle:(CGFloat)angle
//{
//    [UIView animateWithDuration:0.5 animations:^{
//        button.imageView.transform = CGAffineTransformMakeRotation(angle);
//    }];
//}

- (void)changeButtonState:(UIButton *)button TransformAngle:(CGFloat)angle
{
    [UIView animateWithDuration:0.5 animations:^{
        self.arrowImageView.transform = CGAffineTransformMakeRotation(angle);
        //        button.imageView.transform = CGAffineTransformMakeRotation(angle);
    }];
}


/**
 *  点击了顶部
 *
 *  @param titleButton 顶部按钮
 */
- (void)didClickedTitleButton:(UIButton *)titleButton
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    for (UIButton *button in self.buttonArray) {
        if (button == titleButton) {
            button.selected = !button.selected;
            self.tempButton = titleButton;
            [self changeButtonState:button TransformAngle:M_PI];
        }else
        {
            button.selected = NO;
            [self changeButtonState:button TransformAngle:0];
        }
    }
    
    if (titleButton.selected) {
        [self changeButtonState:titleButton TransformAngle:M_PI];
        // 默认选中第一项
//        [self.tableView reloadData];
        CGFloat tableViewHeight =  self.dataSource.count * kCellHeight < self.tableViewMaxHeight ?
        self.dataSource.count * kCellHeight : self.tableViewMaxHeight;

        [self expandWithTableViewHeight:tableViewHeight];
    }else
    {
        [self shrinkTableView];
    }
}

/**
 *  展开tableView
 *
 *  @param tableViewHeight tableView的高度
 */
- (void)expandWithTableViewHeight:(CGFloat)tableViewHeight
{
    self.maskView.hidden = NO;
    CGRect rect = self.frame;
    rect.size.height = SCREEN_HEIGHT - self.frame.origin.y;
    self.frame = rect;
    
    [self showSpringAnimationWithDuration:0.3 animations:^{
        
        self.tableView.frame = CGRectMake(0, self.selfOriginalHeight + 1, SCREEN_WIDTH, tableViewHeight);
//        self.tableView1.frame = CGRectMake(SCREEN_WIDTH/2 - 1, self.selfOriginalHeight +1, SCREEN_WIDTH/2, tableViewHeight);
        self.maskView.alpha = 1;
    } completion:^{
        
    }];
}

/**
 *  收缩tableView
 */
- (void)shrinkTableView
{
    for (UIButton *button in self.buttonArray) {
        button.selected = NO;
        [self changeButtonState:button TransformAngle:0];
    }
    
    CGRect rect = self.frame;
    rect.size.height = self.selfOriginalHeight;
    self.frame = rect;
//    [self.tableView1 reloadData];

    [self showSpringAnimationWithDuration:1.3 animations:^{
        

        self.tableView.frame = CGRectMake(0, self.selfOriginalHeight, SCREEN_WIDTH,0);

        self.maskView.alpha =0;
        self.maskView.hidden=YES;

    } completion:^{

    }];

}

//展开收缩动画
-(void)showSpringAnimationWithDuration:(CGFloat)duration
                            animations:(void (^)())animations
                            completion:(void (^)())completion
{
    
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        if (animations) {
            animations();
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)didClickedMaskView:(UITapGestureRecognizer *)tap
{
    [self shrinkTableView];
//    self.tableView1
}


- (void)dealloc
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end

@interface PullDownMenuCell : UITableViewCell
//@property (nonatomic, assign) BOOL cell;

@end

@implementation PullDownMenuCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
@end
