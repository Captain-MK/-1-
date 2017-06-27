//
//  JZGSPCreatePingGudanService.h
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/26.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZGSPCreatePingGudanService : JZGBaseService

- (void)createPingGudanService:(NSDictionary *)dic
                      sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                     failBlock:(JZGNetworkRequestFailureBlock)failBlock;
@end
