//
//  DSALertView.m
//
//  Created by jiaoxt on 5/13/14.
//

#import "JZGAlertView.h"

@implementation JZGAlertView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles
                  cancelBlock:(PLAlertViewBlock)cancelBlock
                    sureBlock:(PLAlertViewBlock)sureBlock{
    
    self = [self initWithTitle:title
                       message:message
                      delegate:self
             cancelButtonTitle:cancelButtonTitle
             otherButtonTitles:otherButtonTitles, nil];
    _cancelBlock = [cancelBlock copy];
    _sureBlock = [sureBlock copy];
    
    return self;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            if (_cancelBlock) {
                _cancelBlock();
            }
            break;
        }
        case 1:{
            if (_sureBlock) {
                _sureBlock();
            }
            break;
        }
        default:
            break;
    }
}

- (void)alertViewCancel:(UIAlertView *)alertView{
    if (_cancelBlock) {
        _cancelBlock();
    }
}

@end
