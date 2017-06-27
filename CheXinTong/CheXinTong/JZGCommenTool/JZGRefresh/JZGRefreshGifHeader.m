//
//  JZGRefreshGifHeader.m
//  JZGDetectionPlatform
//
//  Created by 杜维欣 on 15/12/25.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGRefreshGifHeader.h"

@implementation JZGRefreshGifHeader

- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_loading_%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    [self setImages:idleImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:idleImages forState:MJRefreshStateRefreshing];
}

@end
