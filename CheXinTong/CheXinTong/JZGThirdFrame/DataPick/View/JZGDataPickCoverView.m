//
//  JZGDataPickCoverView.m
//  JingZhenGu
//
//  Created by liuqt on 15/12/17.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGDataPickCoverView.h"
#import "JZGDataPickView.h"
#import "JZGCarRegDateMethod.h"

@interface JZGDataPickCoverView() <JZGDatePickerViewDelegate>
@property (nonatomic,copy) NSString *lienceTimeStr;
@property (nonatomic,strong) JZGDataPickView *datePickerView;
@property(nonatomic, strong) NSArray *years;
@property(nonatomic, strong) NSArray *months;
@property (nonatomic,strong) NSArray *days;
/**最小可选年的月份*/
@property(nonatomic, strong) NSArray *monthsForMinYear;
/**最大可选年的月份*/
@property(nonatomic, strong) NSArray *monthsForMaxYear;

/**当前年份*/
@property(nonatomic, strong) NSString * currentYear;
/**当前月份*/
@property(nonatomic, strong) NSString * currentMonth;

@property (nonatomic,strong)UITapGestureRecognizer *tapGes;
@end
@implementation JZGDataPickCoverView
- (id)initWithFrame:(CGRect)frame withCarModelId:(NSString *)carModelId regYear:(NSString *)regYear {
    if (self = [super initWithFrame:frame])
    {
        self.carModelId = carModelId;
        self.regYear = regYear;
        [self selectRegData];
    }
    return self;
}

#pragma mark  ------选择上牌时间
- (void)selectRegData
{
    WS(weakSelf);
    if (self.regYear.length != 0) {
        [self calculationDateWithYear:self.regYear ];
    }else {
        [[JZGHudManager share] showHUDWithTitle:@"加载中..." inView:self isPenetration:NO];
        [JZGCarRegDateMethod carRegDateRangeByCarId:self.carModelId responseData:^(NSDictionary *resultDict) {
            [[JZGHudManager share] hide];
            [weakSelf initializaDateWithDictionary:resultDict];
        } errcode:^(NSString *errorString) {
            [[JZGHudManager share] hide];
            [MBProgressHUD showError:errorString toView:self];
            [weakSelf dissmissCoverView];
            if ([weakSelf.delegate respondsToSelector:@selector(getError)]) {
                [weakSelf.delegate getError];
            }
        }];
    }
}

/**  上牌时间：开始时间选择车型年款前一年的6-12月，截止时间为当前年1到上个月 */
- (void)calculationDateWithYear:(NSString *)regYear
{
    NSString *minYear = [NSString stringWithFormat:@"%zd-06",[regYear integerValue] - 1];
    NSInteger currentYear = [NSString getNowYearOrMonth:1];
    NSInteger month = [NSString getNowYearOrMonth:2];
    NSString *maxYear = @"";
    NSString *curMonth = [NSString stringWithFormat:@"%zd",month];
    if (month  == 1) { // 当前月份为1月时，上牌时间为上一年的12月
        currentYear = currentYear-1;
        curMonth = @"12";
    }else
    {
        curMonth = [NSString stringWithFormat:@"0%zd",month - 1];
    }
    
    
    maxYear = [NSString stringWithFormat:@"%zd-%@",currentYear,curMonth];
    
    __weak typeof (self)weakSelf = self;
    [JZGCarRegDateMethod loadDataWithRegYear:minYear nextYear:maxYear block:^(NSDictionary *resultDict) {
        [weakSelf initializaDateWithDictionary:resultDict];
    }];
}

/** 加载计算后的数据 */
- (void)initializaDateWithDictionary:(NSDictionary *)resultDict
{
    self.datePickerView = nil;
    
    self.datePickerView.yearData = resultDict[@"years"];
    self.years = resultDict[@"years"];
    NSArray *mon  = resultDict[@"months"];
    self.months = [[mon reverseObjectEnumerator] allObjects];
    NSArray *monForMinYear = resultDict[@"monthsForMinYear"];
    
    self.monthsForMinYear = [[monForMinYear reverseObjectEnumerator] allObjects];
    NSArray *monsForMaxYear = resultDict[@"monthsForMaxYear"];
    self.monthsForMaxYear = [[monsForMaxYear reverseObjectEnumerator] allObjects];
    // 显示日期选择器
    [self showDatePikerView];
}



/**显示日期选择器*/
- (void)showDatePikerView
{
    __weak typeof (self)weakSelf = self;
    [self addSubview:self.datePickerView];
   [self.datePickerView bringSubviewToFront:self];
    self.datePickerView.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf addGestureRecognizer:weakSelf.tapGes];
        weakSelf.datePickerView.y = SCREEN_HEIGHT-self.datePickerView.height;
    }];
}

-(void)tapToHidView:(UITapGestureRecognizer *)tap{
    
    [self dissmissCoverView];
}

#pragma mark -  隐藏面板

- (void)dissmissCoverView
{
    if (self.tapGes) {
        [self removeGestureRecognizer:self.tapGes];
    }
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:0.02 animations:^{
        weakSelf.datePickerView.y = SCREEN_HEIGHT;
    }completion:^(BOOL finished) {
        weakSelf.datePickerView.hidden = YES;
        [weakSelf removeFromSuperview];
        if ([weakSelf.delegate respondsToSelector:@selector(tapBlankView)]) {
            [weakSelf.delegate tapBlankView];
        }
        
    }];
    
}

#pragma mark - 滚动年份

- (void)datePickerViewSelectYearIndex:(NSInteger)yearIndex handleType:(HandleType)handleType
{
    if (yearIndex == 0){
        self.datePickerView.monthData = self.monthsForMaxYear;
    }else if (yearIndex == self.years.count-1) {
        self.datePickerView.monthData = self.monthsForMinYear;
    }else {
        if (![self.datePickerView.monthData isEqual:self.months]) {
            self.datePickerView.monthData = self.months;
        }
    }
}

#pragma mark - 滚动月份

- (void)datePickerViewSelectYearIndex:(NSInteger)yearIndex monthIndex:(NSInteger)monthIndex handleType:(HandleType)handleType
{
    NSString *month;
    if (yearIndex == 0){
        if (monthIndex>=self.monthsForMaxYear.count) {
            month = self.monthsForMaxYear.firstObject;
        }else
        {
            month = self.monthsForMaxYear[monthIndex];
            
        }
        
    }else if (yearIndex == self.years.count-1) {
        if (monthIndex>=self.monthsForMinYear.count) {
            month = self.monthsForMinYear.firstObject;
        }else
        {
            month = self.monthsForMinYear[monthIndex];
            
        }
        
    }else {
        month = self.months[monthIndex];
    }
}

#pragma mark - 完成选择

- (void)datePickerViewSelectYearIndex:(NSInteger)yearIndex monthIndex:(NSInteger)monthIndex dayIndex:(NSInteger)dayIndex handleType:(HandleType)handleType
{
    NSString *year = self.years[yearIndex];
    NSString *month;
    if (yearIndex == 0){
        if (monthIndex>=self.monthsForMaxYear.count) {
            month = self.monthsForMaxYear.firstObject;
        }else
        {
            month = self.monthsForMaxYear[monthIndex];
            
        }
    }else if (yearIndex == self.years.count-1) {
        if (monthIndex>=self.monthsForMinYear.count) {
            month = self.monthsForMinYear.firstObject;
        }else
        {
            month = self.monthsForMinYear[monthIndex];
            
        }
    }else {
        month = self.months[monthIndex];
    }
    NSInteger yearInt = [[[year componentsSeparatedByString:@"年"] firstObject] integerValue];
    NSInteger monthInt = [[[month componentsSeparatedByString:@"月"] firstObject] integerValue];
    
    switch (handleType) {
        case LienceTime:
        {
            NSString *showStr = [NSString stringWithFormat:@"%@%@",year,month];
            self.lienceTimeStr = [NSString stringWithFormat:@"%zd-%02zd", yearInt, monthInt];
            if ([self.delegate respondsToSelector:@selector(selectedDataWithShowString:lienceTimeStr:)]) {
                [self.delegate selectedDataWithShowString:showStr lienceTimeStr:self.lienceTimeStr];
            }
        }
            break;
            
        default:
            break;
    }
    [self dissmissCoverView];
}

#pragma mark - lazyload

- (JZGDataPickView *)datePickerView
{
    if (!_datePickerView) {
        _datePickerView = [[JZGDataPickView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 230) title:@"请选择上牌时间" handleType:LienceTime];
        _datePickerView.delegate = self;
        
    }
    return _datePickerView;
}

- (UITapGestureRecognizer *)tapGes
{
    if (!_tapGes) {
        _tapGes =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToHidView:)];
    }
    return _tapGes;
}

@end
