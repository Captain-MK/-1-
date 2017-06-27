//
//  JZGSelectCarModelViewController.h
//  JZGDetectionPlatform
//
//  Created by Mars on 15/12/28.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGBaseViewController.h"
#import "JZGSelectCarModel.h"
#import "JZGSelectCarDefine.h"
@class JZGSelectCarViewController;

typedef void (^ReturnCarModelBlock) (JZGSelectCarModel *selectModel);

@interface JZGSelectCarModelViewController : JZGBaseViewController

@property (strong, nonatomic) JZGSelectCarModel *selectCarModel;

@property (assign, nonatomic) CGFloat kTableViewHeight;

///**显示样式 YES 正常push NO:非正常push*/
//@property (assign, nonatomic) BOOL showStyleType;

/**车型选择接口*/
@property (assign, nonatomic) JZGRequestUrlType requestType;
/**显示样式 */
@property (assign, nonatomic) JZGShowNextViewType showType;

/**新车还是旧车 NO:旧车 YES:新车*/
@property (assign, nonatomic) BOOL isOldOrNew;

@property (strong, nonatomic) ReturnCarModelBlock returnCarBlock;

- (void)returnCarModel:(ReturnCarModelBlock)block;

@end
