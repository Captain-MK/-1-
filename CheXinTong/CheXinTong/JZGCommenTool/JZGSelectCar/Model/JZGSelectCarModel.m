//
//  JZGSelectCarModel.m
//  JingZhenGu
//
//  Created by Mars on 15/12/28.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGSelectCarModel.h"

@implementation JZGSelectCarModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _brandGroup = dict[@"GroupName"];
//        _brandHot = dict[@"IsHot"];
        _brandId = [NSString stringWithFormat:@"%@",dict[@"MakeId"]];
        _brandIcon = dict[@"MakeLogo"];
        _brandName = dict[@"MakeName"];
        _isSelected = NO;
    }
    
    return self;
}

- (instancetype)initWithStyleDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _styleId = dict[@"Id"];
        _styleName = dict[@"Name"];
        _styleIcon = dict[@"modelimgpath"];
        _isSelected = NO;
    }
    
    return self;
}

- (instancetype)initWithCarModelDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _modelId = dict[@"Id"];
        _modelName = dict[@"Name"];
        _modelYear = dict[@"Year"];
        _MaxYEAR = dict[@"MaxYEAR"];
        _MinYEAR = dict[@"MinYEAR"];

        _modelMsrp = [NSString stringWithFormat:@"%.2f",[dict[@"NowMsrp"] floatValue]];
        _modelFullName = dict[@"FullName"];
        if ([dict objectForKey:@"Seat"]) {
            _seatNum = [NSString stringWithFormat:@"%@",dict[@"Seat"]] ;
        }else
        {
            _seatNum = @"";
        }
        
        if ([dict objectForKey:@"DisPlaceMent"]) {
            _displacement= [NSString stringWithFormat:@"%@",dict[@"DisPlaceMent"]] ;
        }else
        {
            _displacement = @"";
        }
        
    }
    
    return self;
}

+ (instancetype)carBrandModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+ (instancetype)carStyleModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithStyleDict:dict];
}

+ (instancetype)carModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithCarModelDict:dict];
}


@end
