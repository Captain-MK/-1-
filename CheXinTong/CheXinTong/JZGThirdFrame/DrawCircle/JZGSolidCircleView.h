//
//  JZGSolidCircleView.h
//  JingZhenGu
//
//  Created by Mars on 15/12/16.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZGCircleModel.h"

@interface JZGSolidCircleView : UIView

#define PI 3.14159265358979323846

@property (strong, nonatomic) JZGCircleModel *model;
@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) NSArray *attArray;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIColor *circleColor;

@end
