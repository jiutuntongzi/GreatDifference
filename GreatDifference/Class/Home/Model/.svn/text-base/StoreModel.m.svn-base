//
//  StoreModel.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/9.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "StoreModel.h"
#import "MJExtension.h"
@implementation StoreModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"goods": @"GoodsModel", @"productTypeList": @"GoodsTypeModel", @"products": @"GoodsModel",};
}

- (id)initWithTitle:(NSString *)title imageNamed:(NSString *)imageName{
    self = [super init];
    if (self) {
        self.shopName   = title;
        self.shopIcon  = imageName;
    }
    return self;
}

- (instancetype)init{
    return [self initWithTitle:nil imageNamed:nil];
}

@end
