//
//  JZGNetWorkRequest.h
//  AFN3.0封装
//
//  Created by Mars on 15/12/20.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZGNetworkDefine.h"

@interface JZGNetWorkRequest : NSObject

//@property (strong, nonatomic)  NSOperationQueue *operationQueue;


//+ (void)netWorkStatusWithBlock:(void(^)(AFNetworkReachabilityStatus netWorkStatus))netWorkStatusBlock;

+ (JZGNetWorkRequest *)sharedNetworkRequest;

- (void)connectNetWithUrl:(NSString *)url
       requestNetworkType:(JZGNetworkRequestType)networkRequestType
               parameters:(NSDictionary *)parameters
          timeoutInterval:(NSTimeInterval)timeoutInterval
             successBlock:(JZGNetworkRequestSuccessBlock)successBlock
             failureBlock:(JZGNetworkRequestFailureBlock)failureBlock;


- (void)uploadImageWithUrl:(NSString *)url
                parameters:(NSDictionary *)parameters
                    images:(NSArray *)images
           timeoutInterval:(NSTimeInterval)timeInterval
              successBlock:(JZGNetworkRequestSuccessBlock)successBlock
              failureBlock:(JZGNetworkRequestFailureBlock)failureBlock;

- (void)uploadImageZipWithUrl:(NSString *)url
                   parameters:(NSDictionary *)parameter
                imagesZipPath:(NSURL *)imagesZipPath
                 successBlock:(JZGNetworkRequestSuccessBlock)successBlock
                 failureBlock:(JZGNetworkRequestFailureBlock)failureBlock;
- (void)POSTRequest:(NSString *)url
         parameters:(NSDictionary *)parameter
    timeoutInterval:(NSTimeInterval)timeoutInterval
       successBlock:(JZGNetworkRequestSuccessBlock)successBlock
       failureBlock:(JZGNetworkRequestFailureBlock)failureBlock;

- (void)cancelNetworkRequest;

@end
