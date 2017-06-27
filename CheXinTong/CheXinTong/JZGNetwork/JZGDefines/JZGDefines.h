

#import "JZGColorDefines.h"
#import "JZGURLDefines.h"
#import "JZGNotificationNames.h"
#import "JZGKeysDefine.h"
#import "JZGFontDefines.h"
#import "JZGRegularsDefine.h"
#import "JZGDeviceDefines.h"
#import "JZGEnumerateDefine.h"
#import "AppDelegate.h"
#import "MBProgressHUD+NJ.h"
#import "JZGHudManager.h"
#import "JZGBlockDefines.h"
#import "JZGValuationDefines.h"
//#import "JZGZHTabBarViewController.h"
//#import "JZGSPTabBarViewController.h"

//分页时每次请求数据的数量
#define PAGE_COUNT  20

//置换app 底部button高度

#define ZH_BOTTOM_BUTTON_HEIGHT  49

//delegate对象
#define JZGAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define kWindow JZGAppDelegate.window
//tabbar
#define TABBAR kWindow.rootViewController

#define ZHIHUAN [TABBAR isKindOfClass:[JZGZHTabBarViewController class]]

//#define PINGGU [TABBAR isKindOfClass:[JZGSPTabBarViewController class]]

//弱引用对象
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define NotificationCenter [NSNotificationCenter defaultCenter]

/**
 *  顶部导航栏和底部导航栏的高度
 *
 */
#define NAVIGATION_BAR_HEIGHT         64.0f
#define TARBAR_HEIGHT                 49.0f


/** 获取屏幕尺寸、宽度、高度 */
#define WINDOW ([UIApplication sharedApplication].keyWindow)
#define kScreenRect ([[UIScreen mainScreen] bounds])
#define kScreenSize ([UIScreen mainScreen].bounds.size)
//#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//#define kScreenHeight [UIScreen mainScreen].bounds.size.height

/** 导航栏左按钮界限*/
#define LEFT_BUTTON_X        5
#define LEFT_BUTTON_Y        12
#define LEFT_BUTTON_WIDTH    25
#define LEFT_BUTTON_HEIGHT   25
#define RIGHT_BUTTON_WIDTH   26
#define RIGHT_BUTTON_HEIGHT  24
#define RIGHT_BUTTON_X       kScreenWidth - 26 - 5
#define RIGHT_BUTTON_Y       12

//详情页左侧比例
#define DETAILMENUPERCENT      0.2

//分辨率
#define ISRETINA [[UIScreen mainScreen] scale] == 2.f

//ISRETINA
#define CUTTING_LINE_HEIGHT (ISRETINA ? 0.5 : 0.34)

//图片的宏定义
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%@",file,iPhone6Plus ? @"@3x" : @"@2x"] ofType:ext]]


//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_TABLEVIEW_HEIGHT        SCREEN_HEIGHT - NavigationBar_HEIGHT - StatusBar_HEIGHT

#pragma mark -

#if (!defined(DEBUG) && !defined (SD_VERBOSE)) || defined(SD_LOG_NONE)
#define NSLog(...)
#endif

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

// 当在debug模式时打印详细日志，在release模式时不打印详细日志
#ifdef DEBUG
# define DLog(format, ...) NSLog((@"[文件名:%s]" "[函数名:%s]" "[行号:%d]" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif

