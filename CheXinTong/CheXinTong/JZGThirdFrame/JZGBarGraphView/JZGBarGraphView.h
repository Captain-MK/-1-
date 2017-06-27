//
//  JZGBarGraphView.h
//  JingZhenGu
//  柱状图
//  Created by Mars on 15/5/20.
//  Copyright (c) 2015年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZGEmptyView.h"

@protocol GraphRefreshSuccessDelegate <NSObject>

- (void)graphRefreshSuccess;

@end

@interface JZGBarGraphView : UIView<UIScrollViewDelegate>

/**scrollView视图*/
@property (nonatomic, strong) UIScrollView *scrollerView;
/**标题数据*/
@property (nonatomic, strong) NSMutableArray *titleArray;
/**柱状图数据*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/**刷新数据代理*/
@property (nonatomic, assign) id <GraphRefreshSuccessDelegate> refreshDelegate;
/**无数据视图*/
@property (nonatomic, strong) JZGEmptyView *emptyView;
/**柱状图宽度*/
@property (nonatomic, assign) float barWidth;
@property (nonatomic,assign) BOOL notShowEmptyView;
/**
 *  生成柱状视图
 *
 *  @param rect 柱状图frame
 *
 *  @return 返回柱状图视图
 */
+ (instancetype)viewWithBarGraphView:(CGRect)rect;

/**
 *  创建柱状图视图
 *
 *  @param unitTitle 标题
 */
- (void)createOptionView:(NSString *)unitTitle;

/**
 *  刷新柱状图
 *
 *  @param dataArray  数据数组
 *  @param titleArray 标题数组
 *  @param unitTitle  单位
 */
- (void)refreshBarGraphWithData:(NSArray *)dataArray titleArray:(NSArray *)titleArray unitTitle:(NSString *)unitTitle;

@end
