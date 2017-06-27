//
//  JZGUserService.m
//  JZGDetectionPlatform
//
//  Created by cuik on 16/4/5.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import "JZGUserService.h"
#import "AFNetworking.h"

@implementation JZGUserService{
}

+ (instancetype)share{
    static dispatch_once_t t;
    static JZGUserService *service = nil;
    dispatch_once(&t, ^{
        service = [[JZGUserService alloc] init];
    });
    return service;
}

+ (BOOL)isLogin{
    return [JZGUserDataModel isLogin];
}

#pragma mark - 1.用户登录

- (void)loginWithUserName:(NSString *)lgcode
                 password:(NSString *)pwd
                 sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!lgcode || lgcode.length == 0) {
        errorInfo = @"用户名不能为空";
    }
    if (!pwd || pwd.length == 0) {
        errorInfo = @"密码不能为空";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"login" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"login" forKey:@"Op"];
    [params setObject:lgcode forKey:@"Phone"];
    [params setObject:pwd forKey:@"Pwd"];
    
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/Account/UserAccount.ashx",HOME_URL];
    NSLog(@"%@",urlString);
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

- (void)cancelLogin{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}

#pragma mark - 2.修改用户密码

- (void)modifypwdWithUserid:(NSString *)userid
                        pwd:(NSString *)pwd old:(NSString *)oldpwd
                   sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                  failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!userid || userid.length == 0) {
        errorInfo = @"用户id不能为空";
    }
    if (!oldpwd || oldpwd.length == 0) {
        errorInfo = @"旧密码不能为空";
    }

    if (!pwd || pwd.length == 0) {
        errorInfo = @"新密码不能为空";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"modifypwd" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"modifypwd" forKey:@"Op"];
    [params setObject:userid forKey:@"userid"];
    [params setObject:pwd forKey:@"pwd"];
    [params setObject:oldpwd forKey:@"oldpwd"];
    
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/Account/UserAccount.ashx",HOME_URL];
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

- (void)cancelModifypwd{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}

#pragma mark - 3.浏览用户信息

- (void)browseAccountinformationWithUserid:(NSString *)userid
                                  sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                                 failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!userid || userid.length == 0) {
        errorInfo = @"用户id不能为空";
    }
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"browseAccountinformation" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"browseAccountinformation" forKey:@"Op"];
    [params setObject:userid forKey:@"userid"];
    
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/Account/UserAccount.ashx",HOME_URL];
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

- (void)cancelBrowseAccountinformation{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}

#pragma mark - 4.修改用户头像

- (void)modifyIconWithUserid:(NSString *)userid
                      images:(NSArray *)images
                    sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                   failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!userid || userid.length == 0) {
        errorInfo = @"用户id不能为空";
    }
    if (images.count<=0) {
        errorInfo = @"图片不能为空";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"modifyIcon" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"modifyIcon" forKey:@"Op"];
    [params setObject:userid forKey:@"userid"];
    
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/Account/UserAccount.ashx",HOME_URL];
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
