//
//  UITableView+JZG.h
//  JZGChryslerForPad
//
//  Created by 杜维欣 on 16/4/21.
//  Copyright © 2016年 Beijing JingZhenGu Information Technology Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (JZG)

@property (nonatomic,assign)CGFloat dwx_defaultCellHeigt;

- (void)dwx_hideSection:(NSInteger)section;

- (NSMutableIndexSet *)dwx_hideSections;

- (CGFloat)dwx_configSectionHeightInSection:(NSInteger)section;

@end
