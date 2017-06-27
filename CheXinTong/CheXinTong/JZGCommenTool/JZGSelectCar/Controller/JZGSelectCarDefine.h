//
//  JZGSelectCarDefine.h
//  JingZhenGu
//
//  Created by Mars on 16/1/4.
//  Copyright © 2016年 Mars. All rights reserved.
//

#ifndef JZGSelectCarDefine_h
#define JZGSelectCarDefine_h


#import "MBProgressHUD+NJ.h"
#import "JZGSelectCarModel.h"

/**
 *  车型选择视图样式
 */
typedef NS_ENUM(NSInteger, JZGCarInfoType) {
    /**
     *  只显示品牌
     */
    JZGCarBrandType = 0,
    /**
     *  显示品牌和车系
     */
    JZGCarStyleType = 1,
    /**
     *  显示品牌、车系，车型
     */
    JZGCarModelType = 2,
};

/**
 *  车辆选择视图显示样式
 */
typedef NS_ENUM(NSInteger,JZGShowNextViewType) {
    /**
     *  push推进
     */
    JZGShowNextViewPushType    = 0,
    /**
     *  push平滑推出
     */
    JZGShowNextViewPushSlideType   = 1,
    /**
     *  present推进
     */
    JZGShowNextViewPresentType = 2,
    /**
     *  present平滑推出
     */
    JZGShowNextViewPresentSlideType = 3,
};

/**
 *  网络请求类型
 */
typedef NS_ENUM(NSInteger,JZGRequestUrlType) {
    /**
     *  普通选择车型
     */
    JZGRequestUrlDefaultType = 0,
    /**
     *  估值选择车型
     */
    JZGRequestUrlValuationType = 1,
    /**
     *  旧车选择车型
     */
    JZGRequestUrlOldCarType = 2,
    /**
     *  新车选择车型
     */
    JZGRequestUrlNewCarType = 3,
    /**
     *  指定选择车型
     */
    JZGRequestUrlAppointCarType = 4,
    
};

/**车型选择 DEBUG：测试接口地址*/
#if DEBUG
#define kSelectCarUrl      @"http://api.jingzhengu.com/APP/PublicInt/GetMakeAndModelAndStyle.ashx"
#define kSelectAppointUrl      [NSString stringWithFormat:@"%@%@",HOME_URL,@"/car/CarValuation.ashx"]

#else
#define kSelectCarUrl      @"http://api.jingzhengu.com/APP/PublicInt/GetMakeAndModelAndStyle.ashx"
#define kSelectAppointUrl      [NSString stringWithFormat:@"%@%@",HOME_URL,@"/car/CarValuation.ashx"]

#endif

#endif /* JZGSelectCarDefine_h */
