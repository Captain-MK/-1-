//
//  JZGDataPickView.m
//  JingZhenGu
//
//  Created by liuqt on 15/12/17.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGDataPickView.h"
#import "NSString+Tool.h"
#import "JZGDataPikerModel.h"
#import "JZGDataPickCell.h"
typedef enum{
    tableView_year  = 999,
    tableView_month,
    tableView_day
} tableViewType;

const CGFloat JZGDatePickerViewRow = 5;// 显示多少行

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

@interface JZGDataPickView()  <UITableViewDataSource,UITableViewDelegate>
/**工具条*/
@property(nonatomic, weak) UIView *toolView;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UIButton *doneButton;
@property(nonatomic, weak) UIView *otherView;
/**两个table*/
@property(nonatomic, weak) UIView *tableContainerView;
@property(nonatomic, weak) UITableView *yearTableView;
@property(nonatomic, weak) UITableView *monthTableView;
@property(nonatomic, weak) UITableView *dayTableView;
/**遮罩*/
@property(nonatomic, weak) UIView *coverView;
@property(nonatomic, assign) CGFloat cellHeight;
@end

@implementation JZGDataPickView
- (CGFloat)cellHeight
{
    if (!_cellHeight)
        _cellHeight = (NSInteger)(self.tableContainerView.height / JZGDatePickerViewRow);
    return _cellHeight;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title handleType:(HandleType)handType
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor lightGrayColor];
        self.title = title;
        self.handleType = handType;
        // 创建所有子控件
        [self configureSubviews];
    }
    return self;
}

/**创建所有子控件*/
- (void)configureSubviews
{
    // 创建工具条
    [self configureToolView];
    
    // 创建tableView
    [self configureTableView];
}

/**创建工具条*/
- (void)configureToolView
{
    UIView *toolView = [[UIView alloc]init];
    toolView.backgroundColor = [UIColor whiteColor];
    self.toolView = toolView;
    [self addSubview:toolView];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.font = JZGFont(15.0f);
    titleLabel.text = @"请选择时间";
    self.titleLabel = titleLabel;
    [toolView addSubview:titleLabel];
    
    UIButton *doneButton = [[UIButton alloc]init];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    doneButton.titleLabel.font = JZGFont(15.0f);
    [doneButton setTitleColor:RGB(69, 135, 195) forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(doneButtonDidClick:) forControlEvents:UIControlEventTouchDown];
    self.doneButton = doneButton;
    [toolView addSubview:doneButton];
}

/**创建tableView*/
- (void)configureTableView
{
    UIView *otherView = [[UIView alloc]init];
    otherView.backgroundColor = [UIColor whiteColor];
    [self addSubview:otherView];
    self.otherView = otherView;
    
    UIView *tableContainerView = [[UIView alloc]init];
    self.tableContainerView = tableContainerView;
    [otherView addSubview:tableContainerView];
    
    self.yearTableView = [self tableView];
    self.yearTableView.tag = tableView_year;
    
    self.monthTableView = [self tableView];
    self.monthTableView.tag = tableView_month;
    
    UIView *coverView = [[UIView alloc]init];
    coverView.backgroundColor = RGB(26,155,245);
    coverView.userInteractionEnabled = NO;
    self.coverView = coverView;
    [tableContainerView insertSubview:coverView atIndex:0];
}

- (UITableView *)tableView
{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableContainerView addSubview:tableView];
    return tableView;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat separatorH = 0.5;// 分割线高度
    // 工具条
    _toolView.width = self.width;
    _toolView.height = 44;
    
    CGFloat marginLR = 15;// 左右间距
    _titleLabel.x = marginLR;
    _titleLabel.size = [NSString sizeWithText:self.title andFont:_titleLabel.font];
    _titleLabel.centerY = _toolView.height*0.5;
    
    _doneButton.width = 100;
    _doneButton.height = _toolView.height;
    _doneButton.x = _toolView.width - marginLR - _doneButton.width;
    
    _otherView.frame = CGRectMake(0, CGRectGetMaxY(_toolView.frame)+separatorH, self.width, self.height-CGRectGetMaxY(_toolView.frame)-separatorH);
    // 两个table
    CGFloat tableMarginTB = 20;// table上下间距
    _tableContainerView.frame = CGRectMake(0, tableMarginTB, self.width, _otherView.height-tableMarginTB*2);
    _yearTableView.frame = CGRectMake(0, 0, _tableContainerView.width*0.5, _tableContainerView.height);
    _monthTableView.size = _yearTableView.size;
    _monthTableView.x = CGRectGetMaxX(_yearTableView.frame);
    
    NSInteger inset = JZGDatePickerViewRow/2;
    
    _yearTableView.contentInset = UIEdgeInsetsMake(inset*self.cellHeight, 0, inset*self.cellHeight, 0);
    _yearTableView.contentOffset = CGPointMake(0, -inset*self.cellHeight);
    _monthTableView.contentInset = UIEdgeInsetsMake(inset*self.cellHeight, 0, inset*self.cellHeight, 0);
    _monthTableView.contentOffset = CGPointMake(0, -inset*self.cellHeight);
    
    _coverView.frame = CGRectMake(marginLR, inset*self.cellHeight, self.width-2*marginLR, self.cellHeight);
    if (self.handleType != LienceTime) {
        
        self.dayTableView = [self tableView];
        self.dayTableView.tag = tableView_day;
        _yearTableView.frame = CGRectMake(0, 0, _tableContainerView.width*0.3, _tableContainerView.height);
        _monthTableView.size = _yearTableView.size;
        _monthTableView.x = CGRectGetMaxX(_yearTableView.frame);
        _dayTableView.size = _yearTableView.size;
        _dayTableView.x = CGRectGetMaxX(_monthTableView.frame);
        
        NSInteger inset = JZGDatePickerViewRow/2;
        
        _yearTableView.contentInset = UIEdgeInsetsMake(inset*self.cellHeight, 0, inset*self.cellHeight, 0);
        _yearTableView.contentOffset = CGPointMake(0, -inset*self.cellHeight);
        _monthTableView.contentInset = UIEdgeInsetsMake(inset*self.cellHeight, 0, inset*self.cellHeight, 0);
        _monthTableView.contentOffset = CGPointMake(0, -inset*self.cellHeight);
        _dayTableView.contentInset = UIEdgeInsetsMake(inset*self.cellHeight, 0, inset*self.cellHeight, 0);
        _dayTableView.contentOffset = CGPointMake(0, -inset*self.cellHeight);
        _coverView.frame = CGRectMake(marginLR, inset*self.cellHeight, self.width-2*marginLR, self.cellHeight);
    }
    
    
}
- (void)setYearData:(NSArray *)yearData
{
    _yearData = [self yearOrMonthDataToDatePikerItemArray:yearData];
}

- (void)setMonthData:(NSArray *)monthData
{
    _monthData = [self yearOrMonthDataToDatePikerItemArray:monthData];
    [self.monthTableView reloadData];
    if (_monthTableView.bounds.size.height) {
        
        [self.monthTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}
- (void)setDayData:(NSArray *)dayData
{
    _dayData = [self yearOrMonthDataToDatePikerItemArray:dayData];
    [self.dayTableView reloadData];
    [self.dayTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
- (NSArray *)yearOrMonthDataToDatePikerItemArray:(NSArray *)data
{
    NSMutableArray *arrayM = [NSMutableArray array];
    NSInteger index = 0;
    for (NSString *str in data) {
        JZGDataPikerModel *item = [[JZGDataPikerModel alloc]init];
        if (index == 0) {
            item.hightLight = YES;
            index = -1;
        }
        item.title = str;
        [arrayM addObject:item];
    }
    return arrayM;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == tableView_year){
        return self.yearData.count;
    }else if (tableView.tag == tableView_month){
        return self.monthData.count;
    }else if (tableView.tag == tableView_day){
        return self.dayData.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JZGDataPickCell *cell = [JZGDataPickCell cellWithTableView:tableView];
    NSArray *itemArray;
    if (tableView.tag == tableView_year){
        itemArray = self.yearData[indexPath.row];
        cell.datePickModel = (JZGDataPikerModel *)itemArray;
    }else if (tableView.tag == tableView_month){
        itemArray = self.monthData[indexPath.row];
        cell.datePickModel = (JZGDataPikerModel *)itemArray;
    }else if (tableView.tag == tableView_day){
        itemArray = self.dayData[indexPath.row];
        cell.datePickModel = (JZGDataPikerModel *)itemArray;
    }

    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.doneButton.userInteractionEnabled = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger row = [self selectedCellIndex:scrollView];
    [self highLightCell:scrollView atRowIndex:row];
    
    if (scrollView.tag == tableView_year && !scrollView.isDragging){
        if ([self.delegate respondsToSelector:@selector(datePickerViewSelectYearIndex: handleType:)]){
            [self.delegate datePickerViewSelectYearIndex:[self selectedCellIndex:self.yearTableView] handleType:self.handleType];
        }
    }else if (scrollView.tag == tableView_month && !scrollView.isDragging)
    {
        if (self.handleType  == LienceTime) {
            //返回选中年份和月份
            if ([self.delegate respondsToSelector:@selector(datePickerViewSelectYearIndex:monthIndex: handleType:)]){
                [self.delegate datePickerViewSelectYearIndex:[self selectedCellIndex:self.yearTableView] monthIndex:[self selectedCellIndex:self.monthTableView] handleType:self.handleType];
            }
        }
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!scrollView.isDragging){
        [self selectCellInCenter:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.doneButton.userInteractionEnabled = YES;
    [self selectCellInCenter:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.doneButton.userInteractionEnabled = YES;
}

/**选中cell中间*/
- (void)selectCellInCenter:(UIScrollView *)scrollView
{
    NSInteger row = [self selectedCellIndex:scrollView];
    CGFloat newOffset = row*self.cellHeight;
    newOffset -= (self.tableContainerView.height/2.0-self.cellHeight/2.0);
    [scrollView setContentOffset:CGPointMake(0.0, newOffset) animated:YES];
}

/**选中cell的index*/
- (NSInteger)selectedCellIndex:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    offset += scrollView.contentInset.top;
    NSInteger mod = (NSInteger)offset%(NSInteger)self.cellHeight;
    CGFloat newValue = (mod >= self.cellHeight/2.0) ? offset+(self.cellHeight-mod) : offset-mod;
    NSInteger row = (NSInteger)(newValue/self.cellHeight);
    if (scrollView.tag == tableView_year) {
        if (row > self.yearData.count-1)
            row = self.yearData.count-1;
    }else if (scrollView.tag == tableView_month){
        if (row > self.monthData.count-1)
            row = self.monthData.count-1;
    }else if (scrollView.tag == tableView_day){
        if (row > self.dayData.count-1)
            row = self.dayData.count-1;
    }
    return row;
}

/**高亮选中的cell*/
- (void)highLightCell:(UIScrollView *)scrollView atRowIndex:(NSInteger)rowIndex
{
    if (scrollView.tag == tableView_year)
    {
        [self hightLightYearOrMonthCell:0 withCellIndex:rowIndex];
        [self.yearTableView reloadData];
    }else if (scrollView.tag == tableView_month)
    {
        [self hightLightYearOrMonthCell:1 withCellIndex:rowIndex];
        [self.monthTableView reloadData];
    }else if (scrollView.tag == tableView_day)
    {
        [self hightLightYearOrMonthCell:2 withCellIndex:rowIndex];
        [self.dayTableView reloadData];
    }
}

/**高亮年或月的cell 0：年，1：月*/
- (void)hightLightYearOrMonthCell:(NSInteger)yearOrMonth withCellIndex:(NSInteger)cellIndex
{
    NSArray *itemArray;
    if (yearOrMonth == 0) {
        itemArray = self.yearData;
    }else if (yearOrMonth == 1){
        itemArray = self.monthData;
    }
    
    if (itemArray == nil)return;
    for (NSInteger i = 0;i < itemArray.count;i++) {
        JZGDataPikerModel *item = (JZGDataPikerModel *)itemArray[i];
        item.hightLight = (i == cellIndex);
    }
}

/**完成按钮点击事件*/
- (void)doneButtonDidClick:(UIButton *)doneBtn
{
    doneBtn.userInteractionEnabled = NO;
    if (self.handleType  == LienceTime) {
        if ([self.delegate respondsToSelector:@selector(datePickerViewSelectYearIndex:monthIndex:dayIndex:handleType:)])
        {
            NSInteger selectedYear = [self selectedCellIndex:_yearTableView];// 选中年的index
            NSInteger selectedMonth = [self selectedCellIndex:_monthTableView];// 选中月的index
            NSInteger selectedDay = [self selectedCellIndex:_dayTableView];// 选中月的index
            self.doneButton.userInteractionEnabled = YES;
            [self.delegate datePickerViewSelectYearIndex:selectedYear monthIndex:selectedMonth dayIndex:selectedDay handleType:self.handleType];
        }
        
    }else
    {
        if ([self.delegate respondsToSelector:@selector(datePickerViewSelectYearIndex:monthIndex: handleType:)])
        {
            NSInteger selectedYear = [self selectedCellIndex:_yearTableView];// 选中年的index
            NSInteger selectedMonth = [self selectedCellIndex:_monthTableView];// 选中月的index
            
            self.doneButton.userInteractionEnabled = YES;
            [self.delegate datePickerViewSelectYearIndex:selectedYear monthIndex:selectedMonth handleType:self.handleType];
        }
        
    }
}
- (void)dealloc
{
    self.yearTableView.delegate = nil;
    self.yearTableView.dataSource = nil;
    self.monthTableView.delegate = nil;
    self.monthTableView.dataSource = nil;
}

@end
