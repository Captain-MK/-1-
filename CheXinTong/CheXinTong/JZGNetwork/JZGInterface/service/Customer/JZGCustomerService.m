//
//  JZGCustomerService.m
//  JZGERP
//
//  Created by cuik on 16/6/28.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGCustomerService.h"
#import "JZGUserDataModel.h"

@implementation JZGCustomerService

+ (instancetype)share{
    static dispatch_once_t t;
    static JZGCustomerService *service = nil;
    dispatch_once(&t, ^{
        service = [[JZGCustomerService alloc] init];
    });
    return service;
}


#pragma mark - 1.客户信息详情接口

- (void)getCustomerInfoWithCustomerId:(NSString *)customerId
                             sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                            failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!customerId || customerId.length == 0) {
        errorInfo = @"customerId不能为空";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"getCustomerInfo" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"getCustomerInfo" forKey:@"Op"];
    [params setObject:customerId forKey:@"customerId"];
    [params setObject:[JZGUserDataModel currentLoginUser].UserID forKey:@"userID"];
    
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/Customer/ToDoList.ashx",HOME_URL];
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

- (void)cancelGetCustomerInfo{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}





#pragma mark - 2.修改购车意向接口

- (void)updateIntendBuyCarWithIntendCarMakeModelID:(NSString *)intendCarMakeModelID
                                         intendCar:(NSString *)intendCar
                                      transmission:(NSString *)transmission
                                       intendMoney:(NSString *)intendMoney
                                            remark:(NSString *)remark
                                        customerID:(NSString *)customerID
                                          sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                                         failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!transmission || transmission.length == 0) {
        errorInfo = @"transmission不能为空";
    }
    if (!customerID || customerID.length == 0) {
        errorInfo = @"customerID不能为空";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"updateIntendBuyCar" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"updateIntendBuyCar" forKey:@"Op"];
    if (intendCarMakeModelID && intendCarMakeModelID.length) {
        [params setObject:intendCarMakeModelID forKey:@"intendCarMakeModelID"];
    }
    if (intendCar && intendCar.length) {
        [params setObject:intendCar forKey:@"intendCar"];
    }
    if (intendMoney) {
        [params setObject:intendMoney forKey:@"intendMoney"];
    }
    [params setObject:transmission forKey:@"transmission"];
    if (remark) {
        [params setObject:remark forKey:@"remark"];
    }
    [params setObject:customerID forKey:@"customerID"];
    [params setObject:[JZGUserDataModel currentLoginUser].UserID forKey:@"userID"];
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/Customer/ToDoList.ashx",HOME_URL];
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

- (void)cancelUpdateIntendBuyCar{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}

#pragma mark - 3.插入电话记录接口

- (void)insertContractRecordWithCustomerID:(NSString *)CustomerID
                              CustomerName:(NSString *)CustomerName
                                   SalesId:(NSString *)SalesId
                                 SalesName:(NSString *)SalesName
                               TalkingTime:(NSString *)TalkingTime
                                  sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                                 failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!CustomerID || CustomerID.length == 0) {
        errorInfo = @"CustomerID不能为空";
    }
    if (!SalesId || SalesId.length == 0) {
        errorInfo = @"SalesId不能为空";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"insertContractRecord" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"insertContractRecord" forKey:@"Op"];
    [params setObject:CustomerID forKey:@"CustomerID"];
    [params setObject:SalesId forKey:@"SalesId"];
    if (CustomerName && CustomerName.length) {
        [params setObject:CustomerName forKey:@"CustomerName"];
    }
    if (SalesName && SalesName.length) {
        [params setObject:SalesName forKey:@"SalesName"];
    }
    if (TalkingTime && TalkingTime.length) {
        [params setObject:TalkingTime forKey:@"TalkingTime"];
    }
    [params setObject:[JZGUserDataModel currentLoginUser].UserID forKey:@"userID"];
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/Customer/ToDoList.ashx",HOME_URL];
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

- (void)cancelInsertContractRecord{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}

#pragma mark - 4.匹配车源接口

- (void)matchUserIntendCarWithIntendCar:(NSString *)intendCar
                               makeName:(NSString *)makeName
                              carStatus:(NSString *)carStatus
                                   sort:(NSString *)sort
                               sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                              failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"matchUserIntendCar" forKey:@"Op"];
    if (intendCar && intendCar.length) {
        [params setObject:intendCar forKey:@"intendCar"];
    }
    if (makeName && makeName.length) {
        [params setObject:makeName forKey:@"makeName"];
    }
    if (carStatus && carStatus.length) {
        [params setObject:carStatus forKey:@"carStatus"];
    }
    if (sort && sort.length) {
        [params setObject:sort forKey:@"sort"];
    }
    [params setObject:[JZGUserDataModel currentLoginUser].UserID forKey:@"userID"];
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/Customer/ToDoList.ashx",HOME_URL];
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

- (void)cancelMatchUserIntendCar{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}

#pragma mark - 5.获取用户列表接口

- (void)getCustomerListWithUserId:(NSString *)userId
                   customerStatus:(NSString *)customerStatus
                              key:(NSString *)key
                        pageIndex:(NSInteger)pageIndex
                        pageCount:(NSInteger)pageCount
                         sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                        failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!userId || userId.length == 0) {
        errorInfo = @"用户id不能为空";
    }
    if (!customerStatus || customerStatus.length == 0) {
        errorInfo = @"客户状态不能为空";
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
            NSError *error = [[NSError alloc] initWithDomain:@"getCustomerList" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"getCustomerList" forKey:@"Op"];
    [params setObject:userId forKey:@"userId"];
    [params setObject:customerStatus forKey:@"customerStatus"];
    if (key && key.length) {
        [params setObject:key forKey:@"key"];
    }
    [params setObject:[NSString stringWithFormat:@"%d",(int)pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSString stringWithFormat:@"%d",(int)pageCount] forKey:@"pageCount"];
//    [params setObject:[JZGUserDataModel currentLoginUser].UserID forKey:@"userID"];
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/Customer/ToDoList.ashx",HOME_URL];
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

- (void)cancelGetCustomerList{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}






#pragma mark - 6.获取此客户的跟进记录列表

- (void)getFollowUpListWithCustomerID:(NSString *)customerID
                               userID:(NSString *)userID
                             sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                            failBlock:(JZGNetworkRequestFailureBlock)failBlock;{
    
    NSString *errorInfo = nil;
    if (!customerID || customerID.length == 0) {
        errorInfo = @"客户ID不能为空";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"getFollowUpList" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:customerID forKey:@"customerID"];
    [params setObject:userID forKey:@"userID"];
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/followup/GetFollowUpList.ashx",HOME_URL];
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

- (void)cancelGetFollowUpList{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}






#pragma mark - 7.获取此客户的沟通电话轨迹

- (void)getCustomerContactListWithCustomerID:(NSString *)customerID
                                    sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                                   failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!customerID || customerID.length == 0) {
        errorInfo = @"客户ID不能为空";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"getCustomerContactList" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:customerID forKey:@"customerID"];
    
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/followup/GetCustomerContactList.ashx",HOME_URL];
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

- (void)cancelGetCustomerContactList{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}






#pragma mark - 8.获取客户的分配日志记录

- (void)getLogListWithCustomerID:(NSString *)customerID
                        sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                       failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!customerID || customerID.length == 0) {
        errorInfo = @"客户ID不能为空";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"getLogList" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:customerID forKey:@"customerID"];
    
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/followup/GetLogList.ashx",HOME_URL];
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

- (void)cancelGetLogList{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}







#pragma mark - 9.添加跟进记录

- (void)addFollowUpLogWithCustomerID:(NSString *)customerID
                      FollowUpStatus:(NSString *)FollowUpStatus
                     FollowingRecord:(NSString *)FollowingRecord
                         ReturnVisit:(NSString *)ReturnVisit
                     ReturnVisitDate:(NSString *)ReturnVisitDate
                     ReturnVisitTime:(NSString *)ReturnVisitTime
                  SpecialInstruction:(NSString *)SpecialInstruction
                       FaliureReason:(NSString *)FaliureReason
                          OnShopDate:(NSString *)OnShopDate
                          OnShopTime:(NSString *)OnShopTime
                          FollowType:(NSString *)FollowType
                          CreateDate:(NSString *)CreateDate
                          CreateUser:(NSString *)CreateUser
                        NextShopDate:(NSString *)NextShopDate
                        NextShopTime:(NSString *)NextShopTime
                        CreateUserID:(NSString *)CreateUserID
                       CustomerLevel:(NSString *)CustomerLevel
                            sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                           failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!customerID || customerID.length == 0) {
        errorInfo = @"客户ID不能为空";
    }
    if (!FollowUpStatus || FollowUpStatus.length == 0) {
        errorInfo = @"FollowUpStatus不能为空";
    }
    if (!FollowingRecord || FollowingRecord.length == 0) {
        errorInfo = @"FollowingRecord不能为空";
    }
    if (!FollowType || FollowType.length == 0) {
        errorInfo = @"FollowType不能为空";
    }
    if (!CreateUser || CreateUser.length == 0) {
        errorInfo = @"CreateUser不能为空";
    }
    if (!CreateUserID || CreateUserID.length == 0) {
        errorInfo = @"CreateUserID不能为空";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"addFollowUpLog" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:customerID forKey:@"customerID"];
    [params setObject:FollowUpStatus forKey:@"FollowUpStatus"];
    [params setObject:FollowingRecord forKey:@"FollowingRecord"];
    if (ReturnVisit) {
        [params setObject:ReturnVisit forKey:@"ReturnVisit"];
    }
    if (ReturnVisitDate) {
        [params setObject:ReturnVisitDate forKey:@"ReturnVisitDate"];
    }
    if (ReturnVisitTime) {
        [params setObject:ReturnVisitTime forKey:@"ReturnVisitTime"];
    }
    if (SpecialInstruction) {
        [params setObject:SpecialInstruction forKey:@"SpecialInstruction"];
    }
    if (FaliureReason) {
        [params setObject:FaliureReason forKey:@"FaliureReason"];
    }
    if (OnShopDate) {
        [params setObject:OnShopDate forKey:@"OnShopDate"];
    }
    if (OnShopTime) {
        [params setObject:OnShopTime forKey:@"OnShopTime"];
    }
    [params setObject:FollowType forKey:@"FollowType"];
    if (CreateDate) {
        [params setObject:CreateDate forKey:@"CreateDate"];
    }
    [params setObject:CreateUser forKey:@"CreateUser"];
    if (NextShopDate) {
        [params setObject:NextShopDate forKey:@"NextShopDate"];
    }
    if (NextShopTime) {
        [params setObject:NextShopTime forKey:@"NextShopTime"];
    }
    [params setObject:CreateUserID forKey:@"CreateUserID"];
    if (CustomerLevel) {
        [params setObject:CustomerLevel forKey:@"CustomerLevel"];
    }
    [params setObject:[JZGUserDataModel currentLoginUser].UserID forKey:@"userID"];
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/followup/AddFollowUpLog.ashx",HOME_URL];
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

- (void)cancelAddFollowUpLog{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}







#pragma mark - 10.添加跟进事项，注意看说明

- (void)addFollowUpItemWithCustomerID:(NSString *)customerID
                       FollowUpStatus:(NSString *)FollowUpStatus
                      FollowingRecord:(NSString *)FollowingRecord
                          ReturnVisit:(NSString *)ReturnVisit
                      ReturnVisitDate:(NSString *)ReturnVisitDate
                      ReturnVisitTime:(NSString *)ReturnVisitTime
                   SpecialInstruction:(NSString *)SpecialInstruction
                        FaliureReason:(NSString *)FaliureReason
                           OnShopDate:(NSString *)OnShopDate
                           OnShopTime:(NSString *)OnShopTime
                           FollowType:(NSString *)FollowType
                           CreateDate:(NSString *)CreateDate
                           CreateUser:(NSString *)CreateUser
                         NextShopDate:(NSString *)NextShopDate
                         NextShopTime:(NSString *)NextShopTime
                         CreateUserID:(NSString *)CreateUserID
                             sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                            failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!customerID || customerID.length == 0) {
        errorInfo = @"客户ID不能为空";
    }
    if (!FollowType || FollowType.length == 0) {
        errorInfo = @"FollowType不能为空";
    }
    if (!CreateUser || CreateUser.length == 0) {
        errorInfo = @"CreateUser不能为空";
    }
    if (!CreateUserID || CreateUserID.length == 0) {
        errorInfo = @"CreateUserID不能为空";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"addFollowUpItem" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }

    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:customerID forKey:@"customerID"];
    if (FollowUpStatus) {
        [params setObject:FollowUpStatus forKey:@"FollowUpStatus"];
    }
    if (ReturnVisit) {
        [params setObject:ReturnVisit forKey:@"ReturnVisit"];
    }
    if (FollowingRecord) {
        [params setObject:FollowingRecord forKey:@"FollowingRecord"];
    }
    if (ReturnVisitDate) {
        [params setObject:ReturnVisitDate forKey:@"ReturnVisitDate"];
    }
    if (ReturnVisitTime) {
        [params setObject:ReturnVisitTime forKey:@"ReturnVisitTime"];
    }
    if (SpecialInstruction) {
        [params setObject:SpecialInstruction forKey:@"SpecialInstruction"];
    }
    if (FaliureReason) {
        [params setObject:FaliureReason forKey:@"FaliureReason"];
    }
    if (OnShopDate) {
        [params setObject:OnShopDate forKey:@"OnShopDate"];
    }
    if (OnShopTime) {
        [params setObject:OnShopTime forKey:@"OnShopTime"];
    }
    [params setObject:FollowType forKey:@"FollowType"];
    if (CreateDate) {
        [params setObject:CreateDate forKey:@"CreateDate"];
    }
    [params setObject:CreateUser forKey:@"CreateUser"];
    if (NextShopDate) {
        [params setObject:NextShopDate forKey:@"NextShopDate"];
    }
    if (NextShopTime) {
        [params setObject:NextShopTime forKey:@"NextShopTime"];
    }
    [params setObject:CreateUserID forKey:@"CreateUserID"];
    
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/followup/AddFollowUpLog.ashx",HOME_URL];
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

- (void)cancelAddFollowUpItem{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}







#pragma mark - 11.车辆的关注客户列表

- (void)getCarConcernUserListWithIntendCarName:(NSString *)IntendCarName
                                       salesId:(NSString *)salesId
                                     pageIndex:(NSInteger)pageIndex
                                      pageSize:(NSInteger)pageSize
                                   intendCarId:(NSString *)intendCarId
                                      sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                                     failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!IntendCarName || IntendCarName.length == 0) {
        errorInfo = @"IntendCarName不能为空";
    }
    if (!salesId || salesId.length == 0) {
        errorInfo = @"用户ID不能为空";
    }
    if (pageIndex < 0) {
        errorInfo = @"pageIndex参数不对";
    }
    if (pageSize < 0) {
        errorInfo = @"pageSize参数不对";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"getCarConcernUserList" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:@"getCarConcernUserList" forKey:@"Op"];
    [params setObject:IntendCarName forKey:@"IntendCarName"];
    [params setObject:salesId forKey:@"salesId"];
    [params setObject:[NSString stringWithFormat:@"%ld",pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSString stringWithFormat:@"%ld",pageSize] forKey:@"pageSize"];
    [params setObject:intendCarId forKey:@"intendCarId"];
    
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/followup/GetCarConcernUserList.ashx",HOME_URL];
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

- (void)cancelGetCarConcernUserList{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}

#pragma mark - 12.获取跟进事项

- (void)getFollowUpItemListWithCustomerID:(NSString *)customerID
                                   userID:(NSString *)userID
                                 sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                                failBlock:(JZGNetworkRequestFailureBlock)failBlock{
    
    NSString *errorInfo = nil;
    if (!customerID || customerID.length == 0) {
        errorInfo = @"customerID不能为空";
    }
    
    if (errorInfo) {
        if (failBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorInfo forKey:PL_ERROR_INFO_KEY];
            NSError *error = [[NSError alloc] initWithDomain:@"getFollowUpItemList" code:RESULT_API_PARAMS_EMPTY userInfo:userInfo];
            failBlock (error);
        }
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:customerID forKey:@"customerID"];
    [params setObject:userID forKey:@"userID"];
    WS(weakSelf);
    NSString *urlString = [NSString stringWithFormat:@"%@/followup/GetFollowUpItemList.ashx",HOME_URL];
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

- (void)cancelGetFollowUpItemList{
    [[JZGNetWorkRequest sharedNetworkRequest] cancelNetworkRequest];
}

@end
