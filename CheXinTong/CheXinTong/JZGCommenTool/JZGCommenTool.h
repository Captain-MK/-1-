//
//  JZGCommenTool.h
//  JZGChryslerForPad
//
//  Created by jzg on 16/6/3.
//  Copyright © 2016年 Beijing JingZhenGu Information Technology Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "JZGDetailDataModel.h"
//#import "JZGOptionsDataModel.h"


typedef void(^previousButton)(id sender);
typedef void(^nextButton)(id sender);
typedef void(^oneNextButton)(id sender);

@interface JZGCommenTool : NSObject

/**
 *  单利模式。
 *
 *  @return 返回当前类的单利对象
 */
+ (JZGCommenTool *)shareCommenTool;

/**
 *  自定义UIALertView
 *
 *  @param message 要显示的提示语
 */
- (void)showAlertView:(NSString *)message;


/**
 *  色值转UIColor
 *
 *  @param stringToConvert 16进制的色值字符转
 *
 *  @return 生成相应的UIColor
 */
+ (UIColor *)hexStringToColor: (NSString *) stringToConvert;

//- (NSString *)getSelectItemNumber:(JZGOptionsDataModel *)itemModel;
//- (NSString *)getAllItemNumber:(JZGOptionsDataModel *)itemModel;
//
//- (NSString *)getServiceMoney:(JZGDetailDataModel *)detailModel;

- (void)logout;

- (void)saveUsernameAndPassword:(NSString *)username password:(NSString *)password;


- (NSString *)readUsernameOrPassword:(NSString *)key;

- (void)deleteUsenameAndPassword;

- (BOOL)validateMobile:(NSString *)mobileNum;

- (BOOL)deviceString;

- (NSMutableAttributedString *) attributedLabelShow:(NSString *)commenString commentColor:(UIColor *)commentColor hightLightColor:(UIColor *)hightLightColor font:(UIFont *)font;

- (NSMutableAttributedString *) showDifColorNumberString:(NSString *)numberString totalNumberString:(NSString *)totalString errorNmberString:(NSString *)errorNumberString;

@end
