//
//  PLBasePopView.m
//  PLTP_M_CARRIERS
//
//  Created by Lucas on 14/12/11.
//  Copyright (c) 2014年 Lucas. All rights reserved.
//

#import "JZGBasePopView.h"

@implementation JZGBasePopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight);
        [JZGAppDelegate.window addSubview:self];
        
        //颜色变暗处的视图
        UIControl *darkView = [[UIControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight)];
        darkView.tag = 1;
        darkView.alpha = 0.0;
        [darkView addTarget:self action:@selector(popViewDidDisAppear) forControlEvents:UIControlEventTouchUpInside];
        darkView.backgroundColor = [UIColor blackColor];
        [self addSubview:darkView];
        
        _popView = [[UIView alloc] init];
        _popView.size = [self popViewSize];
        _popView.centerX = self.centerX;
        _popView.y = kScreenHeight;
        _popView.layer.cornerRadius = 15;
        _popView.layer.masksToBounds = YES;
        _popView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_popView];
    }
    return self;
}

- (CGSize)popViewSize {
    return CGSizeMake(kScreenWidth / 2, kScreenHeight / 2);
}

-(void)popViewDidAppear{
    [UIView animateWithDuration:0.5 animations:^{
        _popView.y = (kScreenHeight - [self popViewSize].height) / 2;
        UIView *darkView = (UIView*)[self viewWithTag:1];
        darkView.alpha = 0.4;
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
    }];
}

-(void)popViewDidDisAppear{
    [UIView animateWithDuration:0.5 animations:^{
        _popView.y = kScreenHeight;
        UIView *darkView = (UIView*)[self viewWithTag:1];
        darkView.alpha = 0.0;
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
