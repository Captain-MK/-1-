//
//  JZGSystemService.h
//  JZGChryslerForPad
//
//  Created by cuik on 16/6/4.
//  Copyright © 2016年 Beijing JingZhenGu Information Technology Co.Ltd. All rights reserved.
//

#import "JZGBaseService.h"

@interface JZGSystemService : JZGBaseService




#pragma mark - 1.版本检测
/**
 *  版本检测
 *
 */
- (void)appVersionCheckWithSucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                          failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消版本检测
 */
- (void)cancelAppVersionCheck;

@end
