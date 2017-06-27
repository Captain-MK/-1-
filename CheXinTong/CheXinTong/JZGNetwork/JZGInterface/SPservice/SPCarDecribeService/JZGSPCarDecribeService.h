//
//  JZGSPCarDecribeService.h
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/23.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZGSPCarDecribeService : JZGBaseService

- (void)getHCarDecribeItemsWithStoreID:(NSString *)storeId
                                   vin:(NSString *)vin
                              sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                             failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消获取待办事项
 */
- (void)cancelCarDecribetDoneItems;

@end
