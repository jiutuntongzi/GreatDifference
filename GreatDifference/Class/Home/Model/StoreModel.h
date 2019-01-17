//
//  StoreModel.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/9.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsTypeModel.h"

@interface StoreModel : NSObject
@property (nonatomic, copy) NSString  *isCollection; // 此店铺是否被收藏过1收藏过

@property (nonatomic, copy) NSString  *shopName;
@property (nonatomic, copy) NSString  *shopAddress;
@property (nonatomic, copy) NSString  *distance;
@property (nonatomic, copy) NSString  *shopIcon;

@property (nonatomic, copy) NSString    *shopId;       // 店铺id
@property (nonatomic, copy) NSString    *qrCode;
//@property (nonatomic, copy) NSString    *qrCodeImgUrl;
@property (nonatomic, copy) NSString    *businessLicenseImgUrl;
@property (nonatomic, copy) NSString    *storeTypeId;
@property (nonatomic, copy) NSString    *shopHours; // 营业时间
@property (nonatomic, copy) NSString    *telphone;  // 联系方式





//@property (nonatomic, strong) NSArray  *goods;// 商店下面的商品
@property (nonatomic, strong) NSArray  *productTypeList;// 商店下面的商品

@property (nonatomic, assign) BOOL  isSelect; // 用于购物车是否选中
@property (nonatomic, copy) NSString  *totalPrice;
@property (nonatomic, strong) NSMutableArray  *products;

// 生活服务类型 过滤字段
@property (nonatomic, copy) NSString    *sellerTypeId;
@property (nonatomic, copy) NSString    *name;
@property (nonatomic, copy) NSString    *num;


- (id)initWithTitle:(NSString *)title imageNamed:(NSString *)imageName;
@end
