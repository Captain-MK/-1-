//
//  JZGBaseService.m
//  JZGDetectionPlatform
//
//  Created by cuik on 16/4/5.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import "JZGBaseService.h"

@implementation JZGBaseService

+ (instancetype)share{
    static dispatch_once_t t;
    static JZGBaseService *service = nil;
    dispatch_once(&t, ^{
        service = [[JZGBaseService alloc] init];
    });
    return service;
}

- (void)handleRequestSuccess:(NSDictionary *)dictionary
                    sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                   failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    if (!dictionary || [[dictionary allKeys] count]==0) {
        if (failBlock) {
            NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"网络不给力",PL_ERROR_INFO_KEY, nil];
            NSError *error = [[NSError alloc] initWithDomain:@"网络不给力"
                                                        code:RESULT_API_DATA_TYPE_ERROR
                                                    userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSString *status = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"Status"]];
    if ([status isEqualToString:@"1"]) {
        if (dictionary) {
            if (sucBlock)
            {
                sucBlock (dictionary,1,@"");
            }
        }
        else{
            if (failBlock) {
                NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"数据错误",PL_ERROR_INFO_KEY, nil];
                NSError *error = [[NSError alloc] initWithDomain:@"数据错误"
                                                            code:RESULT_API_DATA_TYPE_ERROR
                                                        userInfo:userInfo];
                failBlock (error);
            }
        }
        return;
    }
    
    //其它异常
    if (dictionary && [dictionary objectForKey:@"Status"]) {
        if (failBlock) {
            NSString *errorMessage = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"Message"]];
            if (!errorMessage || errorMessage.length==0) {
                errorMessage = @"网络不给力";
            }
            NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:errorMessage,PL_ERROR_INFO_KEY, nil];
            NSError *error = [[NSError alloc] initWithDomain:errorMessage
                                                        code:RESULT_API_DATA_TYPE_ERROR
                                                    userInfo:userInfo];
            failBlock(error);
            return;
        }
    }
    return;
}

- (void)handleRequestFailed:(NSError *)error
                  failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    if (failBlock) {
        // 用户手动中断请求
        if (error.code == 1022) {
            failBlock (error);
            return;
        }
        
        if (![[JZGNetworkingStatus sharedNetworkingStatus] netWorkingStatus]) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"网络不给力"
                                                                 forKey:PL_ERROR_INFO_KEY];
            NSError *customError = [[NSError alloc] initWithDomain:@"" code:-1 userInfo:userInfo];
            failBlock (customError);
        }
        else if (error.code == 1)
        {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"网络不给力"
                                                                 forKey:PL_ERROR_INFO_KEY];
            NSError *customError = [[NSError alloc] initWithDomain:@"" code:-1 userInfo:userInfo];
            failBlock (customError);
        }
        else if (error.code == 2){
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"网络不给力"
                                                                 forKey:PL_ERROR_INFO_KEY];
            NSError *customError = [[NSError alloc] initWithDomain:@"" code:-1 userInfo:userInfo];
            failBlock (customError);
        }
        else{
            NSString *errorInfo = [JZGNetworkError errorWithCode:error.code];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo
                                                                 forKey:PL_ERROR_INFO_KEY];
            NSError *resultError = [[NSError alloc] initWithDomain:error.domain
                                                              code:error.code
                                                          userInfo:userInfo];
            failBlock (resultError);
        }
    }
}

@end
