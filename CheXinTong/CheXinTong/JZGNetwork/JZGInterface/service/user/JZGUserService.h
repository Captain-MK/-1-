//
//  JZGUserService.h
//  JZGDetectionPlatform
//
//  Created by cuik on 16/4/5.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import "JZGBaseService.h"
#import "JZGUserDataModel.h"

/**
 *  用户相关接口Service
 */
@interface JZGUserService : JZGBaseService

/**
 *  是否登录
 *
 *  @return 已登录:YES, 未登录或登录已过期:NO
 */
+ (BOOL)isLogin;




#pragma mark - 1.用户登录
/**
 *  用户登录
 *
 *  @param userName  用户名（必传）
 *  @param password  密码（必传）
 */
- (void)loginWithUserName:(NSString *)lgcode
                 password:(NSString *)pwd
                 sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消用户登录
 */
- (void)cancelLogin;





#pragma mark - 2.修改用户密码
/**
 *  修改用户密码
 *
 *  @param userid  用户id（必传）
 *  @param pwd     密码（必传）
 *  @param oldpwd     老密码（必传）
 */
- (void)modifypwdWithUserid:(NSString *)userid
                        pwd:(NSString *)pwd old:(NSString *)oldpwd
                   sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                  failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消修改用户密码
 */
- (void)cancelModifypwd;






#pragma mark - 3.浏览用户信息
/**
 *  浏览用户信息
 *
 *  @param userid  用户id（必传）
 */
- (void)browseAccountinformationWithUserid:(NSString *)userid
                                  sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                                 failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消浏览用户信息
 */
- (void)cancelBrowseAccountinformation;







#pragma mark - 4.修改用户头像
/**
 *  修改用户头像
 *
 *  @param userid  用户id（必传）
 *  @param images  图片集合（必传）
 */
- (void)modifyIconWithUserid:(NSString *)userid
                      images:(NSArray *)images
                    sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                   failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消修改用户头像
 */
- (void)cancelModifyIcon;

@end
