//
//  JZGCustomerService.h
//  JZGERP
//
//  Created by cuik on 16/6/28.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGBaseService.h"

/**
 *  客户相关接口Service
 */
@interface JZGCustomerService : JZGBaseService


#pragma mark - 1.客户信息详情接口
/**
 *  获取客户信息详情接口
 *
 *  @param customerId          客户ID（必传）
 */
- (void)getCustomerInfoWithCustomerId:(NSString *)customerId
                             sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                            failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消获取客户信息详情
 */
- (void)cancelGetCustomerInfo;





#pragma mark - 2.修改购车意向接口
/**
 *  修改购车意向接口
 *
 *  @param intendCarMakeModelID   意向车型的 makeID_modelID , 多个的话用 逗号 隔开 。例如 2_2355,4_878
 *  @param intendCar              意向车型
 *  @param transmission           变速类型（必传）
 *  @param intendMoney            预算（非必传）
 *  @param remark                 意向备注（非必传）
 *  @param customerID             客户id（必传）
 */
- (void)updateIntendBuyCarWithIntendCarMakeModelID:(NSString *)intendCarMakeModelID
                                         intendCar:(NSString *)intendCar
                                      transmission:(NSString *)transmission
                                       intendMoney:(NSString *)intendMoney
                                            remark:(NSString *)remark
                                        customerID:(NSString *)customerID
                                          sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                                         failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消修改购车意向
 */
- (void)cancelUpdateIntendBuyCar;






#pragma mark - 3.插入电话记录接口
/**
 *  插入电话记录接口
 *
 *  @param CustomerID      客户Id（必传）
 *  @param CustomerName    客户名称
 *  @param SalesId         当前用户Id（必传）
 *  @param SalesName       当前用户名称
 *  @param TalkingTime     通话时长(默认传0)
 */
- (void)insertContractRecordWithCustomerID:(NSString *)CustomerID
                              CustomerName:(NSString *)CustomerName
                                   SalesId:(NSString *)SalesId
                                 SalesName:(NSString *)SalesName
                               TalkingTime:(NSString *)TalkingTime
                                  sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                                 failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消插入电话记录
 */
- (void)cancelInsertContractRecord;






#pragma mark - 4.匹配车源接口
/**
 *  匹配车源接口
 *
 *  @param intendCar      意向车型的 makeID_modelID , 多个的话用 逗号 隔开 。例如 2_2355,4_878
 *  @param makeName       品牌名称
 *  @param carStatus      状态
 *  @param sort           排序类型
 */
- (void)matchUserIntendCarWithIntendCar:(NSString *)intendCar
                               makeName:(NSString *)makeName
                              carStatus:(NSString *)carStatus
                                   sort:(NSString *)sort
                               sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                              failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消匹配车源
 */
- (void)cancelMatchUserIntendCar;






#pragma mark - 5.获取客户列表
/**
 *  获取客户列表
 *
 *  @param userID          用户id（必传）
 *  @param customerStatus  客户状态 ({1,"意向客户" },{2,"预订客户" },{3,"成交客户" },{4,"战败客户" }（必传）
 *  @param key         联系人, 手机号码,客户名称(模糊查询条件的参数)
 *  @param pageIndex       当前页标（必传）
 *  @param pageCount       每页记录条数（必传）
 */
- (void)getCustomerListWithUserId:(NSString *)userId
                   customerStatus:(NSString *)customerStatus
                              key:(NSString *)key
                        pageIndex:(NSInteger)pageIndex
                        pageCount:(NSInteger)pageCount
                         sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                        failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消获取客户列表
 */
- (void)cancelGetCustomerList;






#pragma mark - 6.获取此客户的跟进记录列表
/**
 *  获取此客户的跟进记录列表
 *
 *  @param customerID          客户ID（必传） eg: customerID=37
 */
- (void)getFollowUpListWithCustomerID:(NSString *)customerID
                             userID:(NSString *)userID
                             sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                            failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消获取此客户的跟进记录列表
 */
- (void)cancelGetFollowUpList;






#pragma mark - 7.获取此客户的沟通电话轨迹
/**
 *  获取此客户的沟通电话轨迹
 *
 *  @param customerID          客户ID（必传） eg: customerID=1
 */
- (void)getCustomerContactListWithCustomerID:(NSString *)customerID
                                    sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                                   failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消获取此客户的沟通电话轨迹
 */
- (void)cancelGetCustomerContactList;







#pragma mark - 8.获取客户的分配日志记录
/**
 *  获取客户的分配日志记录
 *
 *  @param customerID          客户ID（必传） eg: customerID=37
 */
- (void)getLogListWithCustomerID:(NSString *)customerID
                        sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                       failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消获取客户的分配日志记录
 */
- (void)cancelGetLogList;







#pragma mark - 9.添加跟进记录，注意看说明 （具体参数参看文档）
/**
 *  添加跟进记录
 *
 *  @param customerID          客户ID（必传） eg: customerID=1
 *  @param FollowUpStatus      传：继续跟进（必传）
 *  @param FollowingRecord     传：跟进记录（必传）
 *  @param ReturnVisit         1回访;2不回访            没有传@“”
 *  @param ReturnVisitDate     传该格式时间：1900-01-01  没有传@“”
 *  @param ReturnVisitTime     传：上午                 没有传@“”
 *  @param SpecialInstruction  说明                    没有传@“”
 *  @param FaliureReason       失败原因                 没有传@“”
 *  @param OnShopDate          传该格式时间：1900-01-01  没有传@“”
 *  @param OnShopTime          传：下午                 没有传@“”
 *  @param FollowType          1.跟进;2.回访;3.日志（必传）
 *  @param CreateDate          传该格式时间：1900-01-01  没有传@“”
 *  @param CreateUser          登陆的用户名（必传）
 *  @param NextShopDate        传该格式时间：1900-01-01  没有传@“”
 *  @param NextShopTime        传：上午                 没有传@“”
 *  @param CreateUserID        登陆的用户id（必传）
 *  @param CustomerLevel       预购时间（必传） 相当于显示的时候prebuytime字段
 */
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
                           failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消添加跟进记录
 */
- (void)cancelAddFollowUpLog;







#pragma mark - 10.添加跟进事项，注意看说明
/**
 *  添加跟进记录
 *
 *  @param customerID          客户ID（必传） eg: customerID=1
 *  @param FollowUpStatus      传：继续跟进（必传）
 *  @param FollowingRecord     传：跟进记录（必传）
 *  @param ReturnVisit         1回访;2不回访            没有传@“”
 *  @param ReturnVisitDate     传该格式时间：1900-01-01  没有传@“”
 *  @param ReturnVisitTime     传：上午                 没有传@“”
 *  @param SpecialInstruction  说明                    没有传@“”
 *  @param FaliureReason       失败原因                 没有传@“”
 *  @param OnShopDate          传该格式时间：1900-01-01  没有传@“”
 *  @param OnShopTime          传：下午                 没有传@“”
 *  @param FollowType          1.跟进;2.回访;3.日志（必传）
 *  @param CreateDate          传该格式时间：1900-01-01  没有传@“”
 *  @param CreateUser          登陆的用户名（必传）
 *  @param NextShopDate        传该格式时间：1900-01-01  没有传@“”
 *  @param NextShopTime        传：上午                 没有传@“”
 *  @param CreateUserID        登陆的用户id（必传）
 */
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
                            failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消添加跟进事项
 */
- (void)cancelAddFollowUpItem;







#pragma mark - 11.车辆的关注客户列表
/**
 *  车辆的关注客户列表接口
 *
 *  @param IntendCarName   为表CarBaseInfo.MakeName+空格+表CarBaseInfo.ModelName（必传）
 *  @param salesId         用户id（必传）
 *  @param pageIndex       当前页标（必传）
 *  @param pageCount       每页记录条数（必传）
 */
- (void)getCarConcernUserListWithIntendCarName:(NSString *)IntendCarName
                                       salesId:(NSString *)salesId
                                     pageIndex:(NSInteger)pageIndex
                                      pageSize:(NSInteger)pageSize
                                   intendCarId:(NSString *)intendCarId
                                      sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                                     failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消车辆的关注客户列表接口
 */
- (void)cancelGetCarConcernUserList;







#pragma mark - 12.获取跟进事项
/**
 *  获取跟进事项
 *
 *  @param customerID          用户ID（必传） eg: customerID=174
 */
- (void)getFollowUpItemListWithCustomerID:(NSString *)customerID
                                   userID:(NSString *)userID
                                 sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                                failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消获取跟进事项
 */
- (void)cancelGetFollowUpItemList;




@end
