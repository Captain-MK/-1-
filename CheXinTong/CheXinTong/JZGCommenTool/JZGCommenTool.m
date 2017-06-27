//
//  JZGCommenTool.m
//  JZGChryslerForPad
//
//  Created by jzg on 16/6/3.
//  Copyright © 2016年 Beijing JingZhenGu Information Technology Co.Ltd. All rights reserved.
//

#import "JZGCommenTool.h"
#import "AppDelegate.h"
#import "sys/utsname.h"

@implementation JZGCommenTool


+ (JZGCommenTool *)shareCommenTool{
    static JZGCommenTool *commenTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (!commenTool) {
            commenTool = [[self alloc] init];
        }
    });
    
    return commenTool;
}

- (void)showAlertView:(NSString *)message{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    [alert show];

}
//
//- (void)logout{
//
//    [JZGAppDelegate appLoginView];
//    
//}

+ (UIColor *)hexStringToColor: (NSString *) stringToConvert
{
//    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
//    if ([cString length] < 6) return [UIColor blackColor];
//    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
//    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
//    if ([cString length] != 6) return [UIColor blackColor];
//
//    NSRange range;
//    range.location = 0;
//    range.length = 2;
//    NSString *rString = [cString substringWithRange:range];
//    range.location = 2;
//    NSString *gString = [cString substringWithRange:range];
//    range.location = 4;
//    NSString *bString = [cString substringWithRange:range];
//    unsigned int r, g, b;
//    
//    [[NSScanner scannerWithString:rString] scanHexInt:&r];
//    [[NSScanner scannerWithString:gString] scanHexInt:&g];
//    [[NSScanner scannerWithString:bString] scanHexInt:&b];
//    
//    return [UIColor colorWithRed:((float) r / 255.0f)
//                           green:((float) g / 255.0f)
//                            blue:((float) b / 255.0f)
//                           alpha:1.0f];
    
    NSString *cString = stringToConvert;
    //去除空格并大写
    cString = [[cString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        //返回默认颜色
        return [UIColor redColor];
    }
    if ([cString hasPrefix:@"0x"]) {
        cString = [cString substringFromIndex:2];
    }
    else if ([cString hasPrefix:@"#"]){
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        //返回默认颜色
        return [UIColor redColor];
    }
    NSRange range;
    range.length = 2;
    range.location = 0;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r,g,b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:1.0f];
}

- (void)saveUsernameAndPassword:(NSString *)username password:(NSString *)password{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:username forKey:@"username"];
    [defaults setObject:password forKey:@"password"];
}

- (NSString *)readUsernameOrPassword:(NSString *)key{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [defaults objectForKey:key];
    return value?value:@"";
}

- (void)deleteUsenameAndPassword{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [defaults dictionaryRepresentation];
    NSArray *allkey = [dictionary allKeys];
    if ([allkey containsObject:@"username"]&&[allkey containsObject:@"password"]){
        [defaults removeObjectForKey:@"username"];
        [defaults removeObjectForKey:@"password"];
        [defaults synchronize];
    }

}

- (NSMutableAttributedString *) attributedLabelShow:(NSString *)commenString commentColor:(UIColor *)commentColor hightLightColor:(UIColor *)hightLightColor font:(UIFont *)font{
    NSString *showString = [NSString stringWithFormat:@"%@*",commenString];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:showString];
    [str addAttribute:NSForegroundColorAttributeName value:commentColor range:NSMakeRange(0,commenString.length-1)];
    [str addAttribute:NSForegroundColorAttributeName value:hightLightColor range:NSMakeRange(commenString.length,1)];
    [str addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,commenString.length-1)];
    [str addAttribute:NSFontAttributeName value:font range:NSMakeRange(commenString.length,1)];
    return str;
}

- (NSMutableAttributedString *) showDifColorNumberString:(NSString *)numberString
                                       totalNumberString:(NSString *)totalString
                                        errorNmberString:(NSString *)errorNumberString{
    UIColor *numberColor = [UIColor greenColor];
    UIColor *errorNumberColor = [UIColor redColor];
    UIColor *totalNumberColor = [JZGCommenTool hexStringToColor:@"#808080"];
    UIFont *font = [UIFont systemFontOfSize:14];
    NSString *showString = [NSString stringWithFormat:@"%@%@%@",numberString,errorNumberString,totalString];

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:showString];
    [str addAttribute:NSForegroundColorAttributeName value:numberColor range:NSMakeRange(0,numberString.length)];
    [str addAttribute:NSForegroundColorAttributeName value:errorNumberColor range:NSMakeRange(numberString.length,errorNumberString.length)];
    [str addAttribute:NSForegroundColorAttributeName value:totalNumberColor range:NSMakeRange(numberString.length+errorNumberString.length,totalString.length)];
    [str addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,showString.length)];

    return str;
}

- (BOOL)validateMobile:(NSString *)mobileNumbel
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181(增加)
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        return YES;
    }
    
    return NO;
}

- (BOOL)deviceString
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *model = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
//    NSString *model = [[UIDevice currentDevice] model];
    if ([model isEqualToString:@"iPhone1,1"])    return NO;
    if ([model isEqualToString:@"iPhone1,2"])    return NO;
    if ([model isEqualToString:@"iPhone2,1"])    return NO;
    if ([model isEqualToString:@"iPhone3,1"])    return NO;
    if ([model isEqualToString:@"iPhone3,3"])    return NO;
    if ([model isEqualToString:@"iPhone4,1"])    return NO;
    if ([model isEqualToString:@"iPhone5,1"])    return NO;
    if ([model isEqualToString:@"iPhone5,2"])    return NO;
    if ([model isEqualToString:@"iPhone5,3"])    return NO;
    if ([model isEqualToString:@"iPhone5,4"])    return NO;
    if ([model isEqualToString:@"iPhone6,1"])    return NO;
    if ([model isEqualToString:@"iPhone6,2"])    return NO;
    if ([model isEqualToString:@"iPhone7,1"])    return YES;
    if ([model isEqualToString:@"iPhone7,2"])    return YES;
    if ([model isEqualToString:@"iPhone8,1"])    return YES;
    if ([model isEqualToString:@"iPhone8,2"])    return YES;
    if ([model isEqualToString:@"iPod1,1"])      return NO;
    if ([model isEqualToString:@"iPod2,1"])      return NO;
    if ([model isEqualToString:@"iPod3,1"])      return NO;
    if ([model isEqualToString:@"iPod4,1"])      return NO;
    if ([model isEqualToString:@"iPod5,1"])      return NO;

    return YES;

}


@end
