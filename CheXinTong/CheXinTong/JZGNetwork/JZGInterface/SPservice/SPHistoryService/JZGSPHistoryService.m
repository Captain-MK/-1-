//
//  JZGSPHistoryService.m
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/23.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGSPHistoryService.h"

@implementation JZGSPHistoryService

+ (instancetype)share{
    static dispatch_once_t t;
    static JZGSPHistoryService *service = nil;
    dispatch_once(&t, ^{
        service = [[JZGSPHistoryService alloc] init];
    });
    return service;
}

- (void)getHistoryStatussucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                       failBlock:(JZGNetworkRequestFailureBlock)failBlock{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"assessstatus" forKey:@"op"];
    NSString *userId = [JZGUserDataModel currentLoginUser].UserID;
    [params setObject:userId forKey:@"PingguUserId"];
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/ProcessOptions/GetOptions.ashx",HOME_URL];
    [[JZGNetWorkRequest sharedNetworkRequest] connectNetWithUrl:urlString
                                             requestNetworkType:JZGNetworkRequestPost
                                                     parameters:params
                                                timeoutInterval:20
                                                   successBlock:^(id returnData, NSInteger code, NSString *msg)
     {
         [weakSelf handleRequestSuccess:returnData sucBlock:sucBlock failBlock:failBlock];
     }
                                                   failureBlock:^(NSError *error)
     {
         [weakSelf handleRequestFailed:error failBlock:failBlock];
     }];
}

- (void)getHistoryItemsWithLicensePlate:(NSString *)LicensePlate
                                SalesId:(NSString *)SalesId
                              pageIndex:(NSInteger)pageIndex
                          RequestStatus:(NSString *)RequestStatus
                        SearchStartDate:(NSString *)SearchStartDate
                          SearchEndDate:(NSString *)SearchEndDate
                               UserName:(NSString *)pingGuShiName
                               sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                              failBlock:(JZGNetworkRequestFailureBlock)failBlock{

    NSString *pageIndexString = [NSString stringWithFormat:@"%d",(int)pageIndex];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"list" forKey:@"op"];
    [params setObject:pageIndexString forKey:@"pageindex"];
    [params setObject:@"10" forKey:@"pagesize"];
    [params setObject:LicensePlate forKey:@"LicensePlate"];
    [params setObject:RequestStatus forKey:@"RequestStatus"];
    [params setObject:SearchEndDate forKey:@"SearchEndDate"];
    [params setObject:SearchStartDate forKey:@"SearchStartDate"];
    [params setObject:SalesId forKey:@"StoreId"];
    [params setObject:pingGuShiName forKey:@"UserName"];
    NSString *userId = [JZGUserDataModel currentLoginUser].UserID;
    [params setObject:userId forKey:@"UserId"];
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/Assessment/HistoryQuery.ashx",HOME_URL];
    [[JZGNetWorkRequest sharedNetworkRequest] connectNetWithUrl:urlString
                                             requestNetworkType:JZGNetworkRequestPost
                                                     parameters:params
                                                timeoutInterval:20
                                                   successBlock:^(id returnData, NSInteger code, NSString *msg)
     {
         [weakSelf handleRequestSuccess:returnData sucBlock:sucBlock failBlock:failBlock];
     }
                                                   failureBlock:^(NSError *error)
     {
         [weakSelf handleRequestFailed:error failBlock:failBlock];
     }];
}

/**
 *  取消获取待办事项
 */
- (void)cancelHistorytDoneItems{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}

@end
