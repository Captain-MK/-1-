//
//  JZGSPCreatePingGuDanService.m
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/28.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGSPCreatePingGuDanService.h"

@implementation JZGSPCreatePingGuDanService

+ (instancetype)share{
    static dispatch_once_t t;
    static JZGSPCreatePingGuDanService *service = nil;
    dispatch_once(&t, ^{
        service = [[JZGSPCreatePingGuDanService alloc] init];
    });
    return service;
}


- (void)createPingGuDanService:(NSDictionary *)paramats
                      sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                     failBlock:(JZGNetworkRequestFailureBlock)failBlock{

    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/Assessment/CreateNew.ashx",SPHOME_URL];
    [[JZGNetWorkRequest sharedNetworkRequest] connectNetWithUrl:urlString
                                             requestNetworkType:JZGNetworkRequestPost
                                                     parameters:paramats
                                                timeoutInterval:0
                                                   successBlock:^(id returnData, NSInteger code, NSString *msg){
                                                       [weakSelf handleRequestSuccess:returnData sucBlock:sucBlock failBlock:failBlock];
                                                   }
                                                   failureBlock:^(NSError *error){
                                                       [weakSelf handleRequestFailed:error failBlock:failBlock];
                                                   }];

}

@end
