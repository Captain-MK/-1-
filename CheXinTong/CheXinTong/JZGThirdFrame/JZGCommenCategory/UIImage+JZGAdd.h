//
//  UIImage+JZGAdd.h
//  JZGDetectionPlatform
//
//  Created by cuik on 16/3/30.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (JZGAdd)


#pragma mark - 图片处理
/**
 *  返回一张拉伸不变形的图片
 *
 *  @param name 图片名称
 */
+ (UIImage *)resizableImage:(NSString *)name;

/**
 *  在一个View上截图
 *
 *  @param view 目标View
 *  @param rect 需要截取的范围
 */
+ (UIImage *)imageByScreenshotsWithView:(UIView *)view andRect:(CGRect)rect;

/**
 *  保持原来的长宽比，生成一个缩略图
 *  @param asize 需要的长、宽
 *
 */
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;

/**
 *  路径
 *
 *  @param name 图片名
 *
 *  @return 图片
 */
+ (UIImage *)cacheImageWithName:(NSString *)name;


#pragma mark - 图片压缩

/**
 *  对图片进行偏转、等比例缩放
 *
 *  @param image 传入的图片
 *  @param size  CGSize
 *
 *  @return 得到新的图片
 */
+ (UIImage*)imageCompression:(UIImage*)image size:(CGSize)size;


#pragma mark - 创建纯色的image

+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 *  图片方向矫正
 *
 *  @param image <#image description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)fixOrientation:(UIImage*)image;
/**
 *  压缩到指定宽度
 *
 *  @param sourceImage 原图
 *  @param targetWidth 目标宽度
 *
 *  @return 压缩后图片
 */
+ (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth;
/**
 *  获得某个像素的颜色
 *
 *  @param point 像素点的位置
 */
//- (UIColor *)pixelColorAtLocation:(CGPoint)point;

- (UIImage*)transformWidth:(CGFloat)width

                    height:(CGFloat)height;
@end
