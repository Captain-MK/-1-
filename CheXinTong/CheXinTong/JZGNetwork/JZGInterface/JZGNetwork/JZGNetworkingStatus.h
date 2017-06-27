//
//  JZGNetworkingStatus.h
//  JZGChryslerForPad
//
//  Created by jzg on 16/6/2.
//  Copyright © 2016年 Beijing JingZhenGu Information Technology Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"

@interface JZGNetworkingStatus : NSObject

/**
 *  获取当前的网络状态 该变量有四个type
    AFNetworkReachabilityStatusUnknown: // 未知网络
    AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
    AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
    AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
 */

@property(nonatomic, assign)AFNetworkReachabilityStatus currentNetStatus;

/**
 *  类单利函数
 *
 *  @return <#return value description#>
 */
+ (JZGNetworkingStatus *)sharedNetworkingStatus;

/**
 *  获取当前网络的状态，主要是看是否有网络。
 *
 *  @return 返回值 YES 说明当前网络可用， NO 说明当前网络不可用
 */
- (BOOL)netWorkingStatus;

/**
 *  启动网络状态监测的接口函数
 */
- (void)startMonitoring;

@end
