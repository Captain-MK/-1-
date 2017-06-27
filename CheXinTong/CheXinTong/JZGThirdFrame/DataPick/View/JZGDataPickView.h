//
//  JZGDataPickView.h
//  JingZhenGu
//
//  Created by liuqt on 15/12/17.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JZGDatePickerViewDelegate <NSObject>
/**
 *  返回选中的年份和月份索引
 *
 *  @param yearIndex  年份index
 *  @param monthIndex 月份index
 */
- (void)datePickerViewSelectYearIndex:(NSInteger)yearIndex monthIndex:(NSInteger)monthIndex handleType:(HandleType)handleType;

@optional
/**
 *  返回当前选中的年份
 *
 *  @param yearIndex 年份index
 */
- (void)datePickerViewSelectYearIndex:(NSInteger)yearIndex handleType:(HandleType)handleType;

- (void)datePickerViewSelectYearIndex:(NSInteger)yearIndex monthIndex:(NSInteger)monthIndex dayIndex:(NSInteger)dayIndex handleType:(HandleType)handleType;
@end

@interface JZGDataPickView : UIView
@property (nonatomic,weak) id<JZGDatePickerViewDelegate>delegate;
/// 提示文字
@property(nonatomic, copy) NSString *title;
/// 年份
@property(nonatomic, strong) NSArray *yearData;
/// 月份
@property(nonatomic, strong) NSArray *monthData;
@property(nonatomic, strong) NSArray *dayData;

@property (nonatomic,assign)HandleType handleType;

/// 默认选中的月份Index
@property(nonatomic, assign) NSInteger defaultSelectedMonthIndex;
- (id)initWithFrame:(CGRect)frame title:(NSString *)title handleType:(HandleType)handType ;
//@property (nonatomic,copy) NSString *threeComponent;
@end
