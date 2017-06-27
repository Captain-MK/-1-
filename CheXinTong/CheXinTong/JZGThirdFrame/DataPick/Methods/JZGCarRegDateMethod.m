//
//  JZGCarRegDateMethod.m
//  JingZhenGu
//
//  Created by Gaowl on 15/6/25.
//  Copyright (c) 2015年 Mars. All rights reserved.
//

#import "JZGCarRegDateMethod.h"


@implementation JZGCarRegDateMethod

+ (void)carRegDateRangeByCarId:(NSString *)carId responseData:(checkResult)responseData errcode:(ReturnErrorString)errorStr
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"op"] = @"GetLowMixYear";
    param[@"styleid"] = carId;
    __weak typeof (self)weakSelf = self;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",@"http://ptvapi.guchewang.com",@"/APP/GetMakeAndModelAndStyle.ashx"];
    [[JZGNetWorkRequest sharedNetworkRequest] connectNetWithUrl:urlStr
                                             requestNetworkType:JZGNetworkRequestPost
                                                     parameters:param
                                                timeoutInterval:20
                                                   successBlock:^(id returnData, NSInteger code, NSString *msg)
     {
//         [weakSelf handleRequestSuccess:returnData sucBlock:sucBlock failBlock:failBlock];
         NSString *minYear = returnData[@"MinYEAR"];
         NSString *maxYear = returnData[@"MaxYEAR"];
         
         NSDictionary *dict = [[[weakSelf alloc] init] getRegYear:minYear andNextYear:maxYear];
         if (responseData) {
             responseData(dict);
         }
     }
                                                   failureBlock:^(NSError *error)
     {
         errorStr(@"");
        // [weakSelf handleRequestFailed:error failBlock:failBlock];
     }];
    
    
    
//    [JZGNetworkManager postReqeustWithURL:GET_CARINFO_URL parameters:param successBlock:^(id returnData, NSInteger code, NSString *msg) {
//        NSString *minYear = returnData[@"MinYEAR"];
//        NSString *maxYear = returnData[@"MaxYEAR"];
//        
//        NSDictionary *dict = [[[weakSelf alloc] init] getRegYear:minYear andNextYear:maxYear];
//        if (responseData) {
//            responseData(dict);
//        }
//        
//    } failureBlock:^(NSError *error) {
//        errorStr(@"");
//    } showHUD:YES showInView:WINDOW];
}

+ (void)loadDataWithRegYear:(NSString *)minYear nextYear:(NSString *)maxYear block:(checkResult)responseData
{
    NSDictionary *dict = [[[self alloc] init] getRegYear:minYear andNextYear:maxYear];
    
    if (responseData) {
        responseData(dict);
    }
}

- (NSDictionary *)getRegYear:(NSString *)minYear andNextYear:(NSString *)maxYear
{
    // 可选年
    NSMutableArray *years = [NSMutableArray array];
    
    
    for (NSInteger i = [self yearIntegerValue:maxYear]; i >= [self yearIntegerValue:minYear]; i--)
    {
        [years addObject:[NSString stringWithFormat:@"%zd年",i]];
    }
    
    // 可选月
    NSMutableArray *months = [NSMutableArray array];
    for (NSInteger i = 0; i < 12; i++)
    {
        [months addObject:[NSString stringWithFormat:@"%zd月",i+1]];
    }
    
    // 最小可选年的可选月
    NSMutableArray *monthsForMinYear = [NSMutableArray array];
    for (NSInteger i = [self monthIntegerValue:minYear]; i <= 12; i++)
    {
        [monthsForMinYear addObject:[NSString stringWithFormat:@"%zd月",i]];
    }
    
    // 最大可选年的可选月
    NSMutableArray *monthsForMaxYear = [NSMutableArray array];
    for (NSInteger i = 0; i < [self monthIntegerValue:maxYear]; i++)
    {
        [monthsForMaxYear addObject:[NSString stringWithFormat:@"%zd月",i+1]];
    }
    NSDictionary *dict = @{@"years":years,
                           @"months":months,
                           @"monthsForMinYear":monthsForMinYear,
                           @"monthsForMaxYear":monthsForMaxYear};
    
    return dict;
}

- (NSInteger)yearIntegerValue:(NSString *)year
{
    return [[[year componentsSeparatedByString:@"-"]firstObject] integerValue];
}

- (NSInteger)monthIntegerValue:(NSString *)year
{
    return [[[year componentsSeparatedByString:@"-"]lastObject] integerValue];
}

@end
