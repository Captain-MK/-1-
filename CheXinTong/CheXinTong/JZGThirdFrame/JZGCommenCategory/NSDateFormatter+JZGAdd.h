//
//  NSDateFormatter+JZGAdd.h
//  JZGChryslerForPad
//
//  Created by cuik on 16/4/15.
//  Copyright © 2016年 Beijing JingZhenGu Information Technology Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (JZGAdd)

+ (id)dateFormatter;

+ (id)dateFormatterWithFormat:(NSString *)dateFormat;

+ (id)defaultDateFormatter;/*yyyy-MM-dd HH:mm:ss*/

@end
