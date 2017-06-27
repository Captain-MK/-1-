//
//  JZGSPUploadImageService.h
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/23.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZGSPUploadImageService : JZGBaseService

- (void)uplodImageIconWithCarId:(NSString *)carId
                         images:(NSArray *)images
                       sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                      failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  取消修改用户头像
 */
- (void)cancelModifyIcon;

@end
