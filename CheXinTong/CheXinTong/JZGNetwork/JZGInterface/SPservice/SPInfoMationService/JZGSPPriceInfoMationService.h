//
//  JZGSPPriceInfoMationService.h
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/26.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZGSPPriceInfoMationService : JZGBaseService

/**
 *  获取基本信息
 *
 *  @param styleid      styleid description
 *  @param cityId       cityId description
 *  @param provinceid   provinceid description
 *  @param mileage      mileage description
 *  @param registerDate registerDate description
 *  @param sucBlock     sucBlock description
 *  @param failBlock    failBlock description
 */
- (void)getCarPriceServicestyleId:(NSString *)styleid
                         cityName:(NSString *)cityName
                           cityId:(NSString *)cityId
                       provinceid:(NSString *)provinceid
                          mileage:(NSString *)mileage
                     registerDate:(NSString *)registerDate
                         sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                        failBlock:(JZGNetworkRequestFailureBlock)failBlock;
/**
 *  交易记录
 *
 *  @param styleid      styleid description
 *  @param cityId       cityId description
 *  @param provinceid   provinceid description
 *  @param mileage      mileage description
 *  @param registerDate registerDate description
 *  @param sucBlock     sucBlock description
 *  @param failBlock    failBlock description
 */
- (void)getHistoryRecordtyleId:(NSString *)styleid
                      cityName:(NSString *)cityName
                        cityId:(NSString *)cityId
                    provinceid:(NSString *)provinceid
                       mileage:(NSString *)mileage
                  registerDate:(NSString *)registerDate
                      sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                     failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消修改用户头像
 */
- (void)cancelModifyIcon;

/**
 *  网络在售
 *
 *  @param styleid    styleid description
 *  @param cityId     cityId description
 *  @param provinceid provinceid description
 *  @param sucBlock   sucBlock description
 *  @param failBlock  failBlock description
 */
- (void)getWangLuoRecordtyleId:(NSString *)styleid
                      cityName:(NSString *)cityName
                        cityId:(NSString *)cityId
                      sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                     failBlock:(JZGNetworkRequestFailureBlock)failBlock;


/**
 *  获取车辆成交历史记录 （价格信息 - 历史记录 - 同车系收购 / 销售记录）。
 *
 *  @param modelId   modelId description
 *  @param sucBlock  sucBlock description
 *  @param failBlock failBlock description
 */
- (void)getTongCheXiXiaoShouJiLumodelId:(NSString *)modelId
                               cityName:(NSString *)cityName
                               sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                              failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  该车评估记录接口
 *
 *  @param carId     carId description
 *  @param sucBlock  sucBlock description
 *  @param failBlock failBlock description
 */
- (void)getGaiChePingGuJiLucarId:(NSString *)carId
                        cityName:(NSString *)cityName
                        sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                       failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  获取销售顾问列表
 *
 *  @param storeid   storeid description
 *  @param sucBlock  sucBlock description
 *  @param failBlock failBlock description
 */

- (void)getXiaoShouGuwenListStoreid:(NSString *)storeid
                           sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                          failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  获取评估师列表
 *
 *  @param storeid   storeid description
 *  @param sucBlock  sucBlock description
 *  @param failBlock failBlock description
 */
- (void)getPingGuShiListPingguUserId:(NSString *)pingguUserId
                            sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                           failBlock:(JZGNetworkRequestFailureBlock)failBlock;



@end
