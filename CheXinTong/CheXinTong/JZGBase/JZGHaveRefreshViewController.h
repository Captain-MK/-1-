//
//  PLHaveRefreshViewController.h
//  PLTP_M_CARRIERS
//
//  Created by Lucas on 1/20/15.
//  Copyright (c) 2015 Jack. All rights reserved.
//

#import "JZGBaseViewController.h"

@interface JZGHaveRefreshViewController : JZGBaseViewController{
    @package
    NSUInteger  _currentPage;
    RequestType _requestType;
}

@property (nonatomic,assign)RequestType requestType;
@property (nonatomic,assign)NSUInteger  currentPage;

@property (nonatomic,assign)PLHaveRefreshSourceType sourceType;

/**
 *  初始化，sourceType:指定显示的内容
 *
 */
- (id)initWithSourceType:(PLHaveRefreshSourceType)sourceType;

/**
 *  子类必须重写此方法，否则会崩溃，返回要添加上拉和下拉刷新的scrollView
 *
 */
- (UIScrollView *)scrollViewContainer;

/**
 *  停止刷新
 */
- (void)stopRefresh;

/**
 *  footer开始刷新后执行的方法,子类需重写，父类不执行任何操作（写刷新逻辑）
 */
- (void)footerBeginRefreshing;

/**
 *  header开始刷新后执行的方法,子类需重写，父类不执行任何操作（写刷新逻辑）
 */
- (void)headBeginRefreshing;




#pragma 点击按钮自动开始刷新
/**
 *  自动开始header刷新
 */
- (void)headerAutomaticRefresh;

/**
 *  自动开始footer刷新
 */
- (void)footerAutomaticRefresh;

@end
