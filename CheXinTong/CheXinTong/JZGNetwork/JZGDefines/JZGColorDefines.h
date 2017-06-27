//
//  JZGColorDefines.h
//  JZGERP
//
//  Created by jzg on 16/6/27.
//  Copyright © 2016年 jzg. All rights reserved.
//

#ifndef JZGColorDefines_h
#define JZGColorDefines_h


/**
 *  APP 导航条的颜色
 *
 *  @return
 */
#define  JZG_APP_BACKGROUND_COLOUR                     @"#FFFFFF"


/**
 *  APP 的主色调蓝颜色
 *
 *  @return
 */
#define JZG_APP_COMMEN_BLUE_COLOR                       @"#4189E2"

/**
 *  APP 中所有tableViewCell 的标题的颜色
 *
 *  @return
 */
#define JZG_TABLE_CELL_TITILE_COLOR                     @"#222222"

/**
 *  APP 中所有tableViewCell 的副标题的颜色
 *
 *  @return
 */
#define JZG_TABLE_CELL_DETAIL_COLOR                     @"#666666"

/**
 * 通用线的颜色。
 *
 *  @return return value description
 */
#define JZG_LINE_COLOR                                  @"#E5E9F0"

/**灰色*/
#define COLOR_GRAY_MARCROS                                @"#999999"


#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


#define FONT_COLOR_BLUE             RGBCOLOR(26,155,245)
#define FONT_COLOR_WHITE(a)         RGBACOLOR(255,255,255,a)

/**
 *  分割线颜色
 */
#define CUTTING_LINE_COLOR         RGBCOLOR(0xe8, 0xe8, 0xe8)
/**
 *  顶部导航栏颜色
 */
#define NAVIGATION_BAR_COLOR       RGBCOLOR(248, 248, 250)
/**
 *  底部导航栏颜色
 */
#define TARBAR_BAR_COLOR           RGBCOLOR(250, 251, 253)
/**
 *  背景颜色
 */
#define BACKGROUND_COLOR           RGBCOLOR(244, 244, 244)
/**线的颜色，亮银灰色*/
#define COLOR_LINE_MARCROS         RGBCOLOR(229, 229, 229)
/**
 *  获取随机色
 */
#define kRandomColor ([UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0f])

/**进制颜色转换*/
#define JZGUIColorFromRGB(rgbValue) [UIColor              \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0           \
blue:((float)(rgbValue & 0xFF))/255.0                     alpha:1.0]

/**蓝色*/
#define COLOR_BLUE_MARCROS                                JZGUIColorFromRGB(0x4790ef)
/**黑色*/
#define COLOR_BLACK_MARCROS                               JZGUIColorFromRGB(0x333333)



// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
//导航栏颜色
#define FONT_COLOR_BACKGROUND       RGB(244,244,244)        //背景颜色
#define FONT_COLOR_NAV              RGB(14, 61, 119)        //导航栏颜色
//#define FONT_COLOR_WHITE(a)         RGBA(255,255,255,a)     //白色带透明度
#define FONT_COLOR_BLACK            RGB(51,51,51)           //黑色
#define FONT_COLOR_DARKGREY         RGB(153,153,153)        //深灰色
#define FONT_COLOR_GREY             RGB(187,187,187)        //灰色
#define FONT_COLOR_LIGHTGREY        RGB(221,221,221)        //浅灰色
#define FONT_COLOR_GREEN            RGB(68,202,9)           //绿色
//#define FONT_COLOR_MASK(a)          RGBA(51,51,51,a)        //遮罩层颜色
//#define FONT_COLOR_BLUE             RGB(26,155,245)         //蓝色
#define FONT_COLOR_RED              RGB(255,82,82)           //红色
#define FONT_COLOR_ORANGE           RGB(255, 204, 0)        //橙色
#define FONT_COLOR_HEADERVIEW_BG    RGB(238,243,252)        //UITableView的
#define XD_FONT_COLOR_BLACK         RGB(60,74,85)           //字体（黑色）


#define COLOR_BLUE_MACROS     [UIColor colorWithRed:69/255.0f green:135/255.0f blue:195/255.0f alpha:1.0]//蓝色

#define COMMENLINECOLOR             [JZGCommenTool hexStringToColor:@"#EBEBEB"]
#define COMMENTITLECOLOR             [JZGCommenTool hexStringToColor:@"#5E5E5E"]

#endif /* JZGColorDefines_h */
