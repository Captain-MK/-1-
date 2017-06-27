//
//  JZGCarMileOrPriceOrYearController.h
//  JZGAppraiserNetwork
//
//  Created by Wen Dongxiao on 15/8/5.
//  Copyright (c) 2015年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    milleageState = 0,                            //里程
    yearState,                                    //年限
    carConditionState,                            //车况
    carPriceState,                                //价格
    realMilleageState,                            //行驶里程
    firstPayRateState,                            //首付比例
    loanState,                                    //月贷查询中的期限
    loanFirstPayState,                            //贷款首付比率
    rePayYearState,                               //还款期限
    carsourceFromState,                           //来源
    mortgageStatus,                             // 抵押状态
    creditRecordStatus,                             // 信用记录
    loanPeriodStatus,                             // 贷款期限
    carStyleStatus,                                   // 车型
   

}carMilleageState;

@protocol  JZGCarMileOrPriceOrYearControllerDelegate <NSObject>

@optional
-(void) sureWithMilleageSelectCell:(NSMutableDictionary*)dataDic;
@end

@interface JZGCarMileOrPriceOrYearController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *dataArr; //关联的数组
}

-(void)addMainTableViewWithFrame:(CGRect)rect;
@property(nonatomic,assign)id<JZGCarMileOrPriceOrYearControllerDelegate> myDelegate;
@property(nonatomic,assign)carMilleageState indexType; //类型分类，1为里程，2年限，3车况
@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *optionTitleArray;

/**
 *  通过对象初始化数组
 */
-(void)initDataArr;
/**
 *  创建取消按钮
 */
-(void)configureCancelBtn;
@property (nonatomic,copy) NSString *tableHeitht;

@end
