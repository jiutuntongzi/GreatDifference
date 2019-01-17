
//
//  StoreCartViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/10.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "StoreCartViewController.h"
#import "ShoppingCartCell.h"
#import "ShopingCartHeaderView.h"
#import "ShoppingCartResult.h"
#import "MJExtension.h"
#import "ShoppingHttpManager.h"
#import "StoreModelListResult.h"
#import "BigOrderDetailResult.h"
#import "ConfirmOrderViewController.h"
#import "GoodsDetailViewController.h"
#import "StringUtils.h"

@interface StoreCartViewController ()<UITableViewDataSource, UITableViewDelegate, BottomViewDelegate, DeleteViewDelegate>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataSource;
@property (nonatomic, strong) NSMutableArray    *selectArray;
@property (nonatomic, strong) NSMutableArray    *selectStores;

@property (nonatomic, strong) NSMutableArray    *selectIndexs;
@end

@implementation StoreCartViewController
static NSString *cellIdentifier = @"reuseCell";
static NSString *headerIdentifier = @"reuseHeader";

#pragma mark -- initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XGCOLOR(239, 239, 239);
    [self.view addSubview:self.tableView];

//    self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editAction)];

    [self.tableView registerClass:[ShoppingCartCell class] forCellReuseIdentifier:cellIdentifier];
    [self.tableView registerClass:[ShopingCartHeaderView class] forHeaderFooterViewReuseIdentifier:headerIdentifier];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@8);
        CGFloat bottomeOffset = -49-45;
        if (self.fromGoodsDetail) {
             bottomeOffset = -49;
        }
        make.bottom.equalTo(self.view.mas_bottom).offset(bottomeOffset);

    }];

    self.dataSource = [NSMutableArray array];
    
    BottomView *bottomView = [[BottomView alloc]init];
    bottomView.delegate     = self;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        CGFloat bottom = -49;
        if (self.fromGoodsDetail) {
            bottom = -0;
        }
        make.bottom.equalTo(self.view.mas_bottom).offset(bottom);
        make.height.equalTo(@45);
    }];
    self.bottomeView = bottomView;
    
//    DeleteView *deleteView = [[DeleteView alloc]init];
//    [self.view addSubview:deleteView];
//    [deleteView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
//        make.height.equalTo(@45);
//    }];
//    self.deleteView = deleteView;
//    self.deleteView.delegate = self;
//    self.deleteView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchData];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeAllSelect];
    [self cancelAllSelect];
    [self updateTotalPrice];
}

#pragma mark -- getter 方法
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

// 选中的商品
- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

// 选中的商店
- (NSMutableArray *)selectStores{
    if (!_selectStores) {
        _selectStores = [NSMutableArray array];
    }
    return _selectStores;
}


// 选中的商店
- (NSMutableArray *)selectIndexs{
    if (!_selectIndexs) {
        _selectIndexs = [NSMutableArray array];
    }
    return _selectIndexs;
}

#pragma mark -- configureData
- (void)fetchData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"1" forKey:@"type"];
    [ShoppingHttpManager getShopCartListWithParams:param success:^(StoreModelListResult *responseObj) {
        self.dataSource = [responseObj.data mutableCopy];
        
        // 创建对应的空数组对象
        for (NSInteger index = 0; index < self.dataSource.count; index++) {
            NSMutableArray *tempArray = [NSMutableArray array];
            [self.selectArray addObject:tempArray];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        
    }];
    
}

#pragma mark -- tableViewDataSource && delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    StoreModel *model = [self.dataSource objectAtIndex:section];
    
    return model.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreModel *storeModel = [self.dataSource objectAtIndex:indexPath.section];
    GoodsModel *goodsModel = [storeModel.products objectAtIndex:indexPath.row];
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (storeModel.isSelect) {
        goodsModel.isSelect = YES;
    }
    cell.goodsModel = goodsModel;
    
    __weak typeof(ShoppingCartCell *)weakCell = cell;
    cell.didClickedGoodsBlock = ^(GoodsModel *model){
        NSMutableArray *tempArray = self.selectArray[indexPath.section];
        if (model.isSelect) {
            [tempArray addObject: model];
            [self.selectIndexs addObject:model];
        }else{
            [tempArray removeObject:model];
            [self.selectIndexs removeObject:model];
        }
        
        weakCell.goodsModel = model;

        if (tempArray.count == storeModel.products.count) {
            storeModel.isSelect = YES;
            ShopingCartHeaderView *sectionView = (ShopingCartHeaderView *)[tableView headerViewForSection:indexPath.section];
            sectionView.storeModel = storeModel;
            [self.selectStores addObject:storeModel];
            if (self.selectStores.count == self.dataSource.count) {
                [self allSelect];
            }
        }else{
            storeModel.isSelect = NO;
            ShopingCartHeaderView *sectionView = (ShopingCartHeaderView *)[tableView headerViewForSection:indexPath.section];
            sectionView.storeModel = storeModel;
            
            [self.selectStores removeObject:storeModel];
            [self cancelAllSelect];
        }
        [self updateTotalPrice];
    };
    
    WS(self);
    cell.quantityChangeBlock = ^(){
        [weakself updateTotalPrice];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    StoreModel *storeModel = [self.dataSource objectAtIndex:section];

    ShopingCartHeaderView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    sectionView.sectionBlock = ^(BOOL isSelect){
        [storeModel.products enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            GoodsModel *goodsModel = (GoodsModel *)obj;
            goodsModel.isSelect = isSelect;

        }];
        storeModel.isSelect = isSelect;
        if (!isSelect) {
            NSMutableArray *tempArray = self.selectArray[section];
            [tempArray removeAllObjects];
            [self.selectStores removeObject:storeModel];
            [self cancelAllSelect];
        }else{
            [self.selectStores addObject:storeModel];
            NSMutableArray *tempArray = self.selectArray[section];
            StoreModel *store = [self.dataSource objectAtIndex:section];
            [tempArray removeAllObjects];
            [tempArray addObjectsFromArray:store.products];
            if (self.selectStores.count == self.dataSource.count) {
                [self allSelect];
            }
        }
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self updateTotalPrice];
    };
    sectionView.storeModel = storeModel;
    return sectionView;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        StoreModel *store = self.dataSource[indexPath.section];
        GoodsModel *goods = store.products[indexPath.row];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:goods.cartProductId forKey:@"cartProductIds"];
        
        [ShoppingHttpManager deleteShopCartGoodsWithParams:param success:^(CommonModelResult *responseObj) {
            [store.products removeObject:goods];
            NSMutableArray *tempArray = self.selectArray[indexPath.section];
            if ([tempArray containsObject:goods]) {
                [tempArray removeObject:goods];
                [self updateTotalPrice];
                
            }
            
            if (store.products.count>0) {

                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
  
            }else{
//                [self.tableView beginUpdates];
                [self.dataSource removeObject:store];
                NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:indexPath.section];
                if ([self.selectArray containsObject:goods]) {
                    [self.selectArray removeObject:store];
                    [self updateTotalPrice];
                }
                
                if (self.dataSource.count == 0) {
                    [self cancelAllSelect];
                }
                [self.tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//                [self.tableView endUpdates];
            }
//            [self.tableView reloadData];
            [self updateTotalPrice];

        } failure:^(id responseObj, NSError *error) {
            
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreModel *storeModel = [self.dataSource objectAtIndex:indexPath.section];
    GoodsModel *goodsModel = [storeModel.products objectAtIndex:indexPath.row];
    if ([goodsModel.existsChange isEqualToString:@"1"]) {
        return;
    }
    
    GoodsDetailViewController *goodsDetailVc = [[GoodsDetailViewController alloc]init];
//    GoodsModel *model = responseObj.data;
    goodsDetailVc.productId = goodsModel.productId;
    [self.navigationController pushViewController:goodsDetailVc animated:YES];
}

- (void)removeAllSelect{
    [self.selectStores removeAllObjects];
    for (NSInteger index = 0; index < self.dataSource.count; index++) {
        NSMutableArray *tempArray = self.selectArray[index];
        [tempArray removeAllObjects];
    }
    XGLog(@"hello");
//    [self.selectArray removeAllObjects];
}

#pragma mark -- bottomViewDelegate
- (void)bottomView:(BottomView *)bottom didSelectAllButton:(BOOL)isSelect{
        if (isSelect) {
            NSMutableArray *dataArray = self.dataSource;
            [self.selectStores removeAllObjects];
            
            for (NSInteger index = 0; index<dataArray.count; index++) {
                NSMutableArray *tempArray = [self.selectArray objectAtIndex:index];
                StoreModel *storeModel = dataArray[index];
                storeModel.isSelect = YES;
                [self.selectStores addObject:storeModel];
                [tempArray removeAllObjects];
                
                [tempArray addObjectsFromArray:storeModel.products];
            }
            XGLog(@"yoyyo");
            
            
        }else{
            NSMutableArray *tempArray = self.dataSource;
            for (StoreModel *storeModel in tempArray) {
                storeModel.isSelect = NO;
                for (GoodsModel *goods in storeModel.products) {
                    goods.isSelect = NO;
                }
            }
            [self removeAllSelect];
            
        }
    [self.tableView reloadData];
    [self updateTotalPrice];
        
        // 海淘店
}


- (void)bottomView:(BottomView *)bottom didSelectCashButton:(UIButton *)btn{
    

    NSMutableDictionary *products = [NSMutableDictionary dictionary];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSArray  *stores in self.selectArray) {
        [stores enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            GoodsModel *model = (GoodsModel *)obj;
            if ([model.existsChange isEqualToString:@"1"]) {
                return ;
            }
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:model.productId forKey:@"productId"];
            [dict setValue:model.num forKey:@"num"];
            [tempArray addObject:dict];
        }];
    }
    
    if (tempArray.count == 0) {
        [HUDUtils showAlert:@"请选择要购买的商品"];
        return;
    }
    [products setValue:tempArray forKey:@"products"];
    [products setValue:@"1" forKey:@"type"];

    [ShoppingHttpManager shoppingCartPurchaseGoodsWithParams:products success:^(BigOrderDetailResult *responseObj) {
        OrderListModel *bigOrder = responseObj.data;
        ConfirmOrderViewController *confirmOrderVc = [[ConfirmOrderViewController alloc]init];
        confirmOrderVc.bigOrder = bigOrder;
        
        [self.navigationController pushViewController:confirmOrderVc animated:YES];
        
    } failure:^(id responseObj, NSError *error) {
        NSString *resultMessage = [responseObj objectForKey:@"message"];
        XGLog(@"错误信息:%@", resultMessage);
        [HUDUtils showAlert:resultMessage];
    }];
}

- (void)bottomView:(BottomView *)bottom didSelectDeleteButton:(UIButton *)btn{
    NSMutableString *products = [[NSMutableString alloc]init];
    for (NSArray  *stores in self.selectArray) {
        [stores enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            GoodsModel *model = (GoodsModel *)obj;
            if (idx == 0) {
                [products appendString:model.cartProductId];
            }else{
                [products appendFormat:@",%@", model.cartProductId];
            }
        }];
    }
    XGLog(@"procucts %@", products);

    if ([StringUtils isEmpty:products]) {
        [HUDUtils showAlert:@"请选择要删除的商品"];
        return;
    }
//    [self.dataSource removeObjectsAtIndexes:self.selectIndexs];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:products forKey:@"cartProductIds"];
    
    [ShoppingHttpManager deleteShopCartGoodsWithParams:param success:^(CommonModelResult *responseObj) {
        
        [self fetchData];
        [self removeAllSelect];
        [self cancelAllSelect];
        [self updateTotalPrice];
        
    } failure:^(id responseObj, NSError *error) {
        
    }];
}
#pragma mark -- deleteViewDelegate
- (void)deleteView:(DeleteView *)bottom didSelectDeleteButton:(UIButton *)btn{
    
}

- (void)deleteView:(DeleteView *)bottom didSelectAllButton:(BOOL) isSelect{
    [self bottomView:nil didSelectAllButton:isSelect];
}

#pragma mark -- clickedAction
- (void)cancelAllSelect{
    [self.bottomeView setSelectAllStatus:UIButtonStatusNormal];
}

- (void)allSelect{
    [self.bottomeView setSelectAllStatus:UIButtonStatusSelect];
}

- (void)updateTotalPrice{
    float total = 0;
    NSInteger numbers = 0;
    for (NSArray  *stores in self.selectArray) {
        for (GoodsModel *goods in stores) {
            
            if ([goods.existsChange isEqualToString:@"1"]) {
                continue;
            }

            total+=[goods.productPrice floatValue]*[goods.num integerValue];
            XGLog(@"数量: %@", goods.num);
            numbers+=[goods.num integerValue];
        }
    }
    [self.bottomeView setTotalPrice:total totalQuantity:numbers];
    XGLog(@"总金额为: %lf", total);
}

- (void)deleteProductsWithParams:(NSDictionary *)params{

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
