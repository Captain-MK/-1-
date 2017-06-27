//
//  PLHaveBottomButtonView.h
//  PLTP_M_CARRIERS
//
//  Created by Lucas on 14/11/27.
//  Copyright (c) 2014年 崔坤. All rights reserved.
//

#import "JZGSingleTableView.h"

@protocol JZGClickedButtonDelegate <NSObject>

- (void)clickBottomButton:(UIButton *)but;

@end

@interface JZGSingleBottomButtonView : JZGSingleTableView

/**
 *  底部按钮
 */
@property (nonatomic,readonly) UIButton *bottomButton;

/**
 *  代理
 */
@property (weak, nonatomic) id<JZGClickedButtonDelegate> delegate;

@end

