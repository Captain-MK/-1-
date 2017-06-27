//
//  JZGReasonPopView.m
//  JZGERSecondPhase
//
//  Created by liuqt on 2017/3/3.
//  Copyright © 2017年 jzg. All rights reserved.
//

#import "JZGReasonPopView.h"

@interface JZGReasonPopView() <UITextViewDelegate>{
    UILabel *_titleLabel;
    UIButton*_deleteButton;
    UIView  *_separatorLine;
}


@end

@implementation JZGReasonPopView

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init{
    self = [super init];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = @"请输入拒绝原因*";
        _titleLabel.font = JZGFont(18);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self.popView addSubview:_titleLabel];
        
        _deleteButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_deleteButton setImage:[UIImage imageNamed:@"tan_close.png"]  forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(popViewDidDisAppear) forControlEvents:UIControlEventTouchUpInside];
        [self.popView addSubview:_deleteButton];
        
        _separatorLine = [[UIView alloc] initWithFrame:CGRectZero];
        _separatorLine.backgroundColor = CUTTING_LINE_COLOR;
        [self.popView addSubview:_separatorLine];
        
        _contentTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        _contentTextView.delegate = self;
        _contentTextView.text = @"请填写拒绝原因";
        _contentTextView.font = JZGFont(16);
        _contentTextView.textColor = RGBCOLOR(153, 153, 153);
        _contentTextView.returnKeyType = UIReturnKeyDone;
        _contentTextView.keyboardType = UIKeyboardTypeDefault;
        _contentTextView.layer.cornerRadius = 5;
        _contentTextView.layer.masksToBounds = YES;
        _contentTextView.layer.borderWidth = 1;
        _contentTextView.layer.borderColor = CUTTING_LINE_COLOR.CGColor;
        [self.popView addSubview:_contentTextView];
        
        _submitButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-15.0f-100.0f, 0.0f, 50.0f, 30.0f)];
        [_submitButton setTitle:@"确定" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton.titleLabel setFont:JZGFont(16)];
        [_submitButton setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(102, 166, 236)] forState:UIControlStateNormal];
        _submitButton.layer.cornerRadius = 5;
        _submitButton.layer.masksToBounds = YES;
        [self.popView addSubview:_submitButton];
        
        
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-15.0f-50.0f, 0.0f, 50.0f, 30.0f)];
        [_cancelButton setTitle:@"取消拒绝" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:JZGFont(16)];
        [_cancelButton setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(102, 166, 236)] forState:UIControlStateNormal];
        _cancelButton.layer.cornerRadius = 5;
        _cancelButton.layer.masksToBounds = YES;
        [self.popView addSubview:_cancelButton];
        
        //使用NSNotificationCenter 鍵盤出現時
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWasShown:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        
        //使用NSNotificationCenter 鍵盤隐藏時
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillBeHidden:)
                                                     name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}

- (CGSize)popViewSize{
    return CGSizeMake(300.0f, 300.0f);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_titleLabel sizeToFit];
    _titleLabel.frame = CGRectMake(0.0f, 20.0f, self.popView.width, _titleLabel.height);
    
    [_deleteButton sizeToFit];
    _deleteButton.frame = CGRectMake(self.popView.width-_deleteButton.width-15.0f, (CGRectGetMaxY(_titleLabel.frame)+15.0f-_deleteButton.height)/2, _deleteButton.width, _deleteButton.height);
    
    _separatorLine.frame = CGRectMake(0.0f, CGRectGetMaxY(_titleLabel.frame)+15.0f-CUTTING_LINE_HEIGHT, self.popView.width, CUTTING_LINE_HEIGHT);
    
    _contentTextView.frame = CGRectMake(20.0f, CGRectGetMaxY(_separatorLine.frame)+20.0f, self.popView.width-40.0f, 130.0f);
    
    
    
    _cancelButton.frame = CGRectMake(20.0f, CGRectGetMaxY(_contentTextView.frame)+20.0f, (self.popView.width-40.0f)/2 -10, 44.0f);
    _submitButton.frame = CGRectMake(CGRectGetMaxX(_cancelButton.frame)+20, CGRectGetMaxY(_contentTextView.frame)+20.0f, (self.popView.width-40.0f)/2-10, 44.0f);
}

-(void)popViewDidDisAppear{
    [UIView animateWithDuration:0.5 animations:^{
        self.popView.y = kScreenHeight;
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        _contentTextView.delegate = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }];
}

#pragma mark - UITextView Delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请填写拒绝原因"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""] || [textView.text isEqualToString:@"请填写拒绝原因"]) {
        textView.text = @"请填写拒绝原因";
        textView.textColor = RGBCOLOR(153, 153, 153);
    }
    else {
        textView.textColor = [UIColor blackColor];
    }
    return YES;
}

#pragma mark - NSNotification
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGFloat interval = [[info objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    if (interval == 0.0) {
        interval = 0.3;
    }
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    [UIView animateWithDuration:interval animations:^{
        CGRect rect = self.popView.frame;
        rect.origin.y = kScreenHeight - kbSize.height - self.popView.height;
        [self.popView setFrame:rect];
    } completion:^(BOOL finished) {
    }];
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //do something
}

@end
