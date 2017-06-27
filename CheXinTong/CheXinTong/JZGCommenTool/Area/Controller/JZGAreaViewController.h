//
//  JZGAreaViewController.h
//  JingZhenGu
//
//  Created by Mars on 15/12/14.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGBaseViewController.h"
#import "JZGAreaModel.h"

typedef void(^ReturnBlock) (JZGAreaModel *areaModel);
typedef void(^getLocation)(NSString *stateName,NSString *cityName); //得到当地的位置信息

@interface JZGAreaViewController : JZGBaseViewController
/// 为yes时 含有不限省份
@property (nonatomic,assign) BOOL ifHaveAllPro;
/// 默认含有，传yes时，过滤全部城市的选项
@property (nonatomic,assign) BOOL ifDontHaveAllCity;

@property (strong, nonatomic) ReturnBlock returnCityBlock;

- (void)returnCityInfo:(ReturnBlock)block;

/// 为1时，只有省份（一级）
@property (nonatomic,assign) BOOL onlyProvince;

/// 是否含有定位
@property (nonatomic,assign) BOOL ifHavePosition;
@property (nonatomic,copy) NSString *positionStr;

@end
