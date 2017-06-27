//
//  JZGSPBaseService.m
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/22.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGSPBaseService.h"

@implementation JZGSPBaseService

+ (instancetype)share{
    static dispatch_once_t t;
    static JZGSPBaseService *service = nil;
    dispatch_once(&t, ^{
        service = [[JZGSPBaseService alloc] init];
    });
    return service;
}

- (void)getBaseService:(NSDictionary *)paramats
              sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
             failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    WS(weakSelf);
#warning 无参数会很慢
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[JZGUserDataModel currentLoginUser].UserID,@"UserId", nil];
    NSString *urlString = [NSString stringWithFormat:@"%@/ProcessOptions/GetOptions.ashx",SPHOME_URL];
    [[JZGNetWorkRequest sharedNetworkRequest] connectNetWithUrl:urlString
                                             requestNetworkType:JZGNetworkRequestPost
                                                     parameters:dic
                                                timeoutInterval:10
                                                   successBlock:^(id returnData, NSInteger code, NSString *msg){
                                                       [weakSelf handleRequestSuccess:returnData sucBlock:sucBlock failBlock:failBlock];
                                                   }
                                                   failureBlock:^(NSError *error){
                                                       [weakSelf handleRequestFailed:error failBlock:failBlock];
                                                   }];

}

/**
 *  取消用户登录
 */
- (void)cancelBaseService{

    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}

@end
