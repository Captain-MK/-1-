//
//  JZGSPGetCityListService.h
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/25.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZGSPGetCityListService : JZGBaseService

- (void)getCityListServiceprovinceId:(NSString *)provinceId
                            sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                           failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消修改用户头像
 */
- (void)cancelModifyIcon;

@end
