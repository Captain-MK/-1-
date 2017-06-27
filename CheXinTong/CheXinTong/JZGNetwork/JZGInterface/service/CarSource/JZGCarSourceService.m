//
//  JZGCarSourceService.m
//  JZGERP
//
//  Created by cuik on 16/6/28.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGCarSourceService.h"

@implementation JZGCarSourceService

+ (instancetype)share{
    static dispatch_once_t t;
    static JZGCarSourceService *service = nil;
    dispatch_once(&t, ^{
        service = [[JZGCarSourceService alloc] init];
    });
    return service;
}


#pragma mark - 1.获取用户已关注的车辆列表

- (void)focusCarListWithCustomerId:(NSString *)customerId
                         pageIndex:(NSInteger)pageIndex
                         pageCount:(NSInteger)pageCount
                          sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                         failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!customerId  || customerId.length == 0) {
        errorInfo = @"customerId不能为空";
    }
    if (pageIndex < 0) {
        errorInfo = @"pageIndex参数不对";
    }
    if (pageCount < 0) {
        errorInfo = @"pageCount参数不对";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"focusCarList" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"focusCarList" forKey:@"Op"];
    [params setObject:customerId forKey:@"customerId"];
    [params setObject:[NSString stringWithFormat:@"%ld",pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSString stringWithFormat:@"%ld",pageCount] forKey:@"pageCount"];
    [params setObject:[JZGUserDataModel currentLoginUser].UserID forKey:@"userID"];
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/customer/todolist.ashx",HOME_URL];
    [[JZGNetWorkRequest sharedNetworkRequest] connectNetWithUrl:urlString
                                             requestNetworkType:JZGNetworkRequestPost
                                                     parameters:params
                                                timeoutInterval:20
                                                   successBlock:^(id returnData, NSInteger code, NSString *msg){
                                                       
                                                       [weakSelf handleRequestSuccess:returnData sucBlock:sucBlock failBlock:failBlock];
                                                   }
                                                   failureBlock:^(NSError *error){
                                                       
                                                       [weakSelf handleRequestFailed:error failBlock:failBlock];
                                                   }];
}

- (void)cancelFocusCarList{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}

#pragma mark - 2.根据查询条件获取未关注车辆信息列表

- (void)focusCarLsitByConditionWithCustomerId:(NSString *)customerId
                                    condition:(NSString *)condition
                                    pageIndex:(NSInteger)pageIndex
                                    pageCount:(NSInteger)pageCount
                                     sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                                    failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!customerId  || customerId.length == 0) {
        errorInfo = @"customerId不能为空";
    }
    if (pageIndex < 0) {
        errorInfo = @"pageIndex参数不对";
    }
    if (pageCount < 0) {
        errorInfo = @"pageCount参数不对";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"focusCarLsitByCondition" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"focusCarLsitByCondition" forKey:@"Op"];
    [params setObject:customerId forKey:@"customerId"];
    if (condition && condition.length) {
        [params setObject:condition forKey:@"condition"];
    }
    [params setObject:[NSString stringWithFormat:@"%ld",pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSString stringWithFormat:@"%ld",pageCount] forKey:@"pageCount"];
    [params setObject:[JZGUserDataModel currentLoginUser].UserID forKey:@"userID"];
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/customer/todolist.ashx",HOME_URL];
    [[JZGNetWorkRequest sharedNetworkRequest] connectNetWithUrl:urlString
                                             requestNetworkType:JZGNetworkRequestPost
                                                     parameters:params
                                                timeoutInterval:20
                                                   successBlock:^(id returnData, NSInteger code, NSString *msg){
                                                       [weakSelf handleRequestSuccess:returnData sucBlock:sucBlock failBlock:failBlock];
                                                   }
                                                   failureBlock:^(NSError *error){
                                                       [weakSelf handleRequestFailed:error failBlock:failBlock];
                                                   }];
}

- (void)cancelFocusCarLsitByCondition{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}

#pragma mark - 3.添加用户未关注的车辆

- (void)insertFocusCarWithCustomerId:(NSString *)customerId
                      carsourceIdArr:(NSString *)carsourceIdArr
                            carIdArr:(NSString *)carIdArr
                            sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                           failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!customerId  || customerId.length == 0) {
        errorInfo = @"customerId不能为空";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"insertFocusCar" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    JZGUserDataModel *user = [JZGUserDataModel currentLoginUser];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"insertFocusCar" forKey:@"Op"];
    [params setObject:customerId forKey:@"customerId"];
    [params setObject:user.TrueName forKey:@"currentUserName"];
    if (carsourceIdArr && carsourceIdArr.length) {
        [params setObject:carsourceIdArr forKey:@"carsourceIdArr"];
    }
    if (carIdArr && carIdArr.length) {
        [params setObject:carIdArr forKey:@"carIdArr"];
    }
    [params setObject:[JZGUserDataModel currentLoginUser].UserID forKey:@"userID"];
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/customer/todolist.ashx",HOME_URL];
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

- (void)cancelInsertFocusCar{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}






#pragma mark - 4.获取车源信息列表

- (void)getCarListWithMakeName:(NSString *)makeName
                        makeID:(NSString *)makeID
                       modelID:(NSString *)modelID
                     carStatus:(NSString *)carStatus
                          Sort:(NSString *)Sort
                     condition:(NSString *)condition
                     pageIndex:(NSInteger)pageIndex
                     pageCount:(NSInteger)pageCount
                      sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                     failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!carStatus  || carStatus.length == 0) {
        errorInfo = @"carStatus不能为空";
    }
    if (!Sort  || Sort.length == 0) {
        errorInfo = @"Sort不能为空";
    }
    if (pageIndex < 0) {
        errorInfo = @"pageIndex参数不对";
    }
    if (pageCount < 0) {
        errorInfo = @"pageCount参数不对";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"getCarList" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"getCarList" forKey:@"Op"];
    if (makeName && makeName.length) {
        [params setObject:makeName forKey:@"makeName"];
    }
    [params setObject:carStatus forKey:@"carStatus"];
    [params setObject:Sort forKey:@"Sort"];
    if (condition && condition.length) {
        [params setObject:condition forKey:@"condition"];
    }
    [params setObject:[NSString stringWithFormat:@"%ld",pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSString stringWithFormat:@"%ld",pageCount] forKey:@"pageCount"];
    [params setObject:makeID?makeID:@"" forKey:@"makeID"];
    [params setObject:modelID?modelID:@"" forKey:@"modelID"];
    [params setObject:[JZGUserDataModel currentLoginUser].UserID forKey:@"userID"];
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/customer/todolist.ashx",HOME_URL];
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

- (void)cancelGetCarList{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}

#pragma mark - 5.获取车辆的意向用户列表

- (void)getIntendCustomerListWithuserId:(NSString *)userId
                            carSourceID:(NSString *)carSourceID
                              pageIndex:(NSInteger)pageIndex
                              pageCount:(NSInteger)pageCount
                               sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                              failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!userId  || userId.length == 0) {
        errorInfo = @"用户id不能为空";
    }
    if (!carSourceID  || carSourceID.length == 0) {
        errorInfo = @"车源id不能为空";
    }
    if (pageIndex < 0) {
        errorInfo = @"pageIndex参数不对";
    }
    if (pageCount < 0) {
        errorInfo = @"pageCount参数不对";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"getIntendCustomerList" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"getIntendCustomerBySellerIDAndCarID" forKey:@"Op"];
    [params setObject:userId forKey:@"userId"];
    [params setObject:carSourceID forKey:@"carSourceID"];
    [params setObject:[NSString stringWithFormat:@"%ld",pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSString stringWithFormat:@"%ld",pageCount] forKey:@"pageCount"];
    
   
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/customer/todolist.ashx",HOME_URL];
    
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

- (void)cancelGetIntendCustomerList{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}






#pragma mark - 6.批量添加关注此车辆的客户

- (void)batchInsertFocusCarCustomerWithCustomerIdList:(NSString *)customerIdList
                                          carsourceId:(NSString *)carsourceId
                                                carId:(NSString *)carId
                                             sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                                            failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!customerIdList  || customerIdList.length == 0) {
        errorInfo = @"customerIdList不能为空";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"batchInsertFocusCarCustomer" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"batchInsertFocusCarCustomer" forKey:@"Op"];
    [params setObject:customerIdList forKey:@"customerIdList"];
    [params setObject:[JZGUserDataModel currentLoginUser].UserID forKey:@"userID"];
    if (carsourceId && carsourceId.length) {
        [params setObject:carsourceId forKey:@"carsourceId"];
    }
    if (carId && carId.length) {
        [params setObject:carId forKey:@"carId"];
    }
    
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/customer/todolist.ashx",HOME_URL];
     NSLog(@"%@-----%@",urlString,params);
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

- (void)cancelBatchInsertFocusCarCustomer{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}


@end
