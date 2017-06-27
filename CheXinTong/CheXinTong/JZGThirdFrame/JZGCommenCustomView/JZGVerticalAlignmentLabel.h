//
//  JZGVerticalAlignmentLabel.h
//  JingZhenGu
//
//  Created by Mars on 15/12/11.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface JZGVerticalAlignmentLabel : UILabel

/**垂直对齐方式*/
@property(nonatomic, assign) VerticalAlignment verticalAlignment;

@end
