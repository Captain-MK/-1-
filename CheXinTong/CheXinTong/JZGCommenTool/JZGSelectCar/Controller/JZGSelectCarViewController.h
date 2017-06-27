//
//  JZGSelectCarViewController.h
//  JingZhenGu
//
//  Created by Mars on 15/12/28.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGBaseViewController.h"
#import "JZGSelectCarModel.h"
#import "JZGSelectCarDefine.h"

typedef void(^ReturnCarInfoBlock) (JZGSelectCarModel *selectModel);

@interface JZGSelectCarViewController : JZGBaseViewController

/**是否有全部品牌 YES:有 NO:没有 默认NO*/
@property (assign, nonatomic) BOOL haveAllBrand;

/**回调block*/
@property (strong, nonatomic) ReturnCarInfoBlock returnCarInfo;
/**显示样式*/
@property (assign, nonatomic) JZGCarInfoType selectCarType;
/**tableview高度*/
@property (assign, nonatomic) CGFloat kTableViewHeight;
/**显示样式*/
@property (assign, nonatomic) JZGShowNextViewType showType;
/**请求方式*/
@property (assign, nonatomic) JZGRequestUrlType requestType;

/**新车还是旧车 NO:旧车 YES:新车 默认:NO*/
@property (assign, nonatomic) BOOL isOldOrNew;

/**回调返回数据模型*/
- (void)returnInfoBlock:(ReturnCarInfoBlock)block;

@end
