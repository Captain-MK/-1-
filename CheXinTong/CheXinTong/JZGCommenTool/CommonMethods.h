//
//  CommonMethods.h
//  JZGAppraiserNetwork
//
//  Created by Mars on 14-11-26.
//  Copyright (c) 2014年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
//#import "JZGShareView.h"

typedef void(^getLocation)(NSString *stateName,NSString *cityName); //得到当地的位置信
typedef void(^shareCompletion)(BOOL success); //分享成功与否
typedef void(^saveCompletion)(); //保存成功与否
@interface CommonMethods : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager; //定位管理器
    getLocation locationStr;
    NSMutableDictionary *shareDic; //分享的视图参数
//    JZGShareView *shareView; //分享的视图
}
typedef enum{
    TextFieldType_default,      // 普通字符输入框
    TextFieldType_number,       // 不带小数点
    TextFieldType_money,        // 两位小数点 金额
    TextFieldType_date,         // 日期
    TextFieldType_insureDate,         // 年检日期
    TextFieldType_businessDate,         // 商业险日期
    TextFieldType_phone,        // 电话
    TextFieldType_email,         // 邮件
    TextFieldType_ASCIICapable, //字母和数字
    TextFieldType_vin, //vin，限制17位
    TextFieldType_Volume, //排量，限制4位
    TextFieldType_Postcode,
    TextFieldType_Mileage,  // 输入数字，限制里程字数8位
    TextFieldType_IntMoney,  // 输入数字，限制里程字数8位
    TextFieldType_CarPlante,  // 输入数字，限制里程字数8位
} TextFieldType;// 文本框类型
+ (CommonMethods *)sharedCommonMethods;

@property (nonatomic, copy) saveCompletion  saveCom;
@property(nonatomic,strong) UIViewController *shareController; //分享视图所在的控制器，用于新浪微博的编辑
@property (strong, nonatomic) NSString *inputText;
//MD5校验
+ (NSString *)md5HexDigest:(NSString*)password;
//网络连接
+ (BOOL) isConnectionAvailable;
//判断输入是否为空
+ (BOOL) isEmpty:(NSString *) str;
+ (BOOL) isBlankString:(NSString *)string;

//根据内容计算行高
//+ (CGFloat)contentCellHeightWithText:(NSString*)text;
+ (CGFloat)contentCellHeightWithText:(NSString*)text width:(float)width fontSize:(float)fontsize;

//控制输入不含特殊符号的字符串
+ (BOOL)validateString:(NSString*)number range:(NSRange)range;
//通过类型，用正则表达式来判断输入时的操作
+ (BOOL)validateRightString:(NSString*)number andTextFieldType:(TextFieldType)typeStyle;

//输入数字
+ (BOOL)validateNumberUnlimited:(NSString*)number range:(NSRange)range;

//控制输入数字
+ (BOOL)validateNumber:(NSString*)number range:(NSRange)range;
//控制登录输入的是数字
+ (BOOL)validateLoginNumber:(NSString*)number range:(NSRange)range;
+ (BOOL)textfield:(UITextField *)textField validateNumber:(NSString*)number range:(NSRange)range;
//获取网络图片
+ (UIImage *) getImageFromURL:(NSString *)fileURL;

//控制注册输入的字符串是数字
+ (BOOL)textfield:(UITextField *)textField validateNumber:(NSString*)number range:(NSRange)range length:(NSInteger)length;
///控制输入数字有限制长度
+ (BOOL)validateString:(NSString*)number range:(NSRange)range limitLength:(NSInteger)limitLength;

/// 输入数字包含小数点（有限制长度）
+ (BOOL)textfield:(UITextField *)textField validatePriceNumber:(NSString*)number range:(NSRange)range withLimitLength:(NSInteger)limitLength;
/// 价格（万元）控制注册输入的字符串是数字
+ (BOOL)textfield:(UITextField *)textField validatePriceNumber:(NSString*)number range:(NSRange)range;
//根据内同几环行高
//+ (CGFloat)contentCellHeightWithText:(NSString*)text width:(float)width font:(UIFont *)font;
//根据文字内容计算宽度
+ (CGFloat)contentWidthWithText:(NSString*)text height:(float)height fontSize:(float)fontsize;
//根据数组尺寸信息适配尺寸，0为默认，1为iphone 5,5s 2为iphone 6,3为iphone 6plus
+ (NSString*)adaptationDeviceWithInteger:(NSArray*)rectArray;
//转换图片的方向
+ (UIImage *)fixOrientation:(UIImage *)aImage;
+ (BOOL)validateNumString:(NSString*)number;
/**
 *  清除某字符串内特殊字符
 *
 *  @param str     字符串
 *  @param special 特殊字符
 *
 *  @return 清除字符后的串
 */
+ (NSString *) stringDeleteString:(NSString *)str specialStr:(unichar)special;
/**
 *  通过指定当前年月，获取当前的天数
 *
 *  @param year   指定的年份
 *  @param imonth 指定的月份
 *
 *  @return 返回的天数
 */
+(NSInteger)howManyDaysInThisMonth:(NSInteger)year month:(NSInteger)imonth;

/**
 *  控制输入的是数字
 *
 *  @param number 输入内容
 *  @param range  位置
 *  @param length 长度
 *
 *  @return 返回是否允许输入
 */
+ (BOOL)validateNumberUnlimited:(NSString*)number range:(NSRange)range length:(NSInteger)length;

//+ (BOOL)validateLoginNumber:(NSString*)number range:(NSRange)range length:(NSInteger)length;
/**
 *  开始定位  show 未开启定位时是否提示用户
 */
-(void)startLocationWithShowAlertView:(BOOL)show location:(getLocation)getLocal;
#pragma mark 创建分享视图
/**
 *  创建分享弹出视图
 *
 *  @param shareText   朋友圈分享内容
 *  @param urlStr      分享内容的url
 *  @param weiXinTitle 微信标题
 *  @param weiXinText  微信描述
 *  @param msgText     短信显示的内容
 */
-(void)createShareBtnView:(NSString *)shareText urlStr:(NSString *)urlStr weiXinTitle:(NSString *)weiXinTitle weiXinText:(NSString *)weiXinText
                  msgText:(NSString *)msgText subControoler:(UIViewController *)subController picUrl:(NSData *)picData;
@end
