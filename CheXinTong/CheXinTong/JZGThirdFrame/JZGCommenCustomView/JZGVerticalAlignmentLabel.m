//
//  JZGVerticalAlignmentLabel.m
//  JingZhenGu
//
//  Created by Mars on 15/12/11.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGVerticalAlignmentLabel.h"

@implementation JZGVerticalAlignmentLabel

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        // 设置默认对齐方式
        self.verticalAlignment = VerticalAlignmentMiddle;
    return self;
}

- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment
{
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment)
    {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect
{
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end
