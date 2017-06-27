//
//  JZGSPCheLiangJianceService.h
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/25.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZGSPCheLiangJianceService : JZGBaseService

- (void)getCheliangeJiancesucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                         failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消修改用户头像
 */
- (void)cancelModifyIcon;

@end
