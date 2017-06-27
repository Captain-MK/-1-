//
//  NSDate+JZGAdd.h
//  JZGChryslerForPad
//
//  Created by cuik on 16/4/15.
//  Copyright © 2016年 Beijing JingZhenGu Information Technology Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDateFormatter+JZGAdd.h"

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (JZGAdd)

#pragma mark - Descrition
- (NSString *)timeIntervalDescription;//距离当前的时间间隔描述
- (NSString *)minuteDescription;/*精确到分钟的日期描述*/
- (NSString *)formattedTime;/*标准时间日期描述*/
- (NSString *)formattedDateDescription;//格式化日期描述
- (double)timeIntervalSince1970InMilliSecond;
+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;
+ (NSString *)formattedTimeFromTimeInterval:(long long)time;//时间戳转当前时间
- (NSString *)stringWithPictureFormat;

#pragma mark - Relative Dates
// Relative dates from the current date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;

#pragma mark - Comparing Dates
// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) isThisMonth;
- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;
- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;
- (BOOL) isInFuture;
- (BOOL) isInPast;

#pragma mark - Date Roles
// Date roles
- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;

#pragma mark - Adjusting Dates
// Adjusting dates
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateAtStartOfDay;

#pragma mark - Restrieving Intervals
// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

#pragma mark - Decomposing Dates
// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;


#pragma mark jzg

/**
 *  得到当前时间的时间戳,13位毫秒级
 *
 *
 *  @return 得到时间戳字符串
 */
+(NSString*)getCurrentTime;

/**
 *  NSDate时间转换为13位毫秒级时间戳
 *
 *  @param date 时间
 *
 *  @return 13位毫秒级时间戳
 */
+ (NSString *)convertTimeStampWithDate:(NSDate *)date;

/**
 *  NSDate类型时间转换为需要显示的时间字符串
 *
 *  @param date NSDate类型时间
 *  @param str  日期格式 如：yyyy年MM月dd日
 *
 *  @return 得到相应的时间字符串
 */
+ (NSString *)stringWithDate:(NSDate *)date formatterString:(NSString *)str;


/**
 *  时间戳字符串转换为需要的时间字符串
 *
 *  @param timeString 时间戳 13位毫秒级
 *  @param str        日期格式 如：yyyy年MM月dd日
 *
 *  @return 得到相应的时间字符串
 */
+ (NSString *)stringWithDateString:(NSString *)timeString formatterString:(NSString *)str ;

/**
 *  项目使用，根据该日期返回一个字符串
 *  当天显示：12：35；
 *  前一天显示：昨天；
 *  除当天和昨天的今年日期：7月6日
 *  今年之前的日期：2014年1月23日
 *  @return 返回字符串
 */
- (NSString *)convertNSDate2String;

/**
 *  得到当前formatter格式的时间
 *
 *  @param timeString 时间字符串
 *  @param formatter  时间格式,必须是yyyy-MM-dd HH:mm:ss
 *
 *  @return 当前formatter格式的时间
 */
+ (NSString *)getDateString:(NSString *)timeString formatter:(NSString *)formatter;

/**
 *  日期根式 yyyy-MM-dd  精确到日  判断字符串所表达的日期是不是早于今天
 *
 *  @param dateString 字符串 @"2016-07-13"
 *
 *  @return 是否早于今天
 */
+ (BOOL)isEarlierThanTodayBydateString:(NSString *)dateString;


@end
