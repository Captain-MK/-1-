//
//  PLBaseDataModel.h
//  PLTP_M_CARRIERS
//
//  Created by Lucas on 14-8-27.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYModel.h"

@interface JZGBaseDataModel : NSObject<NSCopying,NSCoding>

- (instancetype)initWithDictionary:(NSDictionary *)dic;

/**
 *  如果属性名与字典中的key不一致时，子类需重写此方法，参照下面写法，userID是你本地定义参数名称，id是服务端返回名称
 */
//- (NSDictionary *)attributeMapDictionary
//{
//    NSDictionary *mapAtt = @{@"userID": @"id",};
//    return mapAtt;
//}
- (NSDictionary *)attributeMapDictionary;

/**
 *  根据字典更新模型的值
 */
- (void)setAttributes:(NSDictionary *)dataDic;

/**
 *  过滤字符串
 */
- (NSString *)filterWithString:(NSString *)str;

@end
