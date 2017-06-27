//
//  JZGDataEmptyView.m
//  JingZhenGu
//
//  Created by Wen Dongxiao on 15/6/11.
//  Copyright (c) 2015年 Mars. All rights reserved.
//

#import "JZGDataEmptyView.h"

@implementation JZGDataEmptyView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self reloadEmptyDataView];
    }
    return self;
}
-(void)reloadEmptyDataView{
    self.backgroundColor=COLOR_SILVERGRAY_MACROS;
    _emptyDescribeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.height-20)/2, SCREEN_WIDTH, 20)];
    _emptyDescribeLabel.textAlignment=1;
    _emptyDescribeLabel.textColor=COLOR_LIGHTGRAY_MACROS;
    //self.emptyDescribeLabel.text = @"暂无数据";
    [self addSubview:_emptyDescribeLabel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
