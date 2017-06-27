//
//  JZGSPCheLiangJianceService.m
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/25.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGSPCheLiangJianceService.h"

@implementation JZGSPCheLiangJianceService

+ (instancetype)share{
    static dispatch_once_t t;
    static JZGSPCheLiangJianceService *service = nil;
    dispatch_once(&t, ^{
        service = [[JZGSPCheLiangJianceService alloc] init];
    });
    return service;
}

- (void)getCheliangeJiancesucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                         failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"getcarcheck" forKey:@"op"];
    NSString *userId = [JZGUserDataModel currentLoginUser].UserID;
    [params setObject:userId forKey:@"UserId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/Assessment/CreateNew.ashx",SPHOME_URL];
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

@end
