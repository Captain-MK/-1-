//
//  JZGNetSearchManager.h
//  JZGERSecondPhase
//
//  Created by 杜维欣 on 16/9/28.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZGNetSearchManager : NSObject

+ (instancetype)manager;

/**
 *  根据关键字进行搜索
 *
 *  @param url             搜索的url
 *  @param parameter       参数
 *  @param searchText      关键字
 *  @param identifier      搜索的唯一标示(以便根据这个表示进行取消)
 *  @param completeHandler 完成
 *  @param errorHandler    失败(取消搜索 errorCode = 999)
 */
- (void)searchWithUrl:(NSString *)url parameters:(NSDictionary *)parameter searchText:(NSString *)searchText identifier:(NSString *)identifier completeHandler:(void (^) (id sucessData))completeHandler errorHandler:(void (^) (NSError *error))errorHandler;

/**
 *  取消搜索
 *
 *  @param searchText 搜索的关键字
 *  @param identifier 搜索的唯一标示
 */
- (void)cancleWithSearchText:(NSString *)searchText identifier:(NSString *)identifier;

@end
