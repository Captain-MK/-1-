//
//  JZGSolidCircleView.m
//  JingZhenGu
//
//  Created by Mars on 15/12/16.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGSolidCircleView.h"

@implementation JZGSolidCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    CGPathRef path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0f) radius:1 startAngle:0 endAngle:2 * M_PI clockwise:1].CGPath;
    layer.fillColor = self.circleColor.CGColor;
    [self.layer addSublayer:layer];
    layer.path = path;
    
    CGPathRef endpath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0f) radius:self.bounds.size.width / 2.0f startAngle:0 endAngle:2 * M_PI clockwise:1].CGPath;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.toValue = (__bridge id _Nullable)(endpath);
    animation.duration = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [layer addAnimation:animation forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self createLael];
    });
}

- (void)createLael
{
    UILabel * label = [[UILabel alloc] initWithFrame:self.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    if ([self.model.text floatValue] == 0) {
        label.text = @"--";
    }else
        label.text = self.model.text;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];
}

- (void)drawText
{
    UIFont *font = [UIFont systemFontOfSize:15.0f];
    
    /// 创建默认样式
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// 设置线样式
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    /// 对其方式
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSParagraphStyleAttributeName: paragraphStyle,
                                  NSForegroundColorAttributeName:self.textColor,
                                  //                                  NSStrokeWidthAttributeName:@0,
                                  NSStrokeColorAttributeName: self.textColor
                                  };
    
    CGRect textRect = CGRectMake(0, self.bounds.size.width/2.0f - 10, self.bounds.size.width, 20);
    
    [self.model.text drawInRect:textRect withAttributes:attributes];
    
}

//覆盖drawRect方法，你可以在此自定义绘画和动画
- (void)drawRect1:(CGRect)rect
{
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor (context,  [[self.model.attArray objectAtIndex:0] floatValue], [[self.model.attArray objectAtIndex:1] floatValue], [[self.model.attArray objectAtIndex:2] floatValue], [[self.model.attArray objectAtIndex:3] floatValue]);//设置填充颜色
    //填充圆，无边框
    CGContextAddArc(context, self.bounds.size.width/2.0f, self.bounds.size.height/2.0f, self.bounds.size.width/2.0f, 0, 2*PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathEOFill);//绘制填充
    
    UIFont *font = [UIFont systemFontOfSize:15.0f];
    
    /// 创建默认样式
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// 设置线样式
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    /// 对其方式
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSParagraphStyleAttributeName: paragraphStyle,
                                  NSForegroundColorAttributeName:self.textColor,
                                  //                                  NSStrokeWidthAttributeName:@0,
                                  NSStrokeColorAttributeName: self.textColor
                                  };
    
    CGRect rect1 = CGRectMake(0, self.bounds.size.width/2.0f - 10, self.bounds.size.width, 20);
    
    [self.model.text drawInRect:rect1 withAttributes:attributes];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
