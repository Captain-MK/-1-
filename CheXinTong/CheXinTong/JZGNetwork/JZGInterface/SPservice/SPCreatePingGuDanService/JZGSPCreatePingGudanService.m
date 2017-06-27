//
//  JZGSPCreatePingGudanService.m
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/26.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGSPCreatePingGudanService.h"
#import "JZGUserDataModel.h"

@implementation JZGSPCreatePingGudanService

+ (instancetype)share{
    static dispatch_once_t t;
    static JZGSPCreatePingGudanService *service = nil;
    dispatch_once(&t, ^{
        service = [[JZGSPCreatePingGudanService alloc] init];
    });
    return service;
}

- (void)createPingGudanService:(NSDictionary *)dic
                      sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                     failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    NSString *userId = [JZGUserDataModel currentLoginUser].UserID;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"add" forKey:@"op"];
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


@end
