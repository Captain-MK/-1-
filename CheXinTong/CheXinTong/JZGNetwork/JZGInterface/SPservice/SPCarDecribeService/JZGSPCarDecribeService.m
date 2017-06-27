//
//  JZGSPCarDecribeService.m
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/23.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGSPCarDecribeService.h"

@implementation JZGSPCarDecribeService

+ (instancetype)share{
    static dispatch_once_t t;
    static JZGSPCarDecribeService *service = nil;
    dispatch_once(&t, ^{
        service = [[JZGSPCarDecribeService alloc] init];
    });
    return service;
}

- (void)getHCarDecribeItemsWithStoreID:(NSString *)storeId
                                   vin:(NSString *)vin
                              sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                             failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"getentity" forKey:@"op"];
    [params setObject:vin forKey:@"vin"];
    [params setObject:storeId forKey:@"StoreId"];

    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@Assessment/HistoryQuery.ashx",HOME_URL];
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
- (void)cancelCarDecribetDoneItems{


}

@end
