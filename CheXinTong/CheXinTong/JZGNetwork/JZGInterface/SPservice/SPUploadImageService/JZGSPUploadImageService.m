//
//  JZGSPUploadImageService.m
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/23.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGSPUploadImageService.h"

@implementation JZGSPUploadImageService

+ (instancetype)share{
    static dispatch_once_t t;
    static JZGSPUploadImageService *service = nil;
    dispatch_once(&t, ^{
        service = [[JZGSPUploadImageService alloc] init];
    });
    return service;
}

#pragma mark - 4.修改用户头像

- (void)uplodImageIconWithCarId:(NSString *)carId
                         images:(NSArray *)images
                       sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                      failBlock:(JZGNetworkRequestFailureBlock)failBlock{

    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"uploadimage" forKey:@"op"];
    [params setObject:carId forKey:@"carId"];
    NSString *userId = [JZGUserDataModel currentLoginUser].UserID;
    [params setObject:userId forKey:@"UserId"];
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/Assessment/CreateNew.ashx",HOME_URL];
    [[JZGNetWorkRequest sharedNetworkRequest] uploadImageWithUrl:urlString
                                                      parameters:params
                                                          images:images
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

- (void)cancelModifyIcon{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}

@end
