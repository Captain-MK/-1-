//
//  CommonMethods.m
//  JZGAppraiserNetwork
//
//  Created by Mars on 14-11-26.
//  Copyright (c) 2014年 Mars. All rights reserved.
//

#import "CommonMethods.h"
#import <CommonCrypto/CommonDigest.h>
// uiview动画时间
#define kANIMATEDURATION 0.2f
@implementation CommonMethods
+ (CommonMethods *)sharedCommonMethods
{
    static CommonMethods *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

#pragma mark - MD5校验
+ (NSString *)md5HexDigest:(NSString*)password
{
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    //    NSLog(@"Encryption Result = %@",mdfiveString);
    return mdfiveString;
}

#pragma mark - 检查网络连接
+ (BOOL) isConnectionAvailable
{
    SCNetworkReachabilityFlags flags;
    BOOL receivedFlags;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(CFAllocatorGetDefault(), [@"dipinkrishna.com" UTF8String]);
    receivedFlags = SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    
    if (!receivedFlags || (flags == 0) )
    {
        return FALSE;
    } else {
        return TRUE;
    }
}

#pragma mark - 判断输入是否是空格
+ (BOOL) isEmpty:(NSString *) str
{
    if (!str) {
        return YES;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
}

//检测字符串是否为空
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[[NSString stringWithFormat:@"%@",string] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//控制注册输入的字符串是数字
+ (BOOL)textfield:(UITextField *)textField validateNumber:(NSString*)number range:(NSRange)range length:(NSInteger)length{
    BOOL res = YES;
    BOOL isHaveDian;
    NSCharacterSet *tmpSet;
    NSString *myBidPrice = textField.text;
    
    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        isHaveDian = NO;
    }
    
    if (range.location == 0) {
        tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
    }
    else
    {
        if ([myBidPrice hasPrefix:@"0"]) {
            if (range.location == 1) {
                tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"."];
            }
            else
            {
                tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
            }
            
        }
        else
        {
            tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890."];
        }
    }
    int i = 0;
    while (i < number.length)  {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange tmpRange = [string rangeOfCharacterFromSet:tmpSet];
        if (tmpRange.length == 0) {
            res = NO;
            break;
        }
        else
        {
            if(range.location < length)
            {
                NSRange point = [textField.text rangeOfString:@"."];
                
                if (point.location == NSNotFound) {
                    if (range.location >= length - 3) {
                        if (range.location == length - 3 && [number isEqualToString:@"."]) {
                            res = YES;
                        }
                        else
                        {
                            number = @"";
                            res = NO;
                        }
                        
                    }else{
                        res = YES;
                    }
                }else{
                    isHaveDian=YES;
                    //text中还没有小数点
                    if(!isHaveDian){
                        isHaveDian=YES;
                        return YES;
                    }else{
                        if ([number isEqualToString:@"."]) {
                            //                            [self createAlertView:@"亲，您已经输入过小数点了"];
                            [textField.text stringByReplacingCharactersInRange:range withString:@""];
                            return NO;
                        }else{
                            //判断小数点后的位数
                            long tt = range.location-point.location;
                            if (tt <= 2){
                                res = YES;
                            }else{
                                //                                [self createAlertView:@"亲，您最多输入两位小数"];
                                res = NO;
                            }
                        }
                    }
                }
            }else{
                res = NO;
                break;
            }
        }
        i++;
    }
    return res;
}

/// 输入数字包含小数点（有限制长度）
+ (BOOL)textfield:(UITextField *)textField validatePriceNumber:(NSString*)number range:(NSRange)range withLimitLength:(NSInteger)limitLength
{
    BOOL res = YES;
    BOOL isHaveDian;
    NSCharacterSet *tmpSet;
    NSString *myBidPrice = textField.text;
    
    if (range.location == 0) {
        tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
    }
    else
    {
        if ([myBidPrice hasPrefix:@"0"]) {
            if (range.location == 1) {
                tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"."];
            }
            else
            {
                tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
            }
            
        }
        else
        {
            tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890."];
        }
    }
    int i = 0;
    while (i < number.length)  {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange tmpRange = [string rangeOfCharacterFromSet:tmpSet];
        if (tmpRange.length == 0) {
            res = NO;
            break;
        }
        else
        {
            if(range.location <=limitLength+2)
            {
                NSRange point = [textField.text rangeOfString:@"."];
                
                if (point.location == NSNotFound) {
                    if (range.location >= limitLength) {
                        if (range.location == limitLength && [number isEqualToString:@"."]) {
                            res = YES;
                        }
                        else
                        {
                            number = @"";
                            res = NO;
                        }
                        
                    }else{
                        res = YES;
                    }
                }else{
                    isHaveDian=YES;
                    //text中还没有小数点
                    if(!isHaveDian){
                        return YES;
                    }else{
                        if ([number isEqualToString:@"."]) {
                            [textField.text stringByReplacingCharactersInRange:range withString:@""];
                            return NO;
                        }else{
                            //判断小数点后的位数
                            long tt = range.location-point.location;
                            if (tt <= 2){
                                res = YES;
                            }else{
                                //                                [self createAlertView:@"亲，您最多输入两
                                res = NO;
                            }
                        }
                    }
                }
            }else{
                res = NO;
                break;
            }
        }
        i++;
    }
    return res;
}
/// 价格（万元）控制注册输入的字符串是数字
+ (BOOL)textfield:(UITextField *)textField validatePriceNumber:(NSString*)number range:(NSRange)range
{
    BOOL res = YES;
    BOOL isHaveDian;
    NSCharacterSet *tmpSet;
    NSString *myBidPrice = textField.text;
    
    if (range.location == 0) {
        tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
    }
    else
    {
        if ([myBidPrice hasPrefix:@"0"]) {
            if (range.location == 1) {
                tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"."];
            }
            else
            {
                tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
            }
            
        }
        else
        {
            tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890."];
        }
    }
    int i = 0;
    while (i < number.length)  {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange tmpRange = [string rangeOfCharacterFromSet:tmpSet];
        if (tmpRange.length == 0) {
            res = NO;
            break;
        }
        else
        {
            if(range.location < 5)
            {
                NSRange point = [textField.text rangeOfString:@"."];
                
                if (point.location == NSNotFound) {
                    if (range.location >= 2) {
                        if (range.location == 2 && [number isEqualToString:@"."]) {
                            res = YES;
                        }
                        else
                        {
                            number = @"";
                            res = NO;
                        }
                        
                    }else{
                        res = YES;
                    }
                }else{
                    isHaveDian=YES;
                    //text中还没有小数点
                    if(!isHaveDian){
                        return YES;
                    }else{
                        if ([number isEqualToString:@"."]) {
                            //                            [self createAlertView:@"亲，您已经输入过小数点了"];
                            [textField.text stringByReplacingCharactersInRange:range withString:@""];
                            return NO;
                        }else{
                            //判断小数点后的位数
                            long tt = range.location-point.location;
                            if (tt <= 2){
                                res = YES;
                            }else{
                                //                                [self createAlertView:@"亲，您最多输入两
                                res = NO;
                            }
                        }
                    }
                }
            }else{
                res = NO;
                break;
            }
        }
        i++;
    }
    return res;
}
//控制输入电话号码
+ (BOOL)validateNumber:(NSString*)number range:(NSRange)range{
    BOOL res = YES;
    NSCharacterSet *tmpSet;
    if (range.location == 0) {
        tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"1"];
    }
    else if(range.location == 1)
    {
        tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"34578"];
    }
    else
    {
        tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    }
    
    
    int i = 0;
    while (i < number.length)  {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange tmpRange = [string rangeOfCharacterFromSet:tmpSet];
        if (tmpRange.length == 0) {
            res = NO;
            break;
        }
        else
        {
            if (range.location >= 11) {
                res = NO;
            }
            else
            {
                res = YES;
            }
        }
        i++;
    }
    return res;
}

//控制注册输入的字符串是数字
+ (BOOL)validateNumberUnlimited:(NSString*)number range:(NSRange)range{
    BOOL res = YES;
   NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    int i = 0;
    while (i < number.length)  {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange tmpRange = [string rangeOfCharacterFromSet:tmpSet];
        if (tmpRange.length == 0) {
            res = NO;
            break;
        }
        else
        {
            if (range.location >= 6) {
                res = NO;
            }
            else
            {
                res = YES;
            }
        }
        i++;
    }
    return res;
}

//控制注册输入的字符串是数字
+ (BOOL)validateNumberUnlimited:(NSString*)number range:(NSRange)range length:(NSInteger)length{
    BOOL res = YES;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    
    int i = 0;
    while (i < number.length)  {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange tmpRange = [string rangeOfCharacterFromSet:tmpSet];
        if (tmpRange.length == 0) {
            res = NO;
            break;
        }else{
            if (range.location >= length) {
                res = NO;
            }
            else
            {
                res = YES;
            }
        }
        i++;
    }
    return res;
}

//控制登录输入的字符串是数字
+ (BOOL)validateLoginNumber:(NSString*)number range:(NSRange)range{
    BOOL res = YES;
    //    NSCharacterSet *tmpSet;
    //    if (range.location == 0) {
    ////        tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"1"];
    //    }
    //    else if(range.location == 1)
    //    {
    //        tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"34578"];
    //    }
    //    else
    //    {
    //        tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    //    }
    //
    //
    //    int i = 0;
    //    while (i < number.length)  {
    //        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
    //        NSRange tmpRange = [string rangeOfCharacterFromSet:tmpSet];
    //        if (tmpRange.length == 0) {
    //            res = NO;
    //            break;
    //        }
    //        else
    //        {
    //            if (range.location >= 11) {
    //                res = NO;
    //            }
    //            else
    //            {
    //                res = YES;
    //            }
    //        }
    //        i++;
    //    }
    
    if (number.length<12) {
        if ((number.length ==2)&&([number isContainSubString:@"00"])) {
            return NO;
        }
        res =YES;
    }else{
        res =NO;
    }
    
    return res;
}


//获取网络图片
+ (UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

//控制输入不含特殊符号的字符串
+ (BOOL)validateString:(NSString*)number range:(NSRange)range{
    BOOL res = YES;
    NSCharacterSet *tmpSet;
    tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-－"];
    
    int i = 0;
    while (i < number.length)  {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange tmpRange = [string rangeOfCharacterFromSet:tmpSet];
        if (tmpRange.length == 0) {
            res = NO;
            break;
        }
        else
        {
            if (range.location >= 17) {
                res = NO;
            }
            else
            {
                res = YES;
            }
        }
        i++;
    }
    return res;
}
//控制输入不含特殊符号  的  一定长度字符串
+ (BOOL)validateString:(NSString*)number range:(NSRange)range limitLength:(NSInteger)limitLength{
    BOOL res = YES;
    NSCharacterSet *tmpSet;
    tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"];
    
    int i = 0;
    while (i < number.length)  {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange tmpRange = [string rangeOfCharacterFromSet:tmpSet];
        if (tmpRange.length == 0) {
            res = NO;
            break;
        }
        else
        {
            if (range.location >= limitLength) {
                res = NO;
            }
            else
            {
                res = YES;
            }
        }
        i++;
    }
    return res;
}

+ (BOOL)validateNumString:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet *tmpSet;
    tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"];
    
    for (int i = 0; i < number.length; i ++) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
         NSRange tmpRange = [string rangeOfCharacterFromSet:tmpSet];
        res = tmpRange.length > 0;
    }
    return res;
    
}

//控制输入不含特殊符号的字符串
+ (BOOL)validateRightString:(NSString*)number andTextFieldType:(TextFieldType)typeStyle{
    BOOL res =YES;
    switch (typeStyle) {
        case TextFieldType_Volume: //排量的限制
        {
            NSString * regex = @"^(0|[1-9][0-9]{0,3})$";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            
            return [pred evaluateWithObject:number];
            break;
        }
        default:
            break;
    }
    return res;
}

// 控制注册输入的字符串是数字
+ (BOOL)textfield:(UITextField *)textField validateNumber:(NSString*)number range:(NSRange)range
{
    BOOL res = YES;
    BOOL isHaveDian;
    NSCharacterSet *tmpSet;
    NSString *myBidPrice = textField.text;
    
    if (range.location == 0) {
        tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
    }
    else
    {
        if ([myBidPrice hasPrefix:@"0"]) {
            if (range.location == 1) {
                tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"."];
            }
            else
            {
                tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
            }
            
        }
        else
        {
            tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890."];
        }
    }
    int i = 0;
    while (i < number.length)  {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange tmpRange = [string rangeOfCharacterFromSet:tmpSet];
        if (tmpRange.length == 0) {
            res = NO;
            break;
        }
        else
        {
            if(range.location < 5)
            {
                NSRange point = [textField.text rangeOfString:@"."];
                
                if (point.location == NSNotFound) {
                    if (range.location >= 2) {
                        if (range.location == 2 && [number isEqualToString:@"."]) {
                            res = YES;
                        }
                        else
                        {
                            number = @"";
                            res = NO;
                        }
                        
                    }else{
                        res = YES;
                    }
                }else{
                    isHaveDian=YES;
                    //text中还没有小数点
                    if(!isHaveDian){
                        return YES;
                    }else{
                        if ([number isEqualToString:@"."]) {
                            //                            [self createAlertView:@"亲，您已经输入过小数点了"];
                            [textField.text stringByReplacingCharactersInRange:range withString:@""];
                            return NO;
                        }else{
                            //判断小数点后的位数
                            long tt = range.location-point.location;
                            if (tt <= 2){
                                res = YES;
                            }else{
                                //                                [self createAlertView:@"亲，您最多输入两
                                res = NO;
                            }
                        }
                    }
                }
            }else{
                res = NO;
                break;
            }
        }
        i++;
    }
    return res;
}
//根据要显示的text计算label高度
+ (CGFloat)contentCellHeightWithText:(NSString*)text width:(float)width font:(UIFont *)font
{
//    UIFont *font = [UIFont fontWithName:@"Arial" size:font];//font一定要跟label的显示字体大小一致
    //设置字体
    CGSize size = CGSizeMake(width, 20000.0f);//注：这个宽 是你要显示的宽度既固定的宽度，高度可以依照自己的需求而定
    if (IOS_VERSION > 7.0)//IOS 7.0 以上
    {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        size =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    }
    else
    {
        size = [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];//ios7以上已经摒弃的这个方法
    }
    return size.height;
}

//根据要显示的text计算label高度
+ (CGFloat)contentCellHeightWithText:(NSString*)text width:(float)width fontSize:(float)fontsize
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:fontsize];//11 一定要跟label的显示字体大小一致
    //设置字体
    CGSize size = CGSizeMake(width, 20000.0f);//注：这个宽：300 是你要显示的宽度既固定的宽度，高度可以依照自己的需求而定
    if (IOS_VERSION > 7.0)//IOS 7.0 以上
    {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        size =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    }
    else
    {
        size = [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];//ios7以上已经摒弃的这个方法
    }
    return size.height;
}

//根据要显示的text计算label宽度
+ (CGFloat)contentWidthWithText:(NSString*)text height:(float)height fontSize:(float)fontsize
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:fontsize];//11 一定要跟label的显示字体大小一致
    //设置字体
    CGSize size = CGSizeMake(MAXFLOAT, height);//注：这个宽：300 是你要显示的宽度既固定的宽度，高度可以依照自己的需求而定
    if (IOS_VERSION > 7.0)//IOS 7.0 以上
    {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        size =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    }
    else
    {
        size = [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];//ios7以上已经摒弃的这个方法
    }
    return size.width;
}

#pragma mark 根据数组尺寸信息适配尺寸，0为默认，1为iphone 5,5s 2为iphone 6,3为iphone 6plus
+ (NSString*)adaptationDeviceWithInteger:(NSArray*)rectArray{
    if (iPhone5)// iPhone6放大模式同样适合
        return [rectArray objectAtIndex:1];
    else if (iPhone6 || iPhone6PlusZoom)
        return [rectArray objectAtIndex:2];
    else if (iPhone6Plus)
        return [rectArray objectAtIndex:3];
    else
        return [rectArray objectAtIndex:0];
}

#pragma mark 转换图片的方向
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    if (aImage==nil || !aImage) {
        return nil;
    }
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp) return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    UIImageOrientation orientation=aImage.imageOrientation;
    int orientation_=orientation;
    switch (orientation_) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
    }
    
    switch (orientation_) {
        case UIImageOrientationUpMirrored:{
            
        }
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
//    aImage=img;
//    img=nil;
}

+ (NSString *) stringDeleteString:(NSString *)str specialStr:(unichar)special
{
    NSMutableString *str1 = [NSMutableString stringWithString:str];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        if ( c == special) { //此处可以是任何字符
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    NSString *newstr = [NSString stringWithString:str1];
    return newstr;
}

+(NSInteger)howManyDaysInThisMonth:(NSInteger)year month:(NSInteger)imonth {
    if((imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        return 30;
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
    {
        return 28;
    }
    if(year%400 == 0)
        return 29;
    if(year%100 == 0)
        return 28;
    return 29;
}
//开始定位
-(void)startLocationWithShowAlertView:(BOOL)show location:(getLocation)getLocal{
    locationStr =getLocal;
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
        if (show) { // showalertview
            if([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0){
                UIAlertView *tipMessage = [[UIAlertView alloc] initWithTitle:@"打开\"定位服务\"来允许\"精真估\"确定您的位置 "message:@"精真估需要知道您所在的城市" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
                tipMessage.tag = 1001;
                [tipMessage show];
                
            }else{
                NSString *title = [NSString stringWithFormat:@"打开\"定位服务\"来允许\"精真估\"确定您的位置"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:@"精真估需要知道您所在的城市" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
                alert.tag =1002;
                [alert show];
                
            }
            
        }
        
        
        locationStr(nil,nil);
    }
    else
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        locationManager.distanceFilter = 10.0f;
        if (iOS8) {
            [locationManager requestWhenInUseAuthorization];
        }
        [locationManager startUpdatingLocation];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
            return;
        }else
        {
            return;
        }
        
    }else if (alertView.tag == 1002)
    {
        if (buttonIndex != alertView.cancelButtonIndex) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
            return;
        }else
        {
            return;
        }
        
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    locationStr(nil,nil);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [locationManager stopUpdatingLocation];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    CLLocation *location = locations[0];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error != nil){
            [MBProgressHUD showError:@"没有获取到您的位置，请手动选择" toView:WINDOW];
            locationStr(nil,nil);
        }
        else
        {
            CLPlacemark *placemark = [placemarks firstObject];
            [self getAreaCityIDWithPlaceName:placemark.addressDictionary];
        }
    }];
}


/**根据定位获取的地址获取数据库中对应的省市id*/
- (void)getAreaCityIDWithPlaceName:(NSDictionary *)placemark
{
    //省
    NSString *stateName = [placemark objectForKey:@"State"];
    NSRange range = [stateName rangeOfString:@"省"];
    if (range.length == 1)
    {  //去掉“省”
        stateName = [stateName substringToIndex:range.location];
    }
    
    range = [stateName rangeOfString:@"市"];
    if (range.length == 1) {
        stateName = [stateName substringToIndex:range.location];
    }
    
    //市
    NSString *cityName = [placemark objectForKey:@"City"];
    range = [cityName rangeOfString:@"市"];
    if (range.length == 1)
        //去掉“市”
        cityName = [cityName substringToIndex:range.location];
    
    
    //    if (IOS_VERSION<7.0) {
    //        if (cityName == nil)//直辖市没有City字段，取“区”字段
    //            cityName = [placemark objectForKey:@"SubLocality"];
    //    }else{ //iOS7不存在没有city字段的情况，
    //        cityName = [placemark objectForKey:@"SubLocality"];
    ////        cityName = stateName;
    //    }
    locationStr(stateName,cityName);
}

#pragma mark 创建分享弹出视图

+(void)reloadDic:(NSMutableDictionary *)dic object:(id)object key:(NSString *)key{
    if (object) {
        [dic setObject:object forKey:key];
    }else{
        [dic setObject:@"" forKey:key];
    }
}

//#pragma mark 创建分享弹出视图
//-(void)createShareBtnView:(NSString *)shareText urlStr:(NSString *)urlStr weiXinTitle:(NSString *)weiXinTitle weiXinText:(NSString *)weiXinText
//                  msgText:(NSString *)msgText subControoler:(UIViewController *)subController picUrl:(NSData *)picData{
//    //收集分享所需要的参数
//    shareDic =[NSMutableDictionary dictionary];
//    [CommonMethods reloadDic:shareDic object:shareText key:@"friendText"];
//    [CommonMethods reloadDic:shareDic object:urlStr key:@"url"];
//    [CommonMethods reloadDic:shareDic object:weiXinTitle key:@"weiXinTitle"];
//    [CommonMethods reloadDic:shareDic object:weiXinText key:@"weiXinText"];
//    [CommonMethods reloadDic:shareDic object:msgText key:@"msgText"];
//    [CommonMethods reloadDic:shareDic object:subController key:@"subController"];
//    
//    //图片URL
//    [CommonMethods reloadDic:shareDic object:picData key:@"picData"];
//    
//    
//    //对分享视图进行初始化
//    shareView = [[JZGShareView alloc]init];
//    shareView.y = subController.view.height;
//    shareView.width = subController.view.width;
//    shareView.delegate = self;
//    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
//}
//
///**重新设置shareView高度*/
//- (void)shareViewDidLayoutSubviews:(CGFloat)shareViewHeight
//{
//    shareView.height = shareViewHeight;
//    [UIView animateWithDuration:kANIMATEDURATION animations:^{
//        shareView.y = SCREEN_HEIGHT-shareView.height;
//    }];
//}
//
///**分享按钮点击事件*/
//- (void)shareButtonDidClickWithTag:(NSInteger)tag
//{
//    NSString *shareTitle= [shareDic objectForKey:@"friendText"];
//    NSString *shareText ;
//    //    NSData *imgData = UIImagePNGRepresentation([UIImage imageNamed:@"appIcon108*108"]);
//    //    NSURL* picUrl = [NSURL URLWithString:[shareDic objectForKey:@"picUrl"]];
//    NSData *imgData = [NSData dataWithData:[shareDic objectForKey:@"picData"]];
//    
//    NSString *shareUrl = [shareDic objectForKey:@"url"];
//    NSString *snsName;
//    switch (tag)
//    {
//        case shareType_pengYouQuan://朋友圈
//            snsName = UMShareToWechatTimeline;
//            shareText = nil;
//            break;
//        case shareType_weiXin://微信好友
//            snsName = UMShareToWechatSession;
//            shareTitle =[shareDic objectForKey:@"weiXinTitle"];
//            shareText = [shareDic objectForKey:@"msgText"];
//            break;
//        case shareType_QQ://QQ好友
//            snsName = UMShareToQQ; 
//            shareTitle =[shareDic objectForKey:@"weiXinTitle"];
//            shareText =[shareDic objectForKey:@"msgText"];;
//            break;
//        case shareType_SMS://短信
//            snsName = UMShareToSms;
//            shareText = [NSString stringWithFormat:@"%@%@",[shareDic objectForKey:@"msgText"],shareUrl];
//            imgData =nil;
//            break;
//        case shareType_SAVE://保存图片
//            snsName = UMShareToQQ;
//            shareTitle =[shareDic objectForKey:@"weiXinTitle"];
//            shareText =[shareDic objectForKey:@"msgText"];;
//            break;
//            
//        case shareType_SINA://新浪微博
//            snsName = UMShareToSina;
//            shareText =[NSString stringWithFormat:@"%@\n%@",[shareDic objectForKey:@"msgText"],shareUrl];
//            break;
//        case shareType_QQZONE://QQ空间
//            snsName = UMShareToQzone;
//            shareTitle =[shareDic objectForKey:@"weiXinTitle"];
//            shareText =[NSString stringWithFormat:@"%@\n%@",[shareDic objectForKey:@"msgText"],shareUrl];
//            break;
//        default:
//            snsName = UMShareToSms;
//            break;
//    }
//    [self shareBySNSName:snsName withTitle:shareTitle andContent:shareText andContentUrlStr:shareUrl andImage:imgData andViewController:[shareDic objectForKey:@"subController"] completion:^(BOOL success) {
//        //        if (success)
//        //            [MBProgressHUD showSuccess:@"分享成功" toView:WINDOW];
//    }];
//}

//- (void)shareBySNSName:(NSString *)snsName withTitle:(NSString *)title andContent:(NSString *)content andContentUrlStr:(NSString *)contentUrl andImage:(id)image andViewController:(UIViewController *)viewController completion:(shareCompletion)completion
//{
//    // 朋友圈
//    [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = contentUrl;
//    //
//    //    // 微信好友
//    [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = contentUrl;
//    //
//    // QQ好友
//    [UMSocialData defaultData].extConfig.qqData.title = title;
//    [UMSocialData defaultData].extConfig.qqData.url = contentUrl;
//    // QQ空间
//    [UMSocialData defaultData].extConfig.qzoneData.title = title;
//    [UMSocialData defaultData].extConfig.qzoneData.url = contentUrl;
//    
//    UMSocialUrlResource *urlResource =nil;
//    if ([snsName isEqualToString:UMShareToSina]) {
//        [[UMSocialControllerService defaultControllerService] setShareText:content shareImage:image socialUIDelegate:self];        //设置分享内容和回调对象
//        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self.shareController,[UMSocialControllerService defaultControllerService],YES);
//    } else if ([snsName isEqualToString:UMShareToQQ]) {
//        if (self.saveCom) {
//            self.saveCom();
//        }
//    }
//    else{
//        [[UMSocialDataService defaultDataService] postSNSWithTypes:@[snsName] content:content image:image location:nil urlResource:urlResource presentedController:viewController completion:^(UMSocialResponseEntity *response){
//            if (completion)
//            {
//                BOOL success = response.responseCode == UMSResponseCodeSuccess;
//                completion(success);
//            }
//        }];
//    }
//}
//
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的微博平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//        //        alert(@"umeng");
//    }
//}


@end
