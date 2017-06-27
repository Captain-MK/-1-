//
//  JZGUserDataModel.h
//  JZGChryslerForPad
//
//  Created by cuik on 16/4/15.
//  Copyright © 2016年 Beijing JingZhenGu Information Technology Co.Ltd. All rights reserved.
//

#import "JZGBaseDataModel.h"

@interface JZGUserDataModel : JZGBaseDataModel

/**
 *  用户ID
 */
@property (nonatomic,copy)NSString *UserID;

/**
 *  ???
 */
@property (nonatomic,copy)NSString *OrganizationID;

/**
 *  用户名
 */
@property (nonatomic,copy)NSString *UserName;

/**
 *  密码
 */
@property (nonatomic,copy)NSString *UserPass;

/**
 *  真实姓名
 */
@property (nonatomic,copy)NSString *TrueName;

/**
 *  性别
 */
@property (nonatomic,copy)NSString *Gender;

/**
 *  电话
 */
@property (nonatomic,copy)NSString *Tel;

/**
 *  状态
 */
@property (nonatomic,copy)NSString *Status;

/**
 *  创建时间
 */
@property (nonatomic,copy)NSString *CreateTime;

/**
 *  店铺id
 */
@property (nonatomic,copy)NSString *StoreId;

/**
 *  ???
 */
@property (nonatomic,copy)NSString *DepartMentId;

/**
 *  ???
 */
@property (nonatomic,copy)NSString *DutyId;

/**
 *  头像url
 */
@property (nonatomic,copy)NSString *HeadImageUrl;

/**
 *  ???
 */
@property (nonatomic,copy)NSString *DepName;

/**
 *  ???
 */
@property (nonatomic,copy)NSString *DutyName;

/**
 *  公司id
 */
@property (nonatomic,copy)NSString *GroupID;



@property (nonatomic, copy)NSString *UserType;

/**   登录后的令牌 */
@property (copy, nonatomic)         NSString *token;
@property (nonatomic,copy) NSString *CityId;
/**   店铺名 */
@property (nonatomic,copy) NSString *StoreName;
/** 是否为评估师经理  1是评估师经理  0不是*/
@property (nonatomic,copy) NSString *isPgManage;
#pragma mark - 方法

/**
 *  当前用户
 */
+ (JZGUserDataModel *)currentLoginUser;

/**
 *  更新数据
 */
- (BOOL)updateDataWithDic:(NSDictionary *)dic;

/**
 *  保存到本地
 */
- (BOOL)saveToLocal;

/**
 *  删除保存在本地的已登录用户
 */
+ (BOOL)deleteCurrentUserFromLocal;

/**
 *  用户是否登录
 */
+ (BOOL)isLogin;

@end
