//
//  UITableView+JZG.m
//  JZGChryslerForPad
//
//  Created by 杜维欣 on 16/4/21.
//  Copyright © 2016年 Beijing JingZhenGu Information Technology Co.Ltd. All rights reserved.
//

#import "UITableView+JZG.h"
#import <objc/runtime.h>

const char DwxHideSectionKey;
const char DwxDefaultCellHeigtKey;

@implementation UITableView (JZG)

- (void)dwx_hideSection:(NSInteger)section {
    if ([self.dwx_hideSections containsIndex:section]) {
        [self.dwx_hideSections removeIndex:section];
    } else {
        [self.dwx_hideSections addIndex:section];
    }
    [self reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
}

- (NSMutableIndexSet *)dwx_hideSections {
    NSMutableIndexSet *set = objc_getAssociatedObject(self, &DwxHideSectionKey);
    if (set == nil) {
        set = [NSMutableIndexSet indexSet];
        objc_setAssociatedObject(self, &DwxHideSectionKey, set, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return set;
}

- (CGFloat)dwx_defaultCellHeigt {
    return [objc_getAssociatedObject(self, &DwxDefaultCellHeigtKey) floatValue];
}

- (void)setDwx_defaultCellHeigt:(CGFloat)dwx_defaultCellHeigt {
    objc_setAssociatedObject(self, &DwxDefaultCellHeigtKey, @(dwx_defaultCellHeigt), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)dwx_configSectionHeightInSection:(NSInteger)section {
    if ([self.dwx_hideSections containsIndex:section]) {
        return 0;
    } else {
        return self.dwx_defaultCellHeigt;
    }
}
@end
