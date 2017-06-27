//
//  JZGSPCreatePingGuDanService.h
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/28.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZGSPCreatePingGuDanService : JZGBaseService

//+ (instancetype)share;

- (void)createPingGuDanService:(NSDictionary *)paramats
                      sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                     failBlock:(JZGNetworkRequestFailureBlock)failBlock;



@end
