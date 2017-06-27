//
//  CWTableItemOverLayView.m
//  CWZA
//
//  Created by alex on 8/20/15.
//  Copyright (c) 2015 alex. All rights reserved.
//

#import "MCTableItemOverLayView.h"

@implementation MCTableItemOverLayView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return [self.delegate overLayView:self didHitPoint:point withEvent:event];
}

@end
