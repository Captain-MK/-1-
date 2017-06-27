//
//  NSString+Extension.h
//  JZGAppraiserNetwork
//
//  Created by Mars on 14-11-25.
//  Copyright (c) 2014年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (BOOL)isEmail;
- (BOOL)isTelephone;
- (BOOL)isPassword;
- (BOOL)isRealNumbers;
- (BOOL)isEnterNumbers; 
- (BOOL)isMobileNumber;
- (BOOL)isOnlyMobileNumber; //对号码不做限定
- (BOOL) isTrueStr;//控制输入不含特殊符号
- (BOOL)isTrueVinStr;//控制vin输入特殊符号 
- (BOOL)isContainSubString:(NSString *)subString; //是否包涵子字符串
//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;
//车型
+ (BOOL) validateCarType:(NSString *)CarType;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;



@end
