//
//  JZGDataPickCoverView.h
//  JingZhenGu
//
//  Created by liuqt on 15/12/17.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZGDataPickView.h"

@protocol JZGDataPickCoverViewDelegate <NSObject>

- (void)selectedDataWithShowString:(NSString *)showStr lienceTimeStr:(NSString *)lienceTimeStr;
- (void)getError;
- (void)tapBlankView;
@end

@interface JZGDataPickCoverView : UIView
@property (nonatomic,copy) NSString *carModelId;

/** 年款时间 */
@property (copy, nonatomic) NSString *regYear;


@property (nonatomic,weak) id<JZGDataPickCoverViewDelegate>delegate;

/**  carmodelId  在选择上牌时间时必传， isover 是否含有已过期 在上牌时间时handtype传LienceTime*/

- (id)initWithFrame:(CGRect)frame withCarModelId:(NSString *)carModelId regYear:(NSString *)regYear;
@end
