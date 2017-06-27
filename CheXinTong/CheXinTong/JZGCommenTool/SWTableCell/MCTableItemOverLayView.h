//
//  CWTableItemOverLayView.h
//  CWZA
//
//  Created by alex on 8/20/15.
//  Copyright (c) 2015 alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCTableItemOverLayView;

@protocol MCOverLayViewDelegate <NSObject>

- (UIView *)overLayView:(MCTableItemOverLayView *)view didHitPoint:(CGPoint)point withEvent:(UIEvent *)event;

@end

@interface MCTableItemOverLayView : UIView

@property (nonatomic, strong)id<MCOverLayViewDelegate> delegate;

@end
