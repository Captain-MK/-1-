//
//  JZGBackLogService.m
//  JZGERP
//
//  Created by cuik on 16/6/28.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGBackLogService.h"

@implementation JZGBackLogService

+ (instancetype)share{
    static dispatch_once_t t;
    static JZGBackLogService *service = nil;
    dispatch_once(&t, ^{
        service = [[JZGBackLogService alloc] init];
    });
    return service;
}





#pragma mark - 1.获取待办事项

- (void)getWaitDoneItemsWithType:(JZGWaitDoneItemsType)type
                         SalesId:(NSString *)SalesId
                       pageIndex:(NSInteger)pageIndex
                        pageSize:(NSInteger)pageSize
                        sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                       failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!SalesId || SalesId.length == 0) {
        errorInfo = @"SalesId不能为空";
    }
    if (!(type == JZGWaitDoneItemsTypeToday || type == JZGWaitDoneItemsTypeAll)) {
        errorInfo = @"op参数错误";
    }
    if (pageIndex < 0) {
        errorInfo = @"pageIndex参数不对";
    }
    if (pageSize < 0) {
        errorInfo = @"pageSize参数不对";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"getWaitDoneItems" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    if (type==JZGWaitDoneItemsTypeToday) {
        [params setObject:@"today" forKey:@"Op"];
    }
    else if (type==JZGWaitDoneItemsTypeAll) {
        [params setObject:@"all" forKey:@"Op"];
    }
    [params setObject:SalesId forKey:@"SalesId"];
    [params setObject:[NSString stringWithFormat:@"%d",(int)pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSString stringWithFormat:@"%d",(int)pageSize] forKey:@"pageSize"];
    
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/followup/GetWaitDoneItems.ashx",HOME_URL];
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

- (void)cancelGetWaitDoneItems{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}







#pragma mark - 2.修改待办事项的已读状态

- (void)changReadWithFollowupId:(NSString *)FollowupId
                       sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                      failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!FollowupId || FollowupId.length == 0) {
        errorInfo = @"FollowupId不能为空";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"changRead" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"changRead" forKey:@"Op"];
    [params setObject:FollowupId forKey:@"FollowupId"];
    
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/followup/GetWaitDoneItems.ashx",HOME_URL];
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

- (void)cancelChangRead{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}







#pragma mark - 3.获取今天和全部代办事项的总数量

- (void)getSumWithSalesId:(NSString *)SalesId
                 sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!SalesId || SalesId.length == 0) {
        errorInfo = @"SalesId不能为空";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"getSum" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"getSum" forKey:@"Op"];
    [params setObject:SalesId forKey:@"SalesId"];
    
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/followup/GetWaitDoneItems.ashx",HOME_URL];
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

- (void)cancelGetSum{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}

@end
