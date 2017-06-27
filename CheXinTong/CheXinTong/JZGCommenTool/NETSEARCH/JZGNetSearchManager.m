//
//  JZGNetSearchManager.m
//  JZGERSecondPhase
//
//  Created by 杜维欣 on 16/9/28.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGNetSearchManager.h"
#import "JZGEncyptClass.h"

@interface JZGNetSearchManager ()

@property (nonatomic,strong)AFHTTPSessionManager *sessionManager;
@property (nonatomic,strong)NSMutableDictionary *tasksForIdentifier;

@end

static JZGNetSearchManager *_instance;

@implementation JZGNetSearchManager

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[JZGNetSearchManager alloc] init];
    });
    
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.sessionManager = [AFHTTPSessionManager manager];
        AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
        serializer.removesKeysWithNullValues = YES;
        serializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/javascript",@"text/json",@"text/plain",@"text/html",@"application/zip", nil];
        self.sessionManager.responseSerializer = serializer;
        self.tasksForIdentifier = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)searchWithUrl:(NSString *)url parameters:(NSDictionary *)parameter searchText:(NSString *)searchText identifier:(NSString *)identifier completeHandler:(void (^) (id sucessData))completeHandler errorHandler:(void (^) (NSError *error))errorHandler {
    
    NSURLSessionDataTask *preTask = self.tasksForIdentifier[identifier][searchText];
    if (preTask) return;
    
    NSDictionary *encryptedParameter = [JZGEncyptClass parameterSortWithDictionary:parameter];
    
    NSURLSessionDataTask *task = [self.sessionManager POST:url parameters:encryptedParameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self removeTaskWithSearchText:searchText identifier:identifier];
        
        if (completeHandler) {
            completeHandler(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorHandler) {
            errorHandler(error);
        }
        [self removeTaskWithSearchText:searchText identifier:identifier];
    }];
    
    [self addTask:task searchText:searchText identifier:identifier];
}

- (void)addTask:(NSURLSessionDataTask *)task searchText:(NSString *)searchText identifier:(NSString *)identifier {
    NSDictionary *identifierDic = self.tasksForIdentifier[identifier];
    if (!identifierDic) {
        self.tasksForIdentifier[identifier] = [NSMutableDictionary dictionary];
    }
    self.tasksForIdentifier[identifier][searchText] = task;
}

- (void)removeTaskWithSearchText:(NSString *)searchText identifier:(NSString *)identifier {
    NSMutableDictionary *identifierDic = self.tasksForIdentifier[identifier];
    [identifierDic removeObjectForKey:searchText];
    if (!identifierDic.count) {
        [self.tasksForIdentifier removeObjectForKey:identifier];
    }
}

- (void)cancleWithSearchText:(NSString *)searchText identifier:(NSString *)identifier; {
    NSURLSessionDataTask *preTask = self.tasksForIdentifier[identifier][searchText];
    if (!preTask) return;
    if (preTask.state == NSURLSessionTaskStateRunning) {
        [preTask cancel];
    }
}
@end
