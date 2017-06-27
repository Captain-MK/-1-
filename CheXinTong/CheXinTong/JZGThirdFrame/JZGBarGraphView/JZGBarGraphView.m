//
//  JZGBarGraphView.m
//  JingZhenGu
//
//  Created by Mars on 15/5/20.
//  Copyright (c) 2015年 Mars. All rights reserved.
//

#import "JZGBarGraphView.h"
#import "JZGVerticalAlignmentLabel.h"

/**视图最大宽度*/
#define max_width               self.bounds.size.width
/**视图最大高度*/
#define max_height              self.bounds.size.height
/**柱状图x坐标*/
#define marginX                 60
/**柱状图之间间距*/
#define marginH                 ((max_width - 1.5 *marginX - self.barWidth)* 1.0 / (_titleArray.count - 1)) - self.barWidth
/**字体大小*/
#define font_size(f)             [UIFont systemFontOfSize:f]
/**单位视图的高度*/
#define unitHeight              20

/**左侧的宽度*/
#define leftLabelWidth               25
/**左侧padding*/
#define leftLabelPadding              5
/**左侧的高度*/
#define leftLabelHeight               15

/**柱状图底部Y坐标*/
#define mvHeight                max_height - 40
/**标题高度*/
#define tHeight                 30
#define color1                  JZGUIColorFromRGB(0xfc6620)
#define color2                  JZGUIColorFromRGB(0xf98824)
#define color3                  JZGUIColorFromRGB(0xfda431)
#define color4                  JZGUIColorFromRGB(0xfdc351)
#define color5                  JZGUIColorFromRGB(0xfed23e)
#define color6                  JZGUIColorFromRGB(0xfed23e)

#define view_tag                100
#define label_tag               200
#define label_unit_tag          300
#define label_title_tag         400

@implementation JZGBarGraphView

- (void)createOptionView:(NSString *)unitTitle
{
    //单位
    UILabel *unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, max_width - 40, unitHeight)];
    unitLabel.textColor = JZGUIColorFromRGB(0xaaaaaa);
    unitLabel.textAlignment = NSTextAlignmentLeft;
    unitLabel.font = JZGFont(13.0f);
    unitLabel.tag = label_unit_tag;
    [self.scrollerView addSubview:unitLabel];
    
    
    NSArray *colorArray = @[color1,color2,color3,color4,color5];
    
    for (NSInteger i = 0; i <[self.titleArray count]; i++) {
        //柱状图
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(marginX + (self.barWidth + marginH) * i, mvHeight, self.barWidth, 0)];
        view.backgroundColor = [colorArray objectAtIndex:i % [colorArray count]];
        view.tag = view_tag + i;
        [self.scrollerView addSubview:view];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesTureRecognizerClicked:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [view addGestureRecognizer:tapGestureRecognizer];
        
        //柱状图内容
        JZGVerticalAlignmentLabel *contentLabel = [[JZGVerticalAlignmentLabel alloc] initWithFrame:CGRectMake((marginX + (self.barWidth + marginH) * i) - self.barWidth, mvHeight, 3*self.barWidth, -unitHeight)];
        contentLabel.textColor = [JZGCommenTool hexStringToColor:COLOR_GRAY_MARCROS];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.font = JZGFont(15.0f);
        contentLabel.tag = label_tag + i;
        [self.scrollerView addSubview:contentLabel];
        
        //柱状图标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((marginX + (self.barWidth + marginH) * i) - self.barWidth ,max_height-10, 3*self.barWidth, -tHeight)];
        titleLabel.textColor = [JZGCommenTool hexStringToColor:COLOR_GRAY_MARCROS];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = JZGFont(13.0f);
        titleLabel.text = [_titleArray objectAtIndex:i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.tag = label_title_tag + i;
        [self.scrollerView addSubview:titleLabel];
    }
    [self refreshBarGraphWithData:self.dataArray titleArray:self.titleArray unitTitle:[NSString stringWithFormat:@"%@",unitTitle]];
}

- (void)tapGesTureRecognizerClicked:(UITapGestureRecognizer *)tapGestureRecognizer
{
    UIView *view = tapGestureRecognizer.view;
    NSInteger index = view.tag - view_tag;
    for (NSInteger i = 0; i < [self.dataArray count]; i++) {
        UILabel *l = (UILabel *)[self viewWithTag:i + label_tag];
        if (i == index) {
            l.textColor = COLOR_ORANGE_MACROS;
        }else{
            l.textColor = [JZGCommenTool hexStringToColor:COLOR_GRAY_MARCROS];
        }
    }
}

- (void)refreshBarGraphWithData:(NSArray *)dataArray titleArray:(NSArray *)titleArray unitTitle:(NSString *)unitTitle
{
    if ([self.titleArray count] != [titleArray count]) {
        [_scrollerView removeFromSuperview];
        _scrollerView = nil;
        [_titleArray removeAllObjects];
        [_dataArray removeAllObjects];
        
        if (_scrollerView == nil) {
            [self addSubview:self.scrollerView];
            [self.titleArray addObjectsFromArray:titleArray];
            [self.dataArray addObjectsFromArray:dataArray];
            [self createOptionView:unitTitle];
        }
    }else {
        if (dataArray && self.scrollerView) {
            
            NSInteger num = 0;
            for (NSInteger i = 0; i < [dataArray count]; i++) {
                if ([[dataArray objectAtIndex:i] floatValue] == 0) {
                    num += 1;
                }
            }
            if (self.notShowEmptyView) {
                num = 0;
            }
            
            if (num == [dataArray count]) {
                [self addSubview:self.emptyView];
                return;
            }else{
                [self.emptyView removeFromSuperview];
                UILabel *unitLabel = (UILabel *)[self viewWithTag:label_unit_tag];
                unitLabel.text = unitTitle;
                
                //获取数组最大值
                float count = [self getMaxValueFromArray:dataArray];
                int tempCount = [self roundNumberWithNumber:count];
                //获得最大值的高度比
//                float m = self.maxHeight * 8 / 15.0f;
                float m = max_height - 80;
                float mulriple = 0;
                mulriple = m / tempCount;
                /**
                 *  test 辅助试图
                 */
                [self drawAssistantViewWithM:tempCount mulriple:mulriple];
                for (NSInteger i = 0; i < [dataArray count]; i++) {
                    UIView *view = (UIView *)[self viewWithTag:view_tag+i];
                    float mHeight = [[dataArray objectAtIndex:i] floatValue];
                    float height = mHeight * mulriple;
                    
                    JZGVerticalAlignmentLabel *contentLabel = (JZGVerticalAlignmentLabel *)[self viewWithTag:label_tag+i];
                    float temp = [[dataArray objectAtIndex:i] floatValue];
                    if (self.notShowEmptyView) {
                        if (temp == 0) {
                            contentLabel.text = @"0";
                        }else{
                            contentLabel.text = [NSString stringWithFormat:@"%d",[[dataArray objectAtIndex:i] integerValue]];
                        }

                    }else
                    {
                        if (temp == 0) {
                            contentLabel.text = @"_ _";
                        }else{
                            contentLabel.text = [NSString stringWithFormat:@"%.2f",[[dataArray objectAtIndex:i] floatValue]];
                        }
                    }
                    
                    
                    [UIView animateWithDuration:1.5 animations:^{
                        view.y = max_height - 40;
                        view.height = 0;
                        view.height = - height;
                        
                        if ([contentLabel.text isEqualToString:@"- -"]) {
//                            contentLabel.Y = mvHeight - height + 8;
                        }else{
                            contentLabel.y = mvHeight - height;
                            contentLabel.height = -unitHeight;
                        }
                        
                    } completion:^(BOOL finished) {
                        if ([contentLabel.text isEqualToString:@"- -"]) {
                            contentLabel.y = mvHeight - height + 8;
                            contentLabel.height = -20;
                        }
                        if (i == [dataArray count]-1) {
//                            if ([self.refreshDelegate respondsToSelector:@selector(graphRefreshSuccess)]) {
//                                [self.refreshDelegate graphRefreshSuccess];
//                            }
                        }
                    }];
                }
            }
        }

    }
}

/**获取数组最大值*/
- (float)getMaxValueFromArray:(NSArray *)array
{
    NSArray *maxlist = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 floatValue] > [obj2 floatValue] ) {
            return NSOrderedDescending;
        }
        if ([obj1 floatValue] < [obj2 floatValue] ) {
            return NSOrderedAscending;
        }
        
        return NSOrderedSame;
    }];
    
    float maxValue = [[maxlist lastObject] floatValue];
    return maxValue;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (UIScrollView *)scrollerView
{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height)];
        _scrollerView.backgroundColor = [UIColor clearColor];
        [_scrollerView flashScrollIndicators];
        _scrollerView.scrollEnabled = YES;
        _scrollerView.showsHorizontalScrollIndicator = NO;
        _scrollerView.pagingEnabled = NO;
        _scrollerView.delegate = self;
        [self addSubview:_scrollerView];
    }
    return _scrollerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_WHITE_MACROS;
        _titleArray = [NSMutableArray array];
        _dataArray = [NSMutableArray array];

        if (iPhone5 || iPhone4) {
            self.barWidth = 28;
        }else
            self.barWidth = 36;
    };
    return self;
}

+ (instancetype)viewWithBarGraphView:(CGRect)frame
{
    JZGBarGraphView *graphView = [[JZGBarGraphView alloc] initWithFrame:frame];
    
    return graphView;
}

- (JZGEmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[JZGEmptyView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _emptyView.backgroundColor = self.backgroundColor;
        self.emptyView.emptyDescribeLabel.textColor = COLOR_LIGHTGRAY_MACROS;
        _emptyView.emptyDescribeLabel.text = @"暂无相关数据";
    }
    return _emptyView;
}

- (void)drawAssistantViewWithM:(float)m mulriple:(float)mulriple {
    for (int i = 0; i < 5; i ++) {
        UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(leftLabelWidth + leftLabelPadding , mvHeight - (m / 4 * mulriple * i) , max_width, 0.5)];
        testView.backgroundColor = [UIColor lightGrayColor];
        testView.alpha = 0.3;
        UILabel *testLabel = [[UILabel alloc] init];
        testLabel.textColor = [JZGCommenTool hexStringToColor:COLOR_GRAY_MARCROS];
        testLabel.font = JZGFont(13.0f);
        testLabel.textAlignment = NSTextAlignmentRight;
        testLabel.x = 0;
        testLabel.width = leftLabelWidth;
        testLabel.height = leftLabelHeight;
        testLabel.centerY = mvHeight - (m / 4 * mulriple * i);
        NSString *textStr;
        float tempRatio = m / 4.0;
        float tempResult = tempRatio * i;
        if (tempRatio < 1) {
            if (tempResult == 0) {
                textStr = @"0";
            }else {
                if (self.notShowEmptyView) {
                    textStr = [NSString stringWithFormat:@"%d",(int)tempResult];
                }else
                {
                    textStr = [NSString stringWithFormat:@"%.1f",tempResult];
                }
                
            }
        } else {
            textStr = [NSString stringWithFormat:@"%d",(int)tempResult];
        }
        testLabel.text = textStr;
        [self insertSubview:testLabel belowSubview:_scrollerView];
        [self insertSubview:testView belowSubview:_scrollerView];
    }
}

- (int)roundNumberWithNumber:(float)number {
    if (self.notShowEmptyView) {
        int intNum = (int)number;
        int temp = 0;
        if (number < 4) {
            temp = 4;
        }else {
            int result = intNum / 4;
            temp = (result + 1) * 4;
        }
        return  temp;
    }else
    {
        int intNum = (int)number;
        int temp = 0;
        if (number < 2) {
            temp = 2;
        }else {
            int result = intNum / 4;
            temp = (result + 1) * 4;
        }
        return  temp;
    }

}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    
    return _titleArray;
}


@end
