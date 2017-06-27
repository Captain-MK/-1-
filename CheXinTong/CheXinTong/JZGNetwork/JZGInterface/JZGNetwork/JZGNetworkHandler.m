//
//  JZGNetworkHandler.m
//  AFN3.0封装
//
//  Created by Mars on 15/12/20.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGNetworkHandler.h"
#import "JZGNetWorkRequest.h"
#import "JZGNetworkingStatus.h"
#import "AFNetworking.h"

@implementation JZGNetworkHandler

+ (JZGNetworkHandler *)sharedNetworkHandler{
    static JZGNetworkHandler *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (!instance) {
            instance = [[self alloc] init];
        }
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {}
    return self;
}

- (void)connectNetWithUrl:(NSString *)url
       requestNetworkType:(JZGNetworkRequestType)networkRequestType
               parameters:(NSDictionary *)parameters
          timeoutInterval:(NSTimeInterval)timeoutInterval
             successBlock:(JZGNetworkRequestSuccessBlock)successBlock
             failureBlock:(JZGNetworkRequestFailureBlock)failureBlock
{
    [[JZGNetWorkRequest sharedNetworkRequest] connectNetWithUrl:url requestNetworkType:networkRequestType parameters:parameters timeoutInterval:timeoutInterval successBlock:successBlock failureBlock:failureBlock];
}


- (void)uploadImageWithUrl:(NSString *)url
                parameters:(NSDictionary *)parameters
                    images:(NSArray *)images
           timeoutInterval:(NSTimeInterval)timeInterval
              successBlock:(JZGNetworkRequestSuccessBlock)successBlock
              failureBlock:(JZGNetworkRequestFailureBlock)failureBlock
{
    if (![[JZGNetworkingStatus sharedNetworkingStatus] netWorkingStatus]) {
        [[JZGCommenTool shareCommenTool] showAlertView:@"网络连接断开,请检查网络!"];
        return ;
    }
    [[JZGNetWorkRequest sharedNetworkRequest] uploadImageWithUrl:url parameters:parameters images:images timeoutInterval:timeInterval successBlock:successBlock failureBlock:failureBlock];
}

- (void)cancelNetworkHandler
{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager.operationQueue cancelAllOperations];
   
}
@end
