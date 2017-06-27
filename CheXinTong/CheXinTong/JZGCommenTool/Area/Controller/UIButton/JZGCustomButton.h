//
//  JZGCustomButton.h
//  JZGAppraiserNetwork
//
//  Created by Gaowl on 15/3/11.
//  Copyright (c) 2015年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    HorizontalAlignmentLeft = 0, // default
    HorizontalAlignmentCenter,
    HorizontalAlignmentRight,
} HorizontalAlignment;

@interface JZGCustomButton : UIButton

/**文字水平对齐方式*/
@property(nonatomic, assign) HorizontalAlignment titleHorizontalAlignment;
/**图片水平对齐方式*/
@property(nonatomic, assign) HorizontalAlignment imageHorizontalAlignment;

@end
