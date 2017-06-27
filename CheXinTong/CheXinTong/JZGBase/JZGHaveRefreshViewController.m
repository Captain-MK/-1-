//
//  PLHaveRefreshViewController.m
//  PLTP_M_CARRIERS
//
//  Created by Lucas on 1/20/15.
//  Copyright (c) 2015 Jack. All rights reserved.
//

#import "JZGHaveRefreshViewController.h"
#import "JZGRefreshGifHeader.h"
#import "JZGRefreshGifFooter.h"

@interface JZGHaveRefreshViewController (){
  
}

@end

@implementation JZGHaveRefreshViewController
@synthesize currentPage = _currentPage;
@synthesize requestType = _requestType;

- (id)init{
    self = [super init];
    if (self) {
        _currentPage = 1;
        _requestType = REQUEST_REFRESH;
        _sourceType = PLHaveRefreshSourceTypeAll;
    }
    return self;
}

- (id)initWithSourceType:(PLHaveRefreshSourceType)sourceType{
    self = [self init];
    if (self) {
        _currentPage = 1;
        _requestType = REQUEST_REFRESH;
        _sourceType = sourceType;
    }
    
    return self;
}
- (void)setRequestType:(RequestType)requestType{
    _requestType = requestType;
    if (_requestType == REQUEST_REFRESH) {
        _currentPage = 1;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_sourceType == PLHaveRefreshSourceTypeAll)
    {
        [self addHeader];
        [self addFooter];
    }
    else if (_sourceType == PLHaveRefreshSourceTypeHeader){
        [self addHeader];
    }
    else if (_sourceType == PLHaveRefreshSourceTypeFooter){
        [self addFooter];
    }

}

#pragma custom method

- (void)addHeader{
    // 下拉刷新
    WS(weakSelf);
    
//    [self scrollViewContainer].mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        weakSelf.requestType = REQUEST_REFRESH;
//        weakSelf.currentPage = 1;
//        [weakSelf headBeginRefreshing:[self scrollViewContainer].mj_header];
//    }];
    
    [self scrollViewContainer].mj_header = [JZGRefreshGifHeader headerWithRefreshingBlock:^{
        weakSelf.requestType = REQUEST_REFRESH;
        weakSelf.currentPage = 1;
        [weakSelf headBeginRefreshing];
    }];
}

- (void)addFooter{
    WS(weakSelf);
    
//    [self scrollViewContainer].mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        weakSelf.requestType = OPERATE_LOADINGMORE;
//        weakSelf.currentPage++;
//        [weakSelf footerBeginRefreshing:[weakSelf scrollViewContainer].mj_footer];
//    }];
    
    [self scrollViewContainer].mj_footer = [JZGRefreshGifFooter footerWithRefreshingBlock:^{
        weakSelf.requestType = OPERATE_LOADINGMORE;
        weakSelf.currentPage++;
        [weakSelf footerBeginRefreshing];
    }];
}

- (void)stopRefresh{
    if (_requestType == REQUEST_REFRESH) {
        [[self scrollViewContainer].mj_header endRefreshing];
    }
    else{
        [[self scrollViewContainer].mj_footer endRefreshing];
    }
}

- (UIScrollView *)scrollViewContainer{
    return nil;
}

- (void)footerBeginRefreshing{
}

- (void)headBeginRefreshing{
}



#pragma 点击按钮自动开始刷新
- (void)headerAutomaticRefresh{
    [[self scrollViewContainer].mj_header beginRefreshing];
}

- (void)footerAutomaticRefresh{
    [[self scrollViewContainer].mj_footer beginRefreshing];
}

@end
