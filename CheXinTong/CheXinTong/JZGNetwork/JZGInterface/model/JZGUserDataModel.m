//
//  JZGUserDataModel.m
//  JZGChryslerForPad
//
//  Created by cuik on 16/4/15.
//  Copyright © 2016年 Beijing JingZhenGu Information Technology Co.Ltd. All rights reserved.
//

#import "JZGUserDataModel.h"

@implementation JZGUserDataModel

+ (JZGUserDataModel *)currentLoginUser{
    static dispatch_once_t t;
    static JZGUserDataModel *service = nil;
    dispatch_once(&t, ^{
        service = [JZGUserDataModel getFromLocal];
        if (!service) {
            service = [[JZGUserDataModel alloc] init];
        }
    });
    return service;
}

- (BOOL)updateDataWithDic:(NSDictionary *)dic{
    NSString *UserID = [self filterWithString:[dic objectForKey:@"UserID"]];
    if (UserID && UserID.length) {
        self.UserID = UserID;
    }
    
    NSString *OrganizationID = [self filterWithString:[dic objectForKey:@"OrganizationID"]];
    if (OrganizationID && OrganizationID.length) {
        self.OrganizationID = OrganizationID;
    }
    
    NSString *UserName = [self filterWithString:[dic objectForKey:@"UserName"]];
    if (UserName && UserName.length) {
        self.UserName = UserName;
    }
    
    NSString *UserPass = [self filterWithString:[dic objectForKey:@"UserPass"]];
    if (UserPass && UserPass.length) {
        self.UserPass = UserPass;
    }
    
    NSString *TrueName = [self filterWithString:[dic objectForKey:@"TrueName"]];
    if (TrueName && TrueName.length) {
        self.TrueName = TrueName;
    }
    
    NSString *Gender = [self filterWithString:[dic objectForKey:@"Gender"]];
    if (Gender && Gender.length) {
        self.Gender = Gender;
    }
    
    NSString *Tel = [self filterWithString:[dic objectForKey:@"Tel"]];
    if (Tel && Tel.length) {
        self.Tel = Tel;
    }
    
    NSString *Status = [self filterWithString:[dic objectForKey:@"Status"]];
    if (Status && Status.length) {
        self.Status = Status;
    }
    
    NSString *CreateTime = [self filterWithString:[dic objectForKey:@"CreateTime"]];
    if (CreateTime && CreateTime.length) {
        self.CreateTime = CreateTime;
    }
    
    NSString *StoreId = [self filterWithString:[dic objectForKey:@"StoreId"]];
    if (StoreId && StoreId.length) {
        self.StoreId = StoreId;
    }
    
    NSString *DepartMentId = [self filterWithString:[dic objectForKey:@"DepartMentId"]];
    if (DepartMentId && DepartMentId.length) {
        self.DepartMentId = DepartMentId;
    }
    
    NSString *DutyId = [self filterWithString:[dic objectForKey:@"DutyId"]];
    if (DutyId && DutyId.length) {
        self.DutyId = DutyId;
    }
    
    NSString *HeadImageUrl = [self filterWithString:[dic objectForKey:@"HeadImageUrl"]];
    if (HeadImageUrl && HeadImageUrl.length) {
        self.HeadImageUrl = HeadImageUrl;
    }
    
    NSString *DepName = [self filterWithString:[dic objectForKey:@"DepName"]];
    if (DepName && DepName.length) {
        self.DepName = DepName;
    }
    
    NSString *DutyName = [self filterWithString:[dic objectForKey:@"DutyName"]];
    if (DutyName && DutyName.length) {
        self.DutyName = DutyName;
    }
    
    NSString *GroupID = [self filterWithString:[dic objectForKey:@"GroupID"]];
    if (GroupID && GroupID.length) {
        self.GroupID = GroupID;
    }
    self.UserType = dic[@"UserType"]?dic[@"UserType"]:@"";
    self.token = @"erp@$app!#$%";
    NSString *CityID = [self filterWithString:[dic objectForKey:@"CityID"]];
    if (CityID && CityID.length) {
        self.CityId = CityID;
    }
    NSString *StoreName = [self filterWithString:[dic objectForKey:@"StoreName"]];
    if (StoreName && StoreName.length) {
        self.StoreName = StoreName;
    }
    
    NSString *isPgManage = [self filterWithString:[dic objectForKey:@"IsPgManage"]];
    if (isPgManage && isPgManage.length) {
        self.isPgManage = isPgManage;
    }
    
    [self saveToLocal];
    return YES;
}

- (BOOL)saveToLocal{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"currentUser.dat"];
    BOOL isSuccess = [NSKeyedArchiver archiveRootObject:self toFile:filePath];
    return isSuccess;
}

+ (JZGUserDataModel *)getFromLocal{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"currentUser.dat"];
    JZGUserDataModel *aUser = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return aUser;
}

+ (BOOL)deleteCurrentUserFromLocal{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"currentUser.dat"];
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

+ (BOOL)isLogin{
    JZGUserDataModel *currentUser = [JZGUserDataModel currentLoginUser];
    
    if (![currentUser.UserID isEqualToString:@""] && currentUser.UserID && currentUser.UserID.length != 0) {
        return YES;
    }
    return NO;
}


@end
