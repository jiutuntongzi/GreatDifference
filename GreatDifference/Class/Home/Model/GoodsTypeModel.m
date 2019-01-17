//
//  GoodsTypeModel.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/9.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "GoodsTypeModel.h"
#import "MJExtension.h"
@implementation GoodsTypeModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"products": @"GoodsModel"};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"descrip": @"description"};
}
@end
