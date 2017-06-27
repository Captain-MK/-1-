//
//  DSALertView.h
//
//  Created by jiaoxt on 5/13/14.
//

#import <UIKit/UIKit.h>

typedef void(^PLAlertViewBlock)();

@interface JZGAlertView : UIAlertView<UIAlertViewDelegate>{
    PLAlertViewBlock _cancelBlock;
    PLAlertViewBlock _sureBlock;
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles
                  cancelBlock:(PLAlertViewBlock)cancelBlock
                    sureBlock:(PLAlertViewBlock)sureBlock;

@end
