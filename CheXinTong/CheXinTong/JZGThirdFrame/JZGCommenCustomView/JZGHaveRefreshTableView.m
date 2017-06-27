//
//  PLHaveRefreshTableView.m
//  PLTP_I_CARRIERS
//
//  Created by Lucas on 15/6/4.
//  Copyright (c) 2015年 Stay hungry, stay foolish.. All rights reserved.
//

#import "JZGHaveRefreshTableView.h"
#import "JZGRefreshGifHeader.h"
#import "JZGRefreshGifFooter.h"

@implementation JZGHaveRefreshTableView{
    
}

- (id)init{
    self = [super init];
    if (self) {
        _currentPage = 1;
        _requestType = REQUEST_REFRESH;
        _sourceType = PLHaveRefreshSourceTypeAll;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame sourceType:PLHaveRefreshSourceTypeAll];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _currentPage = 1;
        _requestType = REQUEST_REFRESH;
        _sourceType = PLHaveRefreshSourceTypeAll;
        
        [self addHeader];
        [self addFooter];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame sourceType:(PLHaveRefreshSourceType)sourceType{
    self = [super initWithFrame:frame];
    if (self) {
        _sourceType = sourceType;
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
        
        _currentPage = 1;
        _requestType = REQUEST_REFRESH;
    }
    
    return self;
}

#pragma custom method

- (void)addHeader{
    // 下拉刷新
    WS(weakSelf);
    
//    self.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        weakSelf.requestType = REQUEST_REFRESH;
//        weakSelf.currentPage = 1;
//        [weakSelf headerBeginRefresh];
//    }];
 
    self.mj_header= [JZGRefreshGifHeader headerWithRefreshingBlock:^{
        weakSelf.requestType = REQUEST_REFRESH;
        weakSelf.currentPage = 1;
        [weakSelf headerBeginRefresh];
    }];
}

- (void)addFooter{
    WS(weakSelf);
    
//    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        weakSelf.requestType = OPERATE_LOADINGMORE;
//        weakSelf.currentPage++;
//        [weakSelf footerBeginRefresh];
//    }];
    
    self.mj_footer = [JZGRefreshGifFooter footerWithRefreshingBlock:^{
        weakSelf.requestType = OPERATE_LOADINGMORE;
        weakSelf.currentPage++;
        [weakSelf footerBeginRefresh];
    }];
}

- (void)stopRefresh{
    if (_requestType == REQUEST_REFRESH) {
        [self.mj_header endRefreshing];
    }
    else{
        [self.mj_footer endRefreshing];
    }
}

- (void)headerBeginRefresh{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:headBeginRefreshing:)]) {
        [self.refreshDelegate refreshTableView:self headBeginRefreshing:self.mj_header];
    }
}

- (void)footerBeginRefresh{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:footerBeginRefreshing:)]) {
        [self.refreshDelegate refreshTableView:self footerBeginRefreshing:self.mj_footer];
    }
}



#pragma 点击按钮自动开始刷新
- (void)footerAutomaticRefresh{
    [self.mj_footer beginRefreshing];
}

- (void)headerAutomaticRefresh{
    [self.mj_header beginRefreshing];
}


@end
