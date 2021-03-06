//
//  NSMutableArray+SWUtilityButtons.h
//  SWTableViewCell
//
//  Created by Matt Bowman on 11/27/13.
//  Copyright (c) 2013 Chris Wendel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (MCUtilityButtons)

- (UIButton *)sw_addUtilityButtonWithColor:(UIColor *)color title:(NSString *)title;
- (UIButton *)sw_addUtilityButtonWithColor:(UIColor *)color attributedTitle:(NSAttributedString *)title;
- (UIButton *)sw_addUtilityButtonWithColor:(UIColor *)color icon:(UIImage *)icon;
- (UIButton *)sw_addUtilityButtonWithColor:(UIColor *)color normalIcon:(UIImage *)normalIcon selectedIcon:(UIImage *)selectedIcon;

@end


@interface NSArray (SWUtilityButtons)

- (BOOL)sw_isEqualToButtons:(NSArray *)buttons;

@end
