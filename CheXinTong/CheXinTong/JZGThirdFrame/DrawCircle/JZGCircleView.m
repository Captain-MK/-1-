//
//  JZGCircleView.m
//  JingZhenGu
//
//  Created by Mars on 15/12/16.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGCircleView.h"
#import "JZGHollowCircleView.h"
#import "JZGSolidCircleView.h"
#import "JZGCircleModel.h"

static NSInteger PRICE_TAG   =   10000;
static NSInteger OPTION_TAG  = 100000;

@implementation JZGCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)loadOptionView
{
    
    CGFloat kWidth = 0.0f;
    if (iPhone4 || iPhone5) {
        kWidth = (SCREEN_WIDTH - 40) / 3;
    }else
        kWidth = (SCREEN_WIDTH - 60) / 3;
    UIView *view = [self rankWithTotalColumns:3 andX:0 andY:0 andWithAppW:kWidth andWithAppH:20];
    self.optionView = view;
    [self addSubview:self.optionView];
}

- (void)layoutSubviews
{
    [self loadOptionView];
    UIView *view = [self loadBottomViewFrame:CGRectMake(0, 320, SCREEN_WIDTH, 140)];
    self.bottomView = view;
    [self addSubview:self.bottomView];
    self.optionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    self.bottomLayer.frame = CGRectMake(0, self.optionView.bounds.size.height-0.5, self.optionView.bounds.size.width, 0.5);
    
     NSArray *imgArray = @[@"valuation_zhe.png",@"valuation_you.png",@"valuation_xian.png",@"valuation_yang.png",@"valuation_shui.png"];
    for (NSInteger i = 0; i < [self.colorArray count]; i++) {
        UILabel *label = (UILabel *)[self viewWithTag:OPTION_TAG + i];
//        label.backgroundColor = [self.colorArray objectAtIndex:i];
        label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[imgArray objectAtIndex:i]]];
    }
    
    [self loadOptionViewWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 200)];
}

- (UIView *)loadBottomViewFrame:(CGRect)frame
{
    UIView *bottomView = [[UIView alloc] initWithFrame:frame];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH / 2 - 20, 20)];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.textColor = COLOR_BLACK_MARCROS;
    leftLabel.font = JZGFont(15.0f);
    leftLabel.text = @"月均折旧成本6.48万";
    self.leftLabel = leftLabel;
    [bottomView addSubview:self.leftLabel];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + 10, 0, SCREEN_WIDTH / 2 - 20, 20)];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.font = JZGFont(15.0f);
    rightLabel.textColor = COLOR_BLACK_MARCROS;
    rightLabel.text = @"月均使用成本9.50万";
    self.rightLabel = rightLabel;
    [bottomView addSubview:self.rightLabel];
    
    UILabel *middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-5, 0, 10, 20)];
    middleLabel.text = @"+";
    middleLabel.textColor = COLOR_BLACK_MARCROS;
    middleLabel.font = JZGFont(15.0f);
    middleLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:middleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"valuation_arrow.png"]];
    imageView.frame = CGRectMake(SCREEN_WIDTH / 2 - (67 / 4.0), 30, 67/2.0f, 17);
    [bottomView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.costLabel = titleLabel;
    [bottomView addSubview:self.costLabel];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 20)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = JZGFont(13.0f);
    textLabel.textColor = [JZGCommenTool hexStringToColor:COLOR_GRAY_MARCROS];
    self.textLabel = textLabel;
    [bottomView addSubview:self.textLabel];

    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, SCREEN_WIDTH - 30, 40)];
    bottomLabel.text = @"月均使用成本=燃油+保险+保养+税费，其中：保险包括交强险、第三者责任险、车辆损失险。";
    bottomLabel.font = JZGFont(13.0f);
    bottomLabel.textColor = [JZGCommenTool hexStringToColor:COLOR_GRAY_MARCROS];
    bottomLabel.numberOfLines = 0;
    [bottomView addSubview:bottomLabel];
    
    return bottomView;
}

- (void)loadOptionViewWithFrame:(CGRect)frame
{
    CGFloat max = [[self.textArray valueForKeyPath:@"@max.intValue"] floatValue];
    CGFloat min = [[self.textArray valueForKeyPath:@"@min.intValue"] floatValue];
    
    CGFloat marginX = [UIScreen mainScreen].bounds.size.width/2.0f;
    CGFloat kMargin = 69.28;
    
    /**空心圆半径*/
    CGFloat kHCircleR = 80;
    /**空心圆直径*/
    CGFloat kHCircleD = 2 * kHCircleR;
    
    CGFloat kHCircleX = marginX - kHCircleR;
    CGFloat kHCirCleY = kHCircleR / 2.0f + 90;
    CGFloat kHCirCleWidth = kHCircleD;
    CGFloat kHCirCleHeight = kHCirCleWidth;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 90, 90, 20)];
    label.text = @"整体占比";
    label.textColor = COLOR_BLACK_MARCROS;
    
    label.font = JZGFont(14.0f);
    [self addSubview:label];
    
    /**空心圆*/
    JZGHollowCircleView *hollowCircleView = [[JZGHollowCircleView alloc] initWithFrame:CGRectMake(kHCircleX,kHCirCleY,kHCirCleWidth,kHCirCleHeight)];
    hollowCircleView.radius = kHCircleR;
    self.hollowCircleView = hollowCircleView;
    [self addSubview:self.hollowCircleView];
    
    CGPoint point1  = CGPointMake(marginX - kHCircleR, kHCirCleY + kHCircleR);
    CGPoint point2 = CGPointMake(marginX, kHCirCleY);
    CGPoint point3 = CGPointMake(marginX + kMargin, kHCirCleY + kHCircleR / 2);
    CGPoint point4 = CGPointMake(marginX + kMargin, kHCirCleY + kHCircleR / 2 + 80);
    CGPoint point5 = CGPointMake(marginX, kHCirCleY+kHCircleD);
    
    /**坐标数组*/
    NSArray *pointArray = @[NSStringFromCGPoint(point1),NSStringFromCGPoint(point2),NSStringFromCGPoint(point3),NSStringFromCGPoint(point4),NSStringFromCGPoint(point5)];
    NSArray *textArray = @[@"折旧",@"燃油",@"保险",@"保养",@"税费"];
    
    for (NSInteger i = 0; i < [pointArray count]; i++) {
        float marginWidth = 0;
        if ([[self.textArray objectAtIndex:i] integerValue] != 0) {
            if (max - min != 0) {
                marginWidth = 2 * (([[self.textArray objectAtIndex:i] floatValue] - min) * (20/(max - min)) + 20);
            }else
                marginWidth = 2 * 40;
        }else
            marginWidth = 40;
        
        /**实心圆*/
        JZGSolidCircleView *solidView = [[JZGSolidCircleView alloc] initWithFrame:CGRectMake(0, 0, marginWidth, marginWidth)];
        solidView.center = CGPointFromString([pointArray objectAtIndex:i]);
        solidView.textColor = [UIColor whiteColor];
        solidView.tag = 100 + i;
        [self addSubview:solidView];
        
        CGFloat mX = 0.0;
        CGFloat mY = 0.0f;
        if (i ==0 || i == 1 || i == 4) {
            mX = CGPointFromString([pointArray objectAtIndex:i]).x - marginWidth/2.0f-20;
            if (i == 1) {
                mY = CGPointFromString([pointArray objectAtIndex:i]).y - 10;
            }else if(i == 4)
                mY = CGPointFromString([pointArray objectAtIndex:i]).y + 10;
            else
                mY = CGPointFromString([pointArray objectAtIndex:i]).y;
        }else{
            mX = CGPointFromString([pointArray objectAtIndex:i]).x + marginWidth / 2.0f + 20;
            mY = CGPointFromString([pointArray objectAtIndex:i]).y;
        }
        
        CGPoint labelPoint = CGPointMake(mX, mY);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        label.text = [textArray objectAtIndex:i];
        label.center = labelPoint;
        label.textColor = [JZGCommenTool hexStringToColor:COLOR_GRAY_MARCROS];
        label.font = JZGFont(13.f);
        label.tag = OPTION_TAG + i;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    
    [self refresh];
}

/** 排列根据数组生成的view 根据需要的“列数”，“框框宽度”，“框框高度” */
- (UIView *)rankWithTotalColumns:(int)totalColumns andX:(NSInteger)x andY:(NSInteger)y andWithAppW:(int)appW andWithAppH:(int)appH{

    UIView *view = [[UIView alloc] init];
    
    //view尺寸
    CGFloat _appW = appW;
    CGFloat _appH = appH;
    
    CGFloat circleW = 24;
    CGFloat circleH = circleW;

    CGFloat margin = 10;
    NSInteger kMarginLeft = 0;
    if (iPhone5 || iPhone4) {
        kMarginLeft = 10;
    }else
        kMarginLeft = 20;
    
    NSArray *imgArray = @[@"valuation_zhe.png",@"valuation_you.png",@"valuation_xian.png",@"valuation_yang.png",@"valuation_shui.png"];

    for (int index = 0; index < 5; index++) {
        //行号
        int row = index / totalColumns; //行号为框框的序号对列数取商
        //列号
        int col = index % totalColumns; //列号为框框的序号对列数取余

        
        CGFloat appX = x + kMarginLeft+ col * (appW + margin); // 每个框框靠左边的宽度为 (平均间隔＋框框自己的宽度）
        CGFloat appY = y + 20 + row * (appH + margin); // 每个框框靠上面的高度为 平均间隔＋框框自己的高度
        
        CGRect circleRect = CGRectMake(appX-2.5, appY-2.5, circleW, circleH);
        CGRect rect = CGRectMake(appX+circleW+5, appY, _appW - circleW, _appH);

        UILabel *label = [[UILabel alloc] init];
        label.layer.cornerRadius = 9;
        label.frame = circleRect;
        label.clipsToBounds = YES;
        label.tag = OPTION_TAG + index;
//        label.backgroundColor = [self.colorArray objectAtIndex:index];
        label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[imgArray objectAtIndex:index]]];
        [view addSubview:label];
        
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.tag = PRICE_TAG + index;
        priceLabel.frame = rect;
        priceLabel.textColor = COLOR_BLACK_MARCROS;
        priceLabel.backgroundColor = [UIColor clearColor];
        if (iPhone5 || iPhone4) {
            priceLabel.font = JZGFont(11.0f);
        }else
            priceLabel.font = JZGFont(13.0f);
        [view addSubview:priceLabel];
    }
    
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.backgroundColor = COLOR_LIGHTGRAY_MACROS.CGColor;
    self.bottomLayer = bottomLayer;
    [view.layer addSublayer:self.bottomLayer];
    
    return view;
}

- (void)refresh
{
    if (self.textArray) {
        NSInteger num = 0;
        NSString *averageCost;
        NSString *userOldCost;
        NSString *userAverageCost;
        if (iPhone5) {
            averageCost = [NSString stringWithFormat:@"月均总成本%zd",[self.averageCost integerValue]];
            userOldCost = [NSString stringWithFormat:@"月均折旧成本%zd",[self.userOldCost integerValue]];
            userAverageCost = [NSString stringWithFormat:@"月均使用成本%zd",[self.userAverageCost integerValue]];

        } else {
            averageCost = [NSString stringWithFormat:@"月均总成本%zd元",[self.averageCost integerValue]];
            userOldCost = [NSString stringWithFormat:@"月均折旧成本%zd元",[self.userOldCost integerValue]];
            userAverageCost = [NSString stringWithFormat:@"月均使用成本%zd元",[self.userAverageCost integerValue]];

        }

        self.costLabel.attributedText = [self formatString:averageCost titleRange:NSMakeRange(0,5) priceRange:NSMakeRange(5,averageCost.length - 5)];
        
        self.leftLabel.attributedText = [self formatString:userOldCost titleRange:NSMakeRange(0, 6) priceRange:NSMakeRange(6, userOldCost.length - 6)];
        
        self.rightLabel.attributedText = [self formatString:userAverageCost titleRange:NSMakeRange(0, 6) priceRange:NSMakeRange(6, userAverageCost.length - 6)];
        
        NSString *string = @"";
        for (NSInteger i = 0;i < [self.textArray count] ; i++) {
            JZGCircleModel *model = [[JZGCircleModel alloc] init];
            model.text = [NSString stringWithFormat:@"%@%%",[self.textArray objectAtIndex:i]];
            model.attArray = [self.colorArray objectAtIndex:i];
            JZGSolidCircleView *soliderView = (JZGSolidCircleView *)[self viewWithTag:100+i];
            soliderView.circleColor = [self.colorArray objectAtIndex:i];
            soliderView.model = model;
            
            if ([[self.priceArray objectAtIndex:i] integerValue] == 0) {
                num += 1;
                
                NSString *str = [self.titleArray objectAtIndex:i];
                if(num == 1){
                    string = [NSString stringWithFormat:@"%@%@",string,str];
                }else if(num < 3)
                    string = [NSString stringWithFormat:@"%@和%@",string,str];
                
            }
            if (string.length == 0) {
                self.textLabel.text = @"";
            }else
                self.textLabel.text = [NSString stringWithFormat:@"(此预估成本中不包含%@)",string];
            
            UILabel *label = (UILabel *)[self viewWithTag:PRICE_TAG + i];
            if ([[self.priceArray objectAtIndex:i] floatValue] == 0) {
                label.text = [NSString stringWithFormat:@"%@", @"- -"];
            }else
                label.text = [NSString stringWithFormat:@"%zd元",[[self.priceArray objectAtIndex:i] integerValue]];
            
        }
    }
}

- (NSMutableAttributedString *)formatString:(NSString *)string titleRange:(NSRange)titleRange priceRange:(NSRange)priceRange
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    
    [str addAttribute:NSForegroundColorAttributeName value:COLOR_BLACK_MARCROS range:titleRange];
    
    [str addAttribute:NSForegroundColorAttributeName value:COLOR_RED_MARCROS range:priceRange];
    
    [str addAttribute:NSFontAttributeName value:JZGFont(14.0f) range:titleRange];
    
    [str addAttribute:NSFontAttributeName value:JZGFont(15.0f) range:priceRange];
    
    return str;
}

//- (void)createOptionViewWithFrame:(CGRect)frame
//{
//    
//    self.backgroundColor = [UIColor whiteColor];
//    //    NSArray * arr = [NSArray arrayWithObjects:@"19",@"23",@"17",@"40",@"1", nil];
//    NSInteger max = [[self.textArray valueForKeyPath:@"@max.intValue"] integerValue];
//    NSInteger min = [[self.textArray valueForKeyPath:@"@min.intValue"] integerValue];
//    
//    NSInteger maxWidth = 50;
//    NSInteger minWidth = 20;
//    
//    NSMutableArray *array = [NSMutableArray array];
//    
//    CGFloat marginX = ([UIScreen mainScreen].bounds.size.width - 260 )/ 2.0f;
//    CGFloat kMargin = 69;
//    
//    
//    JZGHollowCircleView *circleView = [[JZGHollowCircleView alloc] initWithFrame:CGRectMake(marginX,60,120,120)];
//    circleView.radius = 60;
//    [self addSubview:circleView];
//    
//    JZGHollowCircleView *circleView2 = [[JZGHollowCircleView alloc] initWithFrame:CGRectMake(marginX + 100,40,160,160)];
//    circleView2.radius = 80;
//    [self addSubview:circleView2];
//    
//    /**圆背景色数组*/
//    NSArray *colorArray = @[@[@(19.0/255.0),@(93.0/255.0),@(184.0/255.0),@(1.0)],@[@(228.0/255.0),@(54.0/255.0),@(26.0/255.0),@(1.0)],@[@(255/255.0),@(170/255.0),@(23/255.0),@(1.0)],@[@(26/255.0),@(189/255.0),@(26/255.0),@(1.0)],@[@(179/255.0),@(32/255.0),@(206/255.0),@(1.0)]];
//    
//    CGPoint point1 = CGPointMake(marginX + 100+80, 40);
//    CGPoint point2 = CGPointMake(marginX + 100+80 + kMargin, 40+40); //CGPointMake(marginXX, marginYY)
//    CGPoint point3 = CGPointMake(marginX + 100+80 + kMargin, 160); //CGPointMake(marginXXX, marginYYY)
//    CGPoint point4 = CGPointMake(marginX + 100+80, 40+160); //CGPointMake(marginX + 100+80, 40+160)
//    
//    /**坐标数组*/
//    NSArray *pointArray = @[NSStringFromCGPoint(point1),NSStringFromCGPoint(point1),NSStringFromCGPoint(point2),NSStringFromCGPoint(point3),NSStringFromCGPoint(point4)];
//    
//    for (NSInteger i = 0; i < [self.textArray count]; i++) {
//        [array addObject:@(([[self.textArray objectAtIndex:i] floatValue] / (float)(max-min)) * (maxWidth - minWidth) + minWidth)];
//        
//        float marginWidth = 0;
//        if ([[self.textArray objectAtIndex:i] integerValue] != 0) {
//            if (max - min != 0) {
//                marginWidth = 2 * (([[self.textArray objectAtIndex:i] floatValue] - min) * (30/(max - min)) + 20);
//            }else
//                marginWidth = 2 * 40;
//        }else
//            marginWidth = 0;
//        JZGSolidCircleView *solidView = [[JZGSolidCircleView alloc] initWithFrame:CGRectMake(50, 50, marginWidth, marginWidth)];
//        if (i == 0) {
//            solidView.center = circleView.center;
//        }else
//            solidView.center = CGPointFromString([pointArray objectAtIndex:i]);
//        JZGCircleModel *model = [[JZGCircleModel alloc] init];
//        model.text = [NSString stringWithFormat:@"%@%%",[self.textArray objectAtIndex:i]];
//        model.attArray = [colorArray objectAtIndex:i];
//        solidView.model = model;
//        solidView.textColor = [UIColor whiteColor];
//        [self addSubview:solidView];
//        
//        CGFloat kCircleWidth = 18.0f;
//        CGFloat kMarginH = 300;
////        UILabel *circleLabel = [UILabel alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//        
//        
//    }
//}



//- (void)createViewWithFrame:(CGRect)frame
//{
//    
//    CGFloat marginX = ([UIScreen mainScreen].bounds.size.width - 260 )/ 2.0f;
//    CGFloat kMargin = 69;
//    CGFloat marginXX = marginX + 100 + 80 + kMargin;
//    CGFloat marginYY = 40 + 40;
//    
//    CGFloat marginXXX = marginXX;
//    CGFloat marginYYY = 160;
//    
//    JZGHollowCircleView *circleView = [[JZGHollowCircleView alloc] initWithFrame:CGRectMake(marginX,60,120,120)];
//    circleView.radius = 60;
//    [self addSubview:circleView];
//    
//    JZGHollowCircleView *circleView2 = [[JZGHollowCircleView alloc] initWithFrame:CGRectMake(marginX + 100,40,160,160)];
//    circleView2.radius = 80;
//    [self addSubview:circleView2];
//    
//    JZGSolidCircleView *solidView = [[JZGSolidCircleView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    solidView.center = circleView.center;
//    JZGCircleModel *model = [[JZGCircleModel alloc] init];
//    model.text = @"100%";
//    model.attArray = @[@(19.0/255.0),@(93.0/255.0),@(184.0/255.0),@(1.0)];
//    solidView.model = model;
//    solidView.textColor = [UIColor whiteColor];
//    [self addSubview:solidView];
//    
//    JZGSolidCircleView *solidView1 = [[JZGSolidCircleView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
//    solidView1.center = CGPointMake(marginX + 100+80, 40);
//    //    solidView1.center = circleView.center;
//    JZGCircleModel *model1 = [[JZGCircleModel alloc] init];
//    model1.text = @"50%";
//    model1.attArray = @[@(228.0/255.0),@(54.0/255.0),@(26.0/255.0),@(1.0)];
//    solidView1.model = model1;
//    solidView1.textColor = [UIColor whiteColor];
//    [self addSubview:solidView1];
//    
//    JZGSolidCircleView *solidView2 = [[JZGSolidCircleView alloc] initWithFrame:CGRectMake(100, 100, 100,100)];
//    solidView2.center = CGPointMake(marginXX, marginYY);
//    JZGCircleModel *model2 = [[JZGCircleModel alloc] init];
//    model2.text = @"60%";
//    model2.attArray = @[@(255/255.0),@(170/255.0),@(23/255.0),@(1.0)];
//    solidView2.model = model2;
//    solidView2.textColor = [UIColor whiteColor];
//    [self addSubview:solidView2];
//    
//    JZGSolidCircleView *solidView3 = [[JZGSolidCircleView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    solidView3.center = CGPointMake(marginXXX, marginYYY);
//    
//    JZGCircleModel *model3 = [[JZGCircleModel alloc] init];
//    model3.text = @"20%";
//    model3.attArray = @[@(26/255.0),@(189/255.0),@(26/255.0),@(1.0)];
//    solidView3.model = model3;
//    solidView3.textColor = [UIColor whiteColor];
//    [self addSubview:solidView3];
//    
//    JZGSolidCircleView *solidView4 = [[JZGSolidCircleView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    solidView4.center = CGPointMake(marginX + 100+80, 40+160);
//    JZGCircleModel *model4 = [[JZGCircleModel alloc] init];
//    model4.text = @"10%";
//    model4.attArray = @[@(179/255.0),@(32/255.0),@(206/255.0),@(1.0)];
//    solidView4.model = model4;
//    solidView4.textColor = [UIColor whiteColor];
//    [self addSubview:solidView4];
//    
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
