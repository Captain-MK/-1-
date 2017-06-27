//
//  JZGCarStyleView.h
//  JingZhenGu
//
//  Created by Mars on 15/12/28.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class JZGCarStyleView;

@interface JZGCarStyleView : UIView

@property (nonatomic,strong) UIView *carStyleView;
@property (strong, nonatomic) UIImageView *toggleView;

+ (JZGCarStyleView *)initializeCarStyleView:(UIView *)carStyleView;

-(void)show;
-(void)hide;

- (void)showAndHidden;
- (void)hiddenAndShow;

@end
