//
//  MCSlideTableView.m
//  
//
//  Created by changxiaowei on 15/10/21.
//  Copyright © 2015年 Chris Wendel. All rights reserved.
//

#import "MCSlideTableView.h"

#import "MCTableItemOverLayView.h"
#import "MCTableViewCell.h"

@interface MCSlideTableView () <MCOverLayViewDelegate>

@property (nonatomic, strong)MCTableItemOverLayView *overLayView;


@end

@implementation MCSlideTableView

- (id)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame tableViewStyle:UITableViewStylePlain];
}

- (instancetype)initWithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)style{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
        _tableView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_tableView];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        
        if (style == UITableViewStyleGrouped) {
            _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tableView.width, 0.01f)];
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor colorWithRed:0xe8/255.0 green:0xe8/255.0 blue:0xe8/255.0 alpha:1.0f];
        
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    _tableView.frame = self.bounds;
}

- (UIView *)overLayView:(MCTableItemOverLayView *)view didHitPoint:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL shoudReceivePointTouch = YES;
    CGPoint location = [self convertPoint:point fromView:view];
    CGRect rect = [self convertRect:self.activeCell.frame toView:self];
    shoudReceivePointTouch = CGRectContainsPoint(rect, location);
    if (!shoudReceivePointTouch) {
        [_activeCell hideUtilityButtonsAnimated:YES];
    }
    return (shoudReceivePointTouch) ? [self.activeCell hitTest:point withEvent:event] : view;
}

-(void)setIsStatusEditing:(BOOL)isStatusEditing {
    if (_isStatusEditing == isStatusEditing) {
        return;
    }
    
    _isStatusEditing = isStatusEditing;
    self.tableView.scrollEnabled = !isStatusEditing;
    if (isStatusEditing) {
        if (!_overLayView) {
            _overLayView = [[MCTableItemOverLayView alloc] initWithFrame:self.bounds];
            _overLayView.backgroundColor = [UIColor clearColor];
            _overLayView.delegate = self;
            [self addSubview:_overLayView];
            for (UIView *view in self.tableView.subviews) {
                if ((view.gestureRecognizers.count == 0) && view != self.activeCell && view != _overLayView) {
                    view.userInteractionEnabled = NO;
                }
            }
        }
    } else {
        if (_overLayView) {
            _overLayView.frame = CGRectZero;
            [_overLayView removeFromSuperview];
            _overLayView = nil;
            self.activeCell = nil;
            for (UIView *view in self.tableView.subviews) {
                if ((view.gestureRecognizers.count == 0) && view != self.activeCell && view != _overLayView) {
                    view.userInteractionEnabled = YES;
                }
            }
        }
    }
}

@end
