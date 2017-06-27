//
//  MCSlideTableView.h
//
//
//  Created by changxiaowei on 15/10/21.
//  Copyright © 2015年 Chris Wendel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCTableViewCell;
@interface MCSlideTableView : UIView


@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong)MCTableViewCell *activeCell;

@property (nonatomic, assign)BOOL isStatusEditing;


/**
 *  初始化一个singleTableView
 *
 *  @param frame 视图位置及大小
 *  @param style tableView的风格
 */
- (instancetype)initWithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)style;
@end

