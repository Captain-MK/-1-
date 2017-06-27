//
//  JZGFontColorMarcros.h
//  JZGValuationProject
//
//  Created by Mars on 16/5/18.
//  Copyright © 2016年 Mars. All rights reserved.
//

#ifndef JZGFontColorMarcros_h
#define JZGFontColorMarcros_h

/****************************    app字体、大小、颜色，背景色等常用宏    ****************************/

/** 字体及大小 */
#define JZGBoldFont(a)  [UIFont boldSystemFontOfSize:a]         //加粗字体
#define JZGFont(a)      [UIFont systemFontOfSize:a]

/**进制颜色转换*/
#define JZGUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f  alpha:a]
#define RGB(r,g,b)                                                                 RGBA(r,g,b,1.0f)
//导航栏颜色
#define FONT_COLOR_BACKGROUND    RGB(244,244,244)        //背景颜色
#define FONT_COLOR_BLACK         RGB(51,51,51)           //黑色
#define FONT_COLOR_DARKGREY      RGB(153,153,153)        //深灰色
#define FONT_COLOR_GREY          RGB(187,187,187)        //灰色
#define FONT_COLOR_LIGHTGREY     RGB(221,221,221)        //浅灰色
#define FONT_COLOR_GREEN         RGB(68,202,9)           //绿色
#define FONT_COLOR_MASK(a)       RGBA(51,51,51,a)        //遮罩层颜色
#define FONT_COLOR_RED           RGB(255,82,82)          //红色
#define COLOR_LIGHTGRAY_MACROS   RGB(180,187,196)  //浅灰色
#define FONT_COLOR_HEADERVIEW_BG RGB(238,243,252)        //UITableView的headerView背景颜色
#define FONT_COLOR_DARKORANGE    RGB(253,132,22)         //橘色
#define FONT_COLOR_LOGOUT    RGB(250,101,3)         //退出按钮颜色

#define FONT_SIZE(f)               [UIFont systemFontOfSize:f]

#define WINDOW ([UIApplication sharedApplication].keyWindow)
/**数据提交等待提示*/
#define WAITMSG [MBProgressHUD showMessage:@"数据提交中" toView:WINDOW];
/**数据加载等待提示*/
#define WAITLODING [MBProgressHUD showMessage:@"数据加载中" toView:WINDOW];
/**数据加载等待提示*/
#define SHOWWAITMESSAGE(msg) [MBProgressHUD showMessage:msg toView:WINDOW];
/**加载成功提示*/
#define SHOWSUCESSMESSAGE(msg) [MBProgressHUD showSuccess:msg toView:WINDOW];
/**加载失败提示*/
#define SHOWERRORMESSAGE(msg) [MBProgressHUD showError:msg toView:WINDOW ];
/**隐藏提示*/
#define CLOSEALLMESSAGE [MBProgressHUD hideAllHUDsForView:WINDOW animated:YES];

/**对比红色*/
#define COLOR_CONTRASTRED_MARCROS                                 JZGUIColorFromRGB(0xef3f2f)
/**对比字体颜色*/
#define COLOR_CONTRASTCOLOR_MARCROS                          JZGUIColorFromRGB(0x1da4e9)
/**黑色*/
#define COLOR_BLACK_MARCROS                               JZGUIColorFromRGB(0x333333)
/**深黑色*/
#define COLOR_DEEPBLACK_MARCROS                           JZGUIColorFromRGB(0x000000)
/**蓝色*/
#define COLOR_BLUE_MARCROS                                JZGUIColorFromRGB(0x4790ef)
/**浅蓝色*/
#define COLOR_LIGHTBLUE_MARCROS                           JZGUIColorFromRGB(0xebf2fc)
/**天蓝色*/
#define COLOR_SKYBLUE_MARCROS                             JZGUIColorFromRGB(0xf3f8fe)

/**浅灰色*/
#define COLOR_LIGHTGRAY_MARCROS                           JZGUIColorFromRGB(0xdddddd)

/**红色*/
#define COLOR_RED_MARCROS                                 JZGUIColorFromRGB(0xff3400)
/**绿色*/
#define COLOR_GREEN_MARCROS                               JZGUIColorFromRGB(0x32b16c)
/**背景色*/
#define COLOR_BACKGROUND_MARCROS                          JZGUIColorFromRGB(0xf8f8f8)

/**导航栏*/
#define COLOR_NAV_MARCROS                                 RGB(14, 61, 119)                       //大图导航栏颜色


//蓝色字体颜色
#define BLUEWORD_COLOR [UIColor colorWithRed:54/255.0f green:118/255.0f blue:233/255.0f alpha:1]
//tableview背景颜色
#define TABLEVIEW_BGCOLOR [UIColor colorWithRed:246/255.0f green:246/255.0f blue:246/255.0f alpha:1]


/// 一般的字体颜色
#define NORMAL_BLACK_COLOR [UIColor blackColor]
// 价格颜色
#define PRICE_COLOR  [UIColor colorWithRed:237/255.0f green:50/255.0f blue:16/255.0f alpha:1]


//#define COLOR_BLUE_MACROS     [UIColor colorWithRed:69/255.0f green:135/255.0f blue:195/255.0f alpha:1.0]//蓝色
#define COVER_ALPHA    0.3f      //蒙版透明度

#define COLOR_SILVERGRAY_MACROS                         RGB(242,245,248)  //银灰色
#define COLOR_WHITE_MACROS                              RGB(255,255,255)  //白色
#define COLOR_ORANGE_MACROS                             RGB(255,110,64)   //橘色
#define DESCRIPTION_COLOR RGB(137,137,137)  //描述文字颜色

#define FONT_COLOR_PERSON    RGB(63,158,236)        //蓝色
#define FONT_COLOR_BUSINESS    RGB(255,168,81)        //橘色
#define FONT_COLOR_SEGMENT    RGB(255,106,71)        //segment颜色
#define FONT_COLOR_TEXT    RGB(100,100,100)        //文字颜色

/****************************    硬件相关    ****************************/

/** 设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x */
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 5C/5/5S 分辨率320x568，像素640x1136，@2x */
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 分辨率375x667，像素750x1334，@2x */
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 Plus 分辨率414x736，像素1242x2208，@3x */
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6PlusZoom ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?  CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)

#endif /* JZGFontColorMarcros_h */
