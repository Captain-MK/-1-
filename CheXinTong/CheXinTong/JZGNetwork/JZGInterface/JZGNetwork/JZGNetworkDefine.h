//
//  JZGNetworkDefine.h
//  AFN3.0封装
//
//  Created by Mars on 15/12/20.
//  Copyright © 2015年 Mars. All rights reserved.
//

#ifndef JZGNetworkDefine_h
#define JZGNetworkDefine_h

/**
 *  请求类型
 */
typedef NS_ENUM(NSInteger, JZGNetworkRequestType) {
    JZGNetworkRequestGet = 0,
    JZGNetworkRequestPost = 1,
};

/**
 *  错误类型
 */
typedef NS_ENUM(NSInteger, JZGNetworkErrorType){
    JZGNetworkErrorDefault   = 0,
    JZGNetworkErrorNoServer  = -1003,
    JZGNetworkErrorTimeOut   = -1001,
    JZGNetworkErrorNoNetwork = -1009
};

/**
 *  请求成功时的回调
 *
 *  @param responseObject 回调的对象
 *  @param code           回调的code
 *  @param msg            回调的信息
 */
typedef void (^JZGNetworkRequestSuccessBlock)(id returnData,NSInteger code,NSString *msg);

/**
 *  请求错误的回调
 *
 *  @param error 错误回调的对象
 */
typedef void (^JZGNetworkRequestFailureBlock)(NSError *error);


#endif /* JZGNetworkDefine_h */
