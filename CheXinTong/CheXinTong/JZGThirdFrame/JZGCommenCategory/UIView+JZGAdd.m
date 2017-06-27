//
//  UIView+JZGAdd.m
//  JZGDetectionPlatform
//
//  Created by cuik on 16/3/30.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import "UIView+JZGAdd.h"

@implementation UIView (JZGAdd)

#pragma mark - Base

- (void)addTapAction:(id)target selector:(SEL)selector
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)addLongPressAction:(id)target selector:(SEL)selector
{
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:selector];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:recognizer];
}

- (UIViewController *)viewController
{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (UIImage *)screenShotImage{
    if (!self) {
        return nil;
    }
    
    CGSize resultImageSize = CGSizeMake(self.width, self.height);;
    
    UIGraphicsBeginImageContextWithOptions(resultImageSize, YES, 0);
    [[self layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}


#pragma mark - 使用.x.y等设置frame

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}


-(void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(CGFloat)centerX {
    return self.center.x;
}

-(void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

-(CGFloat)centerY {
    return self.center.y;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setViewLeft:(CGFloat)x
{
    self.frame = CGRectMake(x, self.top, self.width, self.height);
}

- (void)setViewTop:(CGFloat)y
{
    self.frame = CGRectMake(self.left, y, self.width, self.height);
}

- (void)setViewWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.left, self.top, width, self.height);
}

- (void)setViewHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.left, self.top, self.width, height);
}


- (void)addCornerMaskLayerWithRadius:(CGFloat)radius
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                       byRoundingCorners:UIRectCornerAllCorners
                                             cornerRadii:CGSizeMake(radius, radius)]
    .CGPath;
    self.layer.mask = layer;
}



#pragma mark - UIView各种缺省的view

- (void)show:(NSString*)tip{
    [self show:tip viewY:0.0f];
}

- (void)show:(NSString *)tip viewY:(CGFloat)viewY{
    [self hide];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, viewY, kScreenWidth, kScreenHeight-NAVIGATION_BAR_HEIGHT-viewY)];
    bgView.tag = 1;
    [self addSubview:bgView];
    
    CGSize size = [NSString sizeWithText:tip andFont:JZGFont(16) andMaxSize:CGSizeMake(kScreenWidth-20.0f, 200.0f)];
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-size.width)/2, 150.0f, size.width, size.height)];
    tipLabel.text = tip;
    tipLabel.numberOfLines = 0;
    tipLabel.font = JZGFont(16);
    tipLabel.textColor = RGBCOLOR(182, 182, 182);
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:tipLabel];
    
    [self bringSubviewToFront:bgView];
}

- (void)showAttributedText:(NSMutableAttributedString*)attriString{
    [self showAttributedText:attriString viewY:0.0f];
}

- (void)showAttributedText:(NSMutableAttributedString *)attriString viewY:(CGFloat)viewY{
    [self hide];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, viewY, kScreenWidth, kScreenHeight-NAVIGATION_BAR_HEIGHT-viewY)];
    bgView.tag = 1;
    [self addSubview:bgView];
    
    CGSize size = [NSString sizeWithText:[attriString string] andFont:JZGFont(16) andMaxSize:CGSizeMake(kScreenWidth-20.0f, 200.0f)];
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-size.width)/2, 150.0f, size.width, size.height)];
    tipLabel.numberOfLines = 0;
    tipLabel.font = JZGFont(16);
    tipLabel.textColor = RGBCOLOR(182, 182, 182);
    tipLabel.attributedText = attriString;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:tipLabel];
    [self bringSubviewToFront:bgView];
}

- (void)hide{
    UIView *bgView = (UIView*)[self viewWithTag:1];
    if (bgView) {
        [bgView removeFromSuperview];
        bgView = nil;
    }
}

- (void)showEmptyStr:(NSString *)str {
    if ([self viewWithTag:1]) {
        return;
    }
    UILabel *emptyLabel = [[UILabel alloc] init];
    emptyLabel.frame = CGRectMake(0, self.centerY  - 25, kScreenWidth, 50);
    emptyLabel.textColor = RGBCOLOR(182, 182, 182);
    emptyLabel.font = JZGFont(16);
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    emptyLabel.text = str;
    emptyLabel.tag = 1;
    [self addSubview:emptyLabel];
    [self bringSubviewToFront:emptyLabel];
}

- (void)animateHeight:(CGFloat)height duration:(NSTimeInterval)duration {
    CGRect frame = self.frame;
    frame.size.height = height;
    [UIView animateWithDuration:duration animations:^{
        self.frame = frame;
    }];
}
@end
