//
//  JZGCircleView.h
//  JingZhenGu
//
//  Created by Mars on 15/12/16.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZGHollowCircleView.h"

@interface JZGCircleView : UIView

/**圆内百分比*/
@property (strong, nonatomic) NSMutableArray *textArray;
/**月均总成本成本*/
@property (copy, nonatomic) NSString *averageCost;
/**月均使用成本*/
@property (copy, nonatomic) NSString *userAverageCost;
/**月均折旧成本*/
@property (copy, nonatomic) NSString *userOldCost;
/**价格*/
@property (strong, nonatomic) NSMutableArray *priceArray;
/**颜色数组*/
@property (strong, nonatomic) NSMutableArray *colorArray;
/**折旧，燃油等数组*/
@property (strong, nonatomic) NSMutableArray *titleArray;
/**月均使用成本*/
@property (weak, nonatomic) UILabel *costLabel;
/**预估成本不包含*/
@property (weak, nonatomic) UILabel *textLabel;

/**折旧 燃油等数据背景视图*/
@property (weak, nonatomic) UIView *optionView;
/**optionView 底部线条*/
@property (weak, nonatomic) CALayer *bottomLayer;

@property (weak, nonatomic) JZGHollowCircleView *hollowCircleView;

/**月均折旧成本*/
@property (weak, nonatomic) UILabel *leftLabel;
/**月均使用成本*/
@property (weak, nonatomic) UILabel *rightLabel;

/**底部价格背景图*/
@property (weak, nonatomic) UIView *bottomView;




/**刷新数据*/
- (void)refresh;

@end
