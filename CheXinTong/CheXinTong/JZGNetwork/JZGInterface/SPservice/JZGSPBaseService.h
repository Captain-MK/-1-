//
//  JZGSPBaseService.h
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/22.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZGSPBaseService : JZGBaseService

//+ (instancetype)share;

- (void)getBaseService:(NSDictionary *)paramats
              sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
             failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消用户登录
 */
- (void)cancelBaseService;

@end
