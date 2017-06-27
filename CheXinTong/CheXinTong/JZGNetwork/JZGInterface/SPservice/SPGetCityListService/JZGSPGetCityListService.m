//
//  JZGSPGetCityListService.m
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/25.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGSPGetCityListService.h"

@implementation JZGSPGetCityListService

+ (instancetype)share{
    static dispatch_once_t t;
    static JZGSPGetCityListService *service = nil;
    dispatch_once(&t, ^{
        service = [[JZGSPGetCityListService alloc] init];
    });
    return service;
}

- (void)getCityListServiceprovinceId:(NSString *)provinceId
                            sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                           failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"areacity" forKey:@"op"];
    [params setObject:provinceId forKey:@"provinceId"];
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


- (void)cancelModifyIcon{


}

@end
