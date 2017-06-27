//
//  JZGAreaModel.h
//  JingZhenGu
//
//  Created by Mars on 15/12/23.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZGAreaModel : NSObject

/**省份id*/
@property (copy, nonatomic) NSString *provinceId;
/**省份名称*/
@property (copy, nonatomic) NSString *provinceName;
/**城市id*/
@property (copy, nonatomic) NSString *cityId;
/**城市名称*/
@property (copy, nonatomic) NSString *cityName;
/**城市全称*/
@property (copy, nonatomic) NSString *areaName;
/**全部*/
@property (copy, nonatomic) NSString *allName;
/** 城市或者省份*/
@property (copy,nonatomic) NSString *cityOrProvince;

@end
