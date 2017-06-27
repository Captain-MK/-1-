//
//  JZGNetWorkRequest.m
//  AFN3.0封装
//
//  Created by Mars on 15/12/20.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGNetWorkRequest.h"
#import "JZGEncyptClass.h"
#import "AFNetworking.h"

@implementation JZGNetWorkRequest

+ (JZGNetWorkRequest *)sharedNetworkRequest{
    static JZGNetWorkRequest *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (!instance) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

- (AFHTTPSessionManager *)getSessionManger{
        
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    serializer.removesKeysWithNullValues = YES;
    serializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/javascript",@"text/json",@"text/plain",@"text/html",@"application/zip", nil];
    sessionManager.responseSerializer = serializer;
    
    return sessionManager;
}

- (void)connectNetWithUrl:(NSString *)url
       requestNetworkType:(JZGNetworkRequestType)networkRequestType
               parameters:(NSDictionary *)parameter
          timeoutInterval:(NSTimeInterval)timeoutInterval
             successBlock:(JZGNetworkRequestSuccessBlock)successBlock
             failureBlock:(JZGNetworkRequestFailureBlock)failureBlock
{
    switch (networkRequestType) {
        case JZGNetworkRequestGet:
            [self GETRequest:url parameters:parameter timeoutInterval:timeoutInterval successBlock:successBlock failureBlock:failureBlock];
            break;
        case JZGNetworkRequestPost:
            [self POSTRequest:url parameters:parameter timeoutInterval:timeoutInterval successBlock:successBlock failureBlock:failureBlock];
            break;
        default:
            break;
    }
}

- (void)GETRequest:(NSString *)url
        parameters:(NSDictionary *)parameter
   timeoutInterval:(NSTimeInterval)timeoutInterval
      successBlock:(JZGNetworkRequestSuccessBlock)successBlock
      failureBlock:(JZGNetworkRequestFailureBlock)failureBlock{
    
    AFHTTPSessionManager *sessionManager = [self getSessionManger];
    sessionManager.requestSerializer.timeoutInterval = timeoutInterval;
    NSDictionary *parameters = [JZGEncyptClass parameterSortWithDictionary:parameter];
    [sessionManager GET:url
             parameters:parameters
               progress:^(NSProgress * _Nonnull downloadProgress) {}
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSInteger code = 0;
                    NSString *msg = @"";
                    if (responseObject) {
                        NSString *success   = responseObject[@"success"];
                        code                = success.intValue;
                        msg                 = responseObject[@"Message"];
                    }
                    successBlock(responseObject,code,msg);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    failureBlock(error);
                }];
}


- (void)POSTRequest:(NSString *)url
        parameters:(NSDictionary *)parameter
   timeoutInterval:(NSTimeInterval)timeoutInterval
      successBlock:(JZGNetworkRequestSuccessBlock)successBlock
      failureBlock:(JZGNetworkRequestFailureBlock)failureBlock{
    
    AFHTTPSessionManager *sessionManager = [self getSessionManger];
    sessionManager.requestSerializer.timeoutInterval = timeoutInterval;
    NSDictionary *parameters;
    if ([url isEqualToString:Loaction_City_List]) {
        parameters = [JZGEncyptClass parameterSortWithDictionarys:parameter];
    }else{
        parameters = [JZGEncyptClass parameterSortWithDictionary:parameter];
    }
    
    [sessionManager POST:url
              parameters:parameters
                progress:^(NSProgress *uploadProgress) {}
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                     NSLog(@"%@",responseObject[@"Message"]);
                     NSInteger code = 0;
                     NSString *msg = @"";
                     if (responseObject) {
                         NSString *success   = responseObject[@"success"];
                         code                = success.intValue;
                         msg                 = responseObject[@"Message"];
                     }
                     successBlock(responseObject,code,msg);
                 } failure:^(NSURLSessionDataTask *task, NSError *error) {
                     failureBlock(error);
                 }];
    
}

- (void)uploadImageWithUrl:(NSString *)url
                parameters:(NSDictionary *)parameter
                    images:(NSArray *)images
           timeoutInterval:(NSTimeInterval)timeInterval
              successBlock:(JZGNetworkRequestSuccessBlock)successBlock
              failureBlock:(JZGNetworkRequestFailureBlock)failureBlock
{
    AFHTTPSessionManager *sessionManager = [self getSessionManger];
    NSTimeInterval timeIntervals = 0;
    if ([images count] >= 3) {
        timeIntervals = ([images count] / 3  + 1) * timeInterval;
    }else
        timeIntervals = timeInterval;
    sessionManager.requestSerializer.timeoutInterval = timeIntervals;
    NSDictionary *parameters = [JZGEncyptClass parameterSortWithDictionary:parameter];
    [sessionManager POST:url parameters:parameters
              constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSInteger i = 0; i < [images count]; i++) {
            [formData appendPartWithFileData:[images objectAtIndex:i] name:@"" fileName:@"filename.jpg" mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject[@"Message"]);
        NSInteger code = 0;
        NSString *msg = @"";
        if (responseObject) {
            NSString *success   = responseObject[@"success"];
            code                = success.intValue;
            msg                 = responseObject[@"msg"];
        }
        successBlock(responseObject,code,msg);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

- (void)uploadImageZipWithUrl:(NSString *)url
                   parameters:(NSDictionary *)parameter
                imagesZipPath:(NSURL *)imagesZipPath
                 successBlock:(JZGNetworkRequestSuccessBlock)successBlock
                 failureBlock:(JZGNetworkRequestFailureBlock)failureBlock
{

    AFHTTPSessionManager *sessionManager = [self getSessionManger];
    NSDictionary *parameters = [JZGEncyptClass parameterSortWithDictionary:parameter];
    NSLog(@"%@",parameters);
    [sessionManager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileURL:imagesZipPath name:@"file" fileName:@"file.zip" mimeType:@"application/zip" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject[@"msg"]);
        NSInteger code = 0;
        NSString *msg = @"";
        if (responseObject) {
            NSString *success   = responseObject[@"success"];
            code                = success.intValue;
            msg                 = responseObject[@"msg"];
        }
        successBlock(responseObject,code,msg);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failureBlock(error);
    }];
}


- (void)cancelNetworkRequest
{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager.operationQueue cancelAllOperations];
}


@end
