//
//  JZGEmptyView.m
//  JingZhenGu
//
//  Created by Wen Dongxiao on 15/6/2.
//  Copyright (c) 2015年 Mars. All rights reserved.
//

#import "JZGEmptyView.h"

@implementation JZGEmptyView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initEmptyViewWithTitle];
    }
    return self;
}
-(void)initEmptyViewWithTitle{
    
    self.backgroundColor = [UIColor whiteColor];
    
    _emptyImage = [[UIImageView alloc]initWithFrame:CGRectMake((self.width-130)/2, (self.height-20)/2, 20, 20)];
    [_emptyImage setImage:[UIImage imageNamed:@"raload_remind.png"]];
    [self addSubview:_emptyImage];
    
    _emptyDescribeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_emptyImage.x+_emptyImage.width+10, _emptyImage.y+2, 110, 15)];
    _emptyDescribeLabel.text = @"点击屏幕重新加载";
    _emptyDescribeLabel.font =   JZGFont(13.0f);
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
