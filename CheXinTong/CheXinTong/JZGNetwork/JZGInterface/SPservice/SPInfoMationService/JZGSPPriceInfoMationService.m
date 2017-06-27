//
//  JZGSPPriceInfoMationService.m
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/26.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGSPPriceInfoMationService.h"

@implementation JZGSPPriceInfoMationService

+ (instancetype)share{
    static dispatch_once_t t;
    static JZGSPPriceInfoMationService *service = nil;
    dispatch_once(&t, ^{
        service = [[JZGSPPriceInfoMationService alloc] init];
    });
    return service;
}

- (void)getCarPriceServicestyleId:(NSString *)styleid
                         cityName:(NSString *)cityName
                           cityId:(NSString *)cityId
                       provinceid:(NSString *)provinceid
                          mileage:(NSString *)mileage
                     registerDate:(NSString *)registerDate
                         sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                        failBlock:(JZGNetworkRequestFailureBlock)failBlock{

    NSString *userId = [JZGUserDataModel currentLoginUser].UserID;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"valuation" forKey:@"op"];
    [params setObject:userId forKey:@"userId"];
    [params setObject:cityId forKey:@"cityId"];
    [params setObject:styleid forKey:@"styleid"];
    [params setObject:mileage forKey:@"mileage"];
    [params setObject:provinceid forKey:@"provinceid"];
    [params setObject:registerDate forKey:@"registerDate"];
    [params setObject:cityName forKey:@"cityName"];
    NSString *urlString = [NSString stringWithFormat:@"%@/carinfo/CarValuation.ashx",SPHOME_URL];
    WS(weakSelf);
    [[JZGNetWorkRequest sharedNetworkRequest] connectNetWithUrl:urlString
                                             requestNetworkType:JZGNetworkRequestPost
                                                     parameters:params
                                                timeoutInterval:0
                                                   successBlock:^(id returnData, NSInteger code, NSString *msg){
                                                       [weakSelf handleRequestSuccess:returnData sucBlock:sucBlock failBlock:failBlock];
                                                   }
                                                   failureBlock:^(NSError *error){
                                                       [weakSelf handleRequestFailed:error failBlock:failBlock];
                                                   }];
    
}

/**
 *  取消修改用户头像
 */
- (void)cancelModifyIcon{

}


/**
 历史记录

 @param styleid <#styleid description#>
 @param cityId <#cityId description#>
 @param provinceid <#provinceid description#>
 @param mileage <#mileage description#>
 @param registerDate <#registerDate description#>
 @param sucBlock <#sucBlock description#>
 @param failBlock <#failBlock description#>
 */
- (void)getHistoryRecordtyleId:(NSString *)styleid
                        cityName:(NSString *)cityName
                        cityId:(NSString *)cityId
                    provinceid:(NSString *)provinceid
                       mileage:(NSString *)mileage
                  registerDate:(NSString *)registerDate
                      sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                     failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *userId = [JZGUserDataModel currentLoginUser].UserID;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"historytransaction" forKey:@"op"];
    [params setObject:userId forKey:@"userId"];
    [params setObject:cityId forKey:@"cityId"];
    [params setObject:styleid forKey:@"styleid"];
    [params setObject:mileage forKey:@"mileage"];
    [params setObject:cityName forKey:@"cityName"];
    [params setObject:provinceid forKey:@"provinceid"];
    [params setObject:registerDate forKey:@"registerDate"];
    NSString *urlString = [NSString stringWithFormat:@"%@/carinfo/carvaluation.ashx",SPHOME_URL];
    WS(weakSelf);
    [[JZGNetWorkRequest sharedNetworkRequest] connectNetWithUrl:urlString
                                             requestNetworkType:JZGNetworkRequestPost
                                                     parameters:params
                                                timeoutInterval:0
                                                   successBlock:^(id returnData, NSInteger code, NSString *msg){
                                                       [weakSelf handleRequestSuccess:returnData sucBlock:sucBlock failBlock:failBlock];
                                                   }
                                                   failureBlock:^(NSError *error){
                                                       [weakSelf handleRequestFailed:error failBlock:failBlock];
                                                   }];

}


/**
 网络在售

 @param styleid <#styleid description#>
 @param cityId <#cityId description#>
 @param sucBlock <#sucBlock description#>
 @param failBlock <#failBlock description#>
 */
- (void)getWangLuoRecordtyleId:(NSString *)styleid
                      cityName:(NSString *)cityName
                        cityId:(NSString *)cityId
                      sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                     failBlock:(JZGNetworkRequestFailureBlock)failBlock{

    NSString *userId = [JZGUserDataModel currentLoginUser].UserID;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"publishcarsource" forKey:@"op"];
    [params setObject:userId forKey:@"userId"];
    [params setObject:cityId forKey:@"cityId"];
    [params setObject:styleid forKey:@"styleid"];
    [params setObject:cityName forKey:@"cityName"];
    NSString *urlString = [NSString stringWithFormat:@"%@/carinfo/carvaluation.ashx",SPHOME_URL];
    WS(weakSelf);
    [[JZGNetWorkRequest sharedNetworkRequest] connectNetWithUrl:urlString
                                             requestNetworkType:JZGNetworkRequestPost
                                                     parameters:params
                                                timeoutInterval:0
                                                   successBlock:^(id returnData, NSInteger code, NSString *msg){
                                                       [weakSelf handleRequestSuccess:returnData sucBlock:sucBlock failBlock:failBlock];
                                                   }
                                                   failureBlock:^(NSError *error){
                                                       [weakSelf handleRequestFailed:error failBlock:failBlock];
                                                   }];
    
}

- (void)getTongCheXiXiaoShouJiLumodelId:(NSString *)modelId
                               cityName:(NSString *)cityName
                               sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                              failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    NSString *userId = [JZGUserDataModel currentLoginUser].UserID;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"orderListByModel" forKey:@"op"];
    [params setObject:userId forKey:@"userId"];
    [params setObject:modelId forKey:@"modelId"];
    [params setObject:cityName forKey:@"cityName"];
    NSString *urlString = [NSString stringWithFormat:@"%@/Assessment/HistoryQuery.ashx",SPHOME_URL];
    WS(weakSelf);
    [[JZGNetWorkRequest sharedNetworkRequest] connectNetWithUrl:urlString
                                             requestNetworkType:JZGNetworkRequestPost
                                                     parameters:params
                                                timeoutInterval:0
                                                   successBlock:^(id returnData, NSInteger code, NSString *msg){
                                                       [weakSelf handleRequestSuccess:returnData sucBlock:sucBlock failBlock:failBlock];
                                                   }
                                                   failureBlock:^(NSError *error){
                                                       [weakSelf handleRequestFailed:error failBlock:failBlock];
                                                   }];

}


- (void)getGaiChePingGuJiLucarId:(NSString *)carId
                        cityName:(NSString *)cityName
                        sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                       failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    NSString *userId = [JZGUserDataModel currentLoginUser].UserID;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"listByCar" forKey:@"op"];
    [params setObject:userId forKey:@"userId"];
    [params setObject:carId forKey:@"carId"];
    [params setObject:cityName forKey:@"cityName"];
    NSString *urlString = [NSString stringWithFormat:@"%@/Assessment/HistoryQuery.ashx",SPHOME_URL];
    WS(weakSelf);
    [[JZGNetWorkRequest sharedNetworkRequest] connectNetWithUrl:urlString
                                             requestNetworkType:JZGNetworkRequestPost
                                                     parameters:params
                                                timeoutInterval:0
                                                   successBlock:^(id returnData, NSInteger code, NSString *msg){
                                                       [weakSelf handleRequestSuccess:returnData sucBlock:sucBlock failBlock:failBlock];
                                                   }
                                                   failureBlock:^(NSError *error){
                                                       [weakSelf handleRequestFailed:error failBlock:failBlock];
                                                   }];

}

- (void)getXiaoShouGuwenListStoreid:(NSString *)storeid
                           sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                          failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    NSString *userId = [JZGUserDataModel currentLoginUser].UserID;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"saleoptions" forKey:@"op"];
    [params setObject:userId forKey:@"userId"];
    [params setObject:storeid forKey:@"storeid"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/ProcessOptions/GetOptions.ashx",SPHOME_URL];
    WS(weakSelf);
    [[JZGNetWorkRequest sharedNetworkRequest] connectNetWithUrl:urlString
                                             requestNetworkType:JZGNetworkRequestPost
                                                     parameters:params
                                                timeoutInterval:0
                                                   successBlock:^(id returnData, NSInteger code, NSString *msg){
                                                       [weakSelf handleRequestSuccess:returnData sucBlock:sucBlock failBlock:failBlock];
                                                   }
                                                   failureBlock:^(NSError *error){
                                                       [weakSelf handleRequestFailed:error failBlock:failBlock];
                                                   }];

}

- (void)getPingGuShiListPingguUserId:(NSString *)pingguUserId
                            sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                           failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *userId = [JZGUserDataModel currentLoginUser].UserID;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"PingGuShi" forKey:@"op"];
    [params setObject:userId forKey:@"UserId"];
    [params setObject:pingguUserId forKey:@"StoreId"];
//    [params setObject:storeid forKey:@"pingguUserId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/ProcessOptions/GetOptions.ashx",SPHOME_URL];
    WS(weakSelf);
    [[JZGNetWorkRequest sharedNetworkRequest] connectNetWithUrl:urlString
                                             requestNetworkType:JZGNetworkRequestPost
                                                     parameters:params
                                                timeoutInterval:0
                                                   successBlock:^(id returnData, NSInteger code, NSString *msg){
                                                       [weakSelf handleRequestSuccess:returnData sucBlock:sucBlock failBlock:failBlock];
                                                   }
                                                   failureBlock:^(NSError *error){
                                                       [weakSelf handleRequestFailed:error failBlock:failBlock];
                                                   }];
    
}

@end
