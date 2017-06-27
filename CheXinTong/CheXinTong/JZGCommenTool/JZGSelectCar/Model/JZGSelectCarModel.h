//
//  JZGSelectCarModel.h
//  JingZhenGu
//
//  Created by Mars on 15/12/28.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZGSelectCarModel : NSObject


/**组名*/
@property (copy, nonatomic) NSString *brandGroup;
/**是否热门*/
@property (copy, nonatomic) NSString *brandHot;
/**品牌id*/
@property (copy, nonatomic) NSString *brandId;
/**品牌icon*/
@property (copy, nonatomic) NSString *brandIcon;
/**品牌名称*/
@property (copy, nonatomic) NSString *brandName;
/**车系id*/
@property (copy, nonatomic) NSString *styleId;
/**车系icon*/
@property (copy, nonatomic) NSString *styleIcon;
/**车系名称*/
@property (copy, nonatomic) NSString *styleName;
/**车型id*/
@property (copy, nonatomic) NSString *modelId;
/**车型名称*/
@property (copy, nonatomic) NSString *modelName;
/**上市时间*/
@property (copy, nonatomic) NSString *modelYear;
@property (copy, nonatomic) NSString *MaxYEAR;
@property (copy, nonatomic) NSString *MinYEAR;
/**厂家指导价*/
@property (copy, nonatomic) NSString *modelMsrp;
/**全称*/
@property (copy, nonatomic) NSString *modelFullName;
/**是否选择*/
@property (assign, nonatomic) BOOL isSelected;
/**座位数*/
@property (nonatomic,copy) NSString *seatNum;
/**排量*/
@property (nonatomic,copy)   NSString *displacement;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)carBrandModelWithDict:(NSDictionary *)dict;

+ (instancetype)carStyleModelWithDict:(NSDictionary *)dict;

+ (instancetype)carModelWithDict:(NSDictionary *)dict;

@end
