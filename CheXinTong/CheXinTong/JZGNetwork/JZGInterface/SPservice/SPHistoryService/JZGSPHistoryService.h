//
//  JZGSPHistoryService.h
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/23.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZGSPHistoryService : JZGBaseService

- (void)getHistoryStatussucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                       failBlock:(JZGNetworkRequestFailureBlock)failBlock;

- (void)getHistoryItemsWithLicensePlate:(NSString *)LicensePlate
                                SalesId:(NSString *)SalesId
                              pageIndex:(NSInteger)pageIndex
                          RequestStatus:(NSString *)RequestStatus
                        SearchStartDate:(NSString *)SearchStartDate
                          SearchEndDate:(NSString *)SearchEndDate
                               UserName:(NSString *)pingGuShiName
                               sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                              failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消获取待办事项
 */
- (void)cancelHistorytDoneItems;

@end
