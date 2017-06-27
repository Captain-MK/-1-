//
//  JZGBackLogService.h
//  JZGERP
//
//  Created by cuik on 16/6/28.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGBaseService.h"

/**
 *  代办相关接口Service
 */

@interface JZGBackLogService : JZGBaseService





#pragma mark - 1.获取待办事项
/**
 *  获取待办事项
 *
 *  @param type             JZGWaitDoneItemsType（必传）
 *  @param SalesId          ID（必传） eg: SalesId=56
 *  @param pageIndex        当前页标（必传）
 *  @param pageSize         每页记录条数（必传）
 */
- (void)getWaitDoneItemsWithType:(JZGWaitDoneItemsType)type
                         SalesId:(NSString *)SalesId
                       pageIndex:(NSInteger)pageIndex
                        pageSize:(NSInteger)pageSize
                        sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                       failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消获取待办事项
 */
- (void)cancelGetWaitDoneItems;








#pragma mark - 2.修改待办事项的已读状态
/**
 *  修改待办事项的已读状态
 *
 *  @param FollowupId          跟进事项ID（必传） eg: FollowupId=56
 */
- (void)changReadWithFollowupId:(NSString *)FollowupId
                       sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                      failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消修改待办事项的已读状态
 */
- (void)cancelChangRead;








#pragma mark - 3.获取今天和全部代办事项的总数量
/**
 *  获取今天和全部代办事项的总数量
 *
 *  @param SalesId          ID（必传） eg: SalesId=56
 */
- (void)getSumWithSalesId:(NSString *)SalesId
                 sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消获取今天和全部代办事项的总数量
 */
- (void)cancelGetSum;

@end
