//
//  SWTableViewCell.h
//  SWTableViewCell
//
//  Created by Chris Wendel on 9/10/13.
//  Copyright (c) 2013 Chris Wendel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "MCCellScrollView.h"
#import "MCLongPressGestureRecognizer.h"
#import "MCUtilityButtonTapGestureRecognizer.h"
#import "NSMutableArray+MCUtilityButtons.h"

@class MCTableViewCell;

typedef NS_ENUM(NSInteger, SWCellState)
{
    kCellStateCenter = 0,
    kCellStateLeft,
    kCellStateRight,
};

@protocol MCTableViewCellDelegate <NSObject>

@optional
// click event on left utility button
- (void)mcipeableTableViewCell:(MCTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index;
// click event on right utility button
- (void)mcipeableTableViewCell:(MCTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index;
// utility button open/close event
- (void)mcipeableTableViewCell:(MCTableViewCell *)cell scrollingToState:(SWCellState)state;
// prevent multiple cells from showing utilty buttons simultaneously
- (BOOL)mcipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(MCTableViewCell *)cell;
// prevent cell(s) from displaying left/right utility buttons
- (BOOL)mcipeableTableViewCell:(MCTableViewCell *)cell canSwipeToState:(SWCellState)state;

- (void)mcipeableTableViewCellDidEndScrolling:(MCTableViewCell *)cell;
- (void)mcipeableTableViewCell:(MCTableViewCell *)cell didScroll:(UIScrollView *)scrollView;

@end

@interface MCTableViewCell : UITableViewCell

@property (nonatomic, copy) NSArray *leftUtilityButtons;
@property (nonatomic, copy) NSArray *rightUtilityButtons;

@property (nonatomic, weak) id <MCTableViewCellDelegate> delegate;

- (void)setRightUtilityButtons:(NSArray *)rightUtilityButtons WithButtonWidth:(CGFloat) width;
- (void)setLeftUtilityButtons:(NSArray *)leftUtilityButtons WithButtonWidth:(CGFloat) width;
- (void)hideUtilityButtonsAnimated:(BOOL)animated;
- (void)showLeftUtilityButtonsAnimated:(BOOL)animated;
- (void)showRightUtilityButtonsAnimated:(BOOL)animated;

- (BOOL)isUtilityButtonsHidden;

@end
