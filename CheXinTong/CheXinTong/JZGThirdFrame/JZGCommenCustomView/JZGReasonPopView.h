//
//  JZGReasonPopView.h
//  JZGERSecondPhase
//
//  Created by liuqt on 2017/3/3.
//  Copyright © 2017年 jzg. All rights reserved.
//

#import "JZGBasePopView.h"

@interface JZGReasonPopView : JZGBasePopView
/**
 *  拒绝原因输入框
 */
@property(nonatomic,readonly) UITextView                 *contentTextView;

/**
 *  确定按钮
 */
@property(nonatomic,readonly) UIButton                   *submitButton;
/**
 *  取消按钮
 */
@property (nonatomic,readonly) UIButton                  *cancelButton;

-(void)popViewDidDisAppear;
@end
