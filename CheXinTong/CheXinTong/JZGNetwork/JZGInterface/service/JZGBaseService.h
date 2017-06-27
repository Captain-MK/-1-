//
//  JZGBaseService.h
//  JZGDetectionPlatform
//
//  Created by cuik on 16/4/5.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZGNetwork.h"

#define PL_ERROR_INFO_KEY   @"errorInfo"
#define PL_ERROR_CODE       @"errorCode"

@interface JZGBaseService : NSObject

/**
 *  单例
 */
+ (instancetype)share;


/**
 *  ERP请求数据成功的处理
 *
 *  @param reqData   请求回来的数据
 *  @param sucBlock  如果一切正常则会执行该block
 *  @param failBlock 出现其它错误时执行(例如:请求虽然成功,但出现必填参数为空)
 */
- (void)handleRequestSuccess:(NSDictionary *)dictionary
                    sucBlock:(JZGNetworkRequestSuccessBlock)sucBlock
                   failBlock:(JZGNetworkRequestFailureBlock)failBlock;

/**
 *  请求数据失败后的处理
 *
 *  @param error     请求失败后返回DDError对象
 */
- (void)handleRequestFailed:(NSError *)error
                  failBlock:(JZGNetworkRequestFailureBlock)failBlock;

@end
