//
//  JZGBrandModel.h
//  JZGDetectionPlatform
//
//  Created by Mars on 15/12/29.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZGBrandModel : NSObject

/**组名*/
@property (copy, nonatomic) NSString *groupName;
/**是否热门*/
@property (copy, nonatomic) NSString *isHot;
/**品牌id*/
@property (copy, nonatomic) NSString *brandId;
/**品牌logo*/
@property (copy, nonatomic) NSString *brandLogo;
/**品牌名称*/
@property (copy, nonatomic) NSString *brandName;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)carBrandModelWithDict:(NSDictionary *)dict;


@end
