//
//  JZGValuationDefines.h
//  JZGERSecondPhase
//
//  Created by liuqt on 16/9/22.
//  Copyright © 2016年 jzg. All rights reserved.
//

#ifndef JZGValuationDefines_h
#define JZGValuationDefines_h

#import "JZGFontColorMarcros.h"
#if         DEBUG
#define VALUATIONHOME_URL                   @"http://testtoolapi.guchewang.com"
//#define HOME_URL                   @"http://192.168.5.46:8022"
#else
#define VALUATIONHOME_URL                   @"http://toolapi.guchewang.com"

#endif
#define TABLEVIEW_BGCOLOR [UIColor colorWithRed:246/255.0f green:246/255.0f blue:246/255.0f alpha:1]
#define COLOR_LIGHTGRAY_MACROS   RGB(180,187,196)  //浅灰色

typedef enum : NSUInteger {
    LienceArea = 100,
    CarInfo ,
    LienceTime ,    // 上牌时间
    Mileage ,
    BuyPrice,
    BuyTime,
    SellPrice,
    SellTime,
    CarSource,
    DefaultMode,
} HandleType;

#ifdef DEBUG
#define JZGLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define JZGLog(...)
#endif

#endif /* JZGValuationDefines_h */
