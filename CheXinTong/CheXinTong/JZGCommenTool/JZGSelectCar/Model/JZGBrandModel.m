//
//  JZGBrandModel.m
//  JZGDetectionPlatform
//
//  Created by Mars on 15/12/29.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGBrandModel.h"

@implementation JZGBrandModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _groupName = dict[@"GroupName"];
        _isHot = dict[@"IsHot"];
        _brandId = [NSString stringWithFormat:@"%@",dict[@"MakeId"]];
        _brandLogo = dict[@"MakeLogo"];
        _brandName = dict[@"MakeName"];
    }
    
    return self;
}

+ (instancetype)carBrandModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
