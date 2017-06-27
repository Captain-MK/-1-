//
//  JZGCarSourceService.h
//  JZGERP
//
//  Created by cuik on 16/6/28.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGBaseService.h"

/**
 *  车源相关接口Service
 */
@interface JZGCarSourceService : JZGBaseService


#pragma mark - 1.获取用户已关注的车辆列表
/**
 *  获取用户已关注的车辆列表
 *
 *  @param customerId  客户ID （必传）
 *  @param pageIndex   当前页数（必传）
 *  @param pageCount   每页显示的记录条数（必传）
 */
- (void)focusCarListWithCustomerId:(NSString *)customerId
                         pageIndex:(NSInteger)pageIndex
                         pageCount:(NSInteger)pageCount
                          sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                         failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消获取用户已关注的车辆列表
 */
- (void)cancelFocusCarList;






#pragma mark - 2.根据查询条件获取未关注车辆信息列表
/**
 *  根据查询条件获取未关注车辆信息列表
 *
 *  @param customerId  客户ID（必传）
 *  @param condition   模糊查询的条件
 *  @param pageIndex   当前页数（必传）
 *  @param pageCount   每页显示的记录条数（必传）
 */
- (void)focusCarLsitByConditionWithCustomerId:(NSString *)customerId
                                    condition:(NSString *)condition
                                    pageIndex:(NSInteger)pageIndex
                                    pageCount:(NSInteger)pageCount
                                     sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                                    failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消根据查询条件获取未关注车辆信息列表
 */
- (void)cancelFocusCarLsitByCondition;






#pragma mark - 3.添加用户未关注的车辆
/**
 *  添加用户未关注的车辆
 *
 *  @param customerId       客户ID（必传）
 *  @param carsourceIdArr   捷通达一期车源ID ，多个车用 下划线 分隔 ，例如 234_67
 *  @param carIdArr         捷通达二期车源ID ，多个车用 下划线 分隔 ，例如 3_9
 */
- (void)insertFocusCarWithCustomerId:(NSString *)customerId
                      carsourceIdArr:(NSString *)carsourceIdArr
                            carIdArr:(NSString *)carIdArr
                            sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                           failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消添加用户未关注的车辆
 */
- (void)cancelInsertFocusCar;







#pragma mark - 4.获取车源信息列表
/**
 *  获取车源信息列表
 *
 *  @param makeName    品牌名字
 *  @param carStatus   车辆状态(0,1,2,3)
 *  @param Sort        排序方式(0,1,2,3,4)
 *  @param condition   模糊查询条件
 *  @param pageIndex   当前页标（必传）
 *  @param pageCount   每页记录条数（必传）
 */
- (void)getCarListWithMakeName:(NSString *)makeName
                        makeID:(NSString *)makeID
                       modelID:(NSString *)modelID
                     carStatus:(NSString *)carStatus
                          Sort:(NSString *)Sort
                     condition:(NSString *)condition
                     pageIndex:(NSInteger)pageIndex
                     pageCount:(NSInteger)pageCount
                      sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                     failBlock:(JZGNetworkRequestFailureBlock)failBlock;
//- (void)getCarListWithMakeName:(NSString *)makeName
//                     carStatus:(NSString *)carStatus
//                          Sort:(NSString *)Sort
//                     condition:(NSString *)condition
//                     pageIndex:(NSInteger)pageIndex
//                     pageCount:(NSInteger)pageCount
//                      sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
//                     failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消获取车源信息列表
 */
- (void)cancelGetCarList;






#pragma mark - 5.获取车辆的意向用户列表
/**
 *  获取车辆的意向用户列表
 *
 *  @param userId      用户id（必传）
 *  @param carSourceID 车源id（必传）
 *  @param pageIndex   当前页标（必传）
 *  @param pageCount   每页记录条数（必传）
 */
- (void)getIntendCustomerListWithuserId:(NSString *)userId
                            carSourceID:(NSString *)carSourceID
                              pageIndex:(NSInteger)pageIndex
                              pageCount:(NSInteger)pageCount
                               sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                              failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消获取车辆的意向用户列表
 */
- (void)cancelGetIntendCustomerList;






#pragma mark - 6.批量添加关注此车辆的客户
/**
 *  批量添加关注此车辆的客户
 *
 *  @param customerIdList    客户id串 中间用 下划线 分隔 例 3443_233232（必传）
 *  @param carsourceId       捷通达一期车源ID
 *  @param carId             捷通达二期车源ID
 */
- (void)batchInsertFocusCarCustomerWithCustomerIdList:(NSString *)customerIdList
                                          carsourceId:(NSString *)carsourceId
                                                carId:(NSString *)carId
                                             sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                                            failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消批量添加关注此车辆的客户
 */
- (void)cancelBatchInsertFocusCarCustomer;


@end
