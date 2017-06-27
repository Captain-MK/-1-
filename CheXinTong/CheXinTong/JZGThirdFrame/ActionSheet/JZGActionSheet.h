//
//  JZGActionSheet.h
//  Guye.bjxd
//
//  Created by Mars on 15/5/15.
//  Copyright (c) 2015年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JZGActionSheetClickOnButtonIndexBlock)(NSInteger index);
typedef void(^JZGActionSheetClickOnDestructiveBlock)();
typedef void (^JZGActionSheetClickOnCancelBlock)();

@protocol JZGActionSheetDelegate <NSObject>
- (void)didClickOnButtonIndex:(NSInteger )buttonIndex;
@optional
- (void)didClickOnDestructiveButton;
- (void)didClickOnCancelButton;
@end

@interface JZGActionSheet : UIView

@property (copy, nonatomic) JZGActionSheetClickOnButtonIndexBlock actionSheetClickOnButtonIndexBlock;
@property (copy, nonatomic) JZGActionSheetClickOnDestructiveBlock actionSheetClickOnDestructiveBlock;
@property (copy, nonatomic) JZGActionSheetClickOnCancelBlock      actionSheetClickOnCancelBlock;

//- (id)initWithTitle:(NSString *)title delegate:(id<JZGActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitlesArray;

- (id)initWithTitle:(NSString *)title delegate:(id<JZGActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitlesArray otherButtonImages:(NSArray *)otherButtonImageArray;

- (void)showInView:(UIView *)view;

@end
