//
//  UIView+JZGAdd.h
//  JZGDetectionPlatform
//
//  Created by cuik on 16/3/30.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (JZGAdd)

#pragma mark - Base
#pragma mark -
/** 添加单击事件*/
- (void)addTapAction:(id)target selector:(SEL)selector;

/** 添加长按事件*/
- (void)addLongPressAction:(id)target selector:(SEL)selector;

/** 返回所在控制器*/
- (UIViewController *)viewController;

/** 设置圆角*/
- (void)setCornerRadius:(CGFloat)cornerRadius;

/** 基于位图返回UIImage*/
- (UIImage *)screenShotImage;

#pragma mark - 使用.x.y等设置frame
#pragma mark -
/**
 *  注意此处：利用编译器生成了getter 和 setter方法，.m中会复写
 *          不会真实使用以下这些属性
 */
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;

//center
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;

//left top right bottom
@property (nonatomic, readonly) CGFloat left;
@property (nonatomic, readonly) CGFloat top;
@property (nonatomic, readonly) CGFloat right;
@property (nonatomic, readonly) CGFloat bottom;

- (void)setViewLeft:(CGFloat)x;
- (void)setViewTop:(CGFloat)y;
- (void)setViewWidth:(CGFloat)width;
- (void)setViewHeight:(CGFloat)height;
/**
 *  为试图添加圆角
 *
 *  @param radius 圆角度数 用layout无效 
 */
- (void)addCornerMaskLayerWithRadius:(CGFloat)radius;


#pragma mark - UIView各种缺省的view

/**
 *  显示
 *
 *  @param tip 提示内容
 */
- (void)show:(NSString*)tip;

/**
 *  显示
 *
 *  @param tip   提示内容
 *  @param viewY view的y
 */
- (void)show:(NSString *)tip viewY:(CGFloat)viewY;

/**
 *  显示
 *
 *  @param attriString 提示内容
 */
- (void)showAttributedText:(NSMutableAttributedString*)attriString;

/**
 *  显示
 *
 *  @param attriString 提示内容
 *  @param viewY       view的y
 */
- (void)showAttributedText:(NSMutableAttributedString *)attriString viewY:(CGFloat)viewY;

/**
 *  隐藏
 */
- (void)hide;

- (void)showEmptyStr:(NSString *)str;

/**
 *  高度动画
 *
 *  @param height   目标高度
 *  @param duration 动画时间
 */
- (void)animateHeight:(CGFloat)height duration:(NSTimeInterval)duration;
@end
