//
//  JZGSystemService.m
//  JZGChryslerForPad
//
//  Created by cuik on 16/6/4.
//  Copyright © 2016年 Beijing JingZhenGu Information Technology Co.Ltd. All rights reserved.
//

#import "JZGSystemService.h"

@implementation JZGSystemService

+ (instancetype)share{
    static dispatch_once_t t;
    static JZGSystemService *service = nil;
    dispatch_once(&t, ^{
        service = [[JZGSystemService alloc] init];
    });
    return service;
}

#pragma mark - 1.版本检测

- (void)appVersionCheckWithSucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                          failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"iosphone" forKey:@"phoneType"];
    
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/APPUpdate/APPUpdateVersion.ashx",HOME_URL];
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

- (void)cancelAppVersionCheck{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}

@end
