//
//  JZGNetworkingStatus.m
//  JZGChryslerForPad
//
//  Created by jzg on 16/6/2.
//  Copyright © 2016年 Beijing JingZhenGu Information Technology Co.Ltd. All rights reserved.
//

#import "JZGNetworkingStatus.h"

@implementation JZGNetworkingStatus

+ (JZGNetworkingStatus *)sharedNetworkingStatus{
    static JZGNetworkingStatus *status = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (!status) {
            status = [[self alloc] init];
        }
    });
    return status;
}

#pragma makr - 开始监听网络连接
- (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        self.currentNetStatus = status;
    }];
    
    [mgr startMonitoring];
}

- (BOOL)netWorkingStatus{
    BOOL    status;
    switch (self.currentNetStatus) {
        case AFNetworkReachabilityStatusUnknown: // 未知网络
            break;
        case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
            status = NO;
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
            status = YES;
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
            status = YES;
            break;
    }
    return status;
}


@end
