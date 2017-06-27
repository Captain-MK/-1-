//
//  JZGCarRegDateMethod.h
//  JingZhenGu
//
//  Created by Gaowl on 15/6/25.
//  Copyright (c) 2015年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZGBaseService.H"
typedef void(^checkResult)(NSDictionary *resultDict);
typedef void(^ReturnErrorString)(NSString *errorString);

@interface JZGCarRegDateMethod : JZGBaseService

/**
 *  根据车型Id返回可选的上牌日期范围
 *
 *  @param carId        车型Id
 *  @param responseData 可选的上牌日期范围
 */
+ (void)carRegDateRangeByCarId:(NSString *)carId responseData:(checkResult)responseData errcode:(ReturnErrorString)errorStr;

+ (void)loadDataWithRegYear:(NSString *)minYear nextYear:(NSString *)maxYear block:(checkResult)responseData;

@end
