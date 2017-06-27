//
//  PLBasePopView.h
//  PLTP_M_CARRIERS
//
//  Created by Lucas on 14/12/11.
//  Copyright (c) 2014年 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  弹出视图根视图
 */
@interface JZGBasePopView : UIView

/**
 *  弹出浮层
 */
@property(nonatomic,retain) UIView                  *popView;

/**
 *  返回弹出视图的size
 *
 *  @return 弹出视图的size
 */
- (CGSize)popViewSize;

/**
 *  弹出视图，子类如有需求可重写该方法
 */
-(void)popViewDidAppear;

/**
 *  隐藏弹出视图，子类如有需求可重写该方法
 */
- (void)popViewDidDisAppear;

@end
