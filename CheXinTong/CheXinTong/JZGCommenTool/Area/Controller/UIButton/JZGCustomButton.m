//
//  JZGCustomButton.m
//  JZGAppraiserNetwork
//
//  Created by Gaowl on 15/3/11.
//  Copyright (c) 2015年 Mars. All rights reserved.
//

#import "JZGCustomButton.h"

@implementation JZGCustomButton

- (void)setHighlighted:(BOOL)highlighted{}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // 设置默认对齐方式
        self.titleHorizontalAlignment = HorizontalAlignmentCenter;
        self.imageHorizontalAlignment = HorizontalAlignmentCenter;
    }
    return self;
}

- (void)setTitleHorizontalAlignment:(HorizontalAlignment)titleHorizontalAlignment
{
    _titleHorizontalAlignment = titleHorizontalAlignment;
    [self setNeedsDisplay];
}

- (void)setImageHorizontalAlignment:(HorizontalAlignment)imageHorizontalAlignment
{
    _imageHorizontalAlignment = imageHorizontalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
   CGRect titleRect = [super titleRectForContentRect:contentRect];
    
    switch (self.titleHorizontalAlignment)
    {
        case HorizontalAlignmentLeft:
            titleRect.origin.x = 0;
            break;
        case HorizontalAlignmentRight:
            titleRect.origin.x = self.size.width - titleRect.size.width;
            break;
        case HorizontalAlignmentCenter:
        default:
            titleRect.origin.x = (self.size.width - titleRect.size.width) * 0.5;
    }
    return titleRect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect imageRect = [super imageRectForContentRect:contentRect];
    
    switch (self.imageHorizontalAlignment)
    {
        case HorizontalAlignmentLeft:
            imageRect.origin.x = 0;
            break;
        case HorizontalAlignmentRight:
            imageRect.origin.x = self.size.width - imageRect.size.width;
            break;
        case HorizontalAlignmentCenter:
        default:
            imageRect.origin.x = (self.size.width - imageRect.size.width) * 0.5;
    }
    return imageRect;
}

@end
