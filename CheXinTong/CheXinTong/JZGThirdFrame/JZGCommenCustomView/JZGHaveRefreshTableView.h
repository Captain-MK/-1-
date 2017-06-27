//
//  PLHaveRefreshTableView.h
//  PLTP_I_CARRIERS
//
//  Created by Lucas on 15/6/4.
//  Copyright (c) 2015年 Stay hungry, stay foolish.. All rights reserved.
//

#import "JZGTableView.h"

@class JZGHaveRefreshTableView;

@protocol JZGHaveRefreshTableViewDelegate <NSObject>

@optional
/**
 *  footer开始刷新执行的方法（写刷新逻辑）
 */
- (void)refreshTableView:(JZGHaveRefreshTableView *)tableView footerBeginRefreshing:(UIView *)footView;

/**
 *  header开始刷新执行的方法（写刷新逻辑）
 */
- (void)refreshTableView:(JZGHaveRefreshTableView *)tableView headBeginRefreshing:(UIView *)headView;

@end


@interface JZGHaveRefreshTableView : JZGTableView
{
    @package
    NSUInteger  _currentPage;
    RequestType _requestType;
}

@property (nonatomic,assign)RequestType requestType;
@property (nonatomic,assign)NSUInteger  currentPage;

@property (nonatomic,assign)PLHaveRefreshSourceType sourceType;

// 上拉下拉刷代理
@property (nonatomic,assign)id <JZGHaveRefreshTableViewDelegate>refreshDelegate;

/**
 *  初始化，sourceType:指定显示的内容
 *
 */
- (id)initWithFrame:(CGRect)frame sourceType:(PLHaveRefreshSourceType)sourceType;

/**
 *  停止刷新
 */
- (void)stopRefresh;



#pragma 点击按钮自动开始刷新
/**
 *  footer自动开始刷新执行的方法
 */
- (void)footerAutomaticRefresh;

/**
 *  header自动开始刷新执行的方法
 */
- (void)headerAutomaticRefresh;


@end
