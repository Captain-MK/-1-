//
//  JZGCarMileOrPriceOrYearController.m
//  JZGAppraiserNetwork
//
//  Created by Wen Dongxiao on 15/8/5.
//  Copyright (c) 2015年 Mars. All rights reserved.
//

#import "JZGCarMileOrPriceOrYearController.h"

@interface JZGCarMileOrPriceOrYearController ()
@property (nonatomic,strong) NSIndexPath *lastIndexPath;

@end

@implementation JZGCarMileOrPriceOrYearController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self configureCancelBtn];
    if ([self.tableHeitht isEqualToString:@"1"]) {
        CGFloat tableHeitht = SCREEN_HEIGHT-64-33-34-50;
        [self addMainTableViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, tableHeitht)];
        self.view.backgroundColor = [UIColor clearColor];
    } else if ([self.tableHeitht isEqualToString:@"carStyleHeight"]) {
        [self addMainTableViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];

    }
    else
        {
            [self addMainTableViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        }
    
    
    // Do any additional setup after loading the view.
}

#pragma mark 通过尺寸创建表格，并对其初始化
-(void)addMainTableViewWithFrame:(CGRect)rect{
    //初始化主表格
    _mainTableView = [[UITableView alloc]initWithFrame:rect];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.tableFooterView =[[UIView alloc]init];
    _mainTableView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.mainTableView];
    
    //初始化数组
    [self initDataArr];
}

#pragma mark 初始化数组
-(void)initDataArr{
    if (!dataArr) dataArr = [NSMutableArray array];
    [dataArr removeAllObjects];
    if (self.optionTitleArray.count!= 0) {
        dataArr = self.optionTitleArray;
    }else
    {
        //根据不同的类型，给数组赋值不同的数值
        switch (self.indexType) {
            case milleageState:{
                NSArray *milleDArray = @[@"2万以下",@"2-4万",@"4-6万",@"6-8万",@"8-10万",@"10万以上"];
                [dataArr addObjectsFromArray:milleDArray];
                self.title = @"里程";
            }
                break;
            case yearState:{
                NSArray *yearsArray =@[@"不限（7年内）",@"1年内",@"2年内",@"3年内",@"3-5年",@"5-7年"];
                [dataArr addObjectsFromArray:yearsArray];
                self.title = @"车龄";
            }
                break;
            case carPriceState:{
                NSArray *carPrices =@[@"不限",
                                      @"3万以内",
                                      @"3-5万",
                                      @"5-10万",
                                      @"10-15万",
                                      @"15-20万",
                                      @"20-30万",
                                      @"30-50万",@"50万以上"];
                [dataArr addObjectsFromArray:carPrices];
                self.title = @"价格";
            }
                break;
            case carConditionState:{
                NSArray *carPrices =@[@"不限",@"准新车",@"车况良好",@"正常损耗",@"车况较差"];
                [dataArr addObjectsFromArray:carPrices];
                self.title = @"价格";
            }
                break;
            case realMilleageState:{
                NSArray *carPrices =@[@"5000",
                                      @"10000",
                                      @"15000",
                                      @"20000",
                                      @"25000",
                                      @"30000",
                                      @"35000",
                                      @"40000",
                                      @"45000",
                                      @"50000",
                                      @"55000",
                                      @"60000",
                                      @"65000",
                                      @"70000"];
                [dataArr addObjectsFromArray:carPrices];
                self.title = @"预计年行驶里程";
            }
                break;
            case firstPayRateState:{
                NSArray *carPrices =@[@"30",
                                      @"35",
                                      @"40",
                                      @"45",
                                      @"50",
                                      @"55",
                                      @"60"];
                [dataArr addObjectsFromArray:carPrices];
                self.title = @"首付比例";
            }
                break;
            case loanState:{
                NSArray *carPrices =@[@"12个月",
                                      @"24个月",
                                      @"36个月",
                                      @"48个月",
                                      @"60个月"];
                [dataArr addObjectsFromArray:carPrices];
                self.title = @"贷款期限";
            }
                break;
            case loanFirstPayState:{
                NSArray *carPrices =@[@"三成",
                                      @"四成",
                                      @"五成",
                                      @"六成",
                                      @"七成",
                                      @"八成",@"九成"];
                [dataArr addObjectsFromArray:carPrices];
                self.title = @"首付比例";
            }
                break;
            case rePayYearState:{
                NSArray *carPrices =@[@"12 期",
                                      @"18 期",
                                      @"24 期",
                                      @"36 期",
                                      @"48 期"];
                [dataArr addObjectsFromArray:carPrices];
                self.title = @"还款期限";
            }
                break;
            case carsourceFromState:{
                NSArray *carPrices =@[@"不限",
                                      @"个人",
                                      @"商家"];
                [dataArr addObjectsFromArray:carPrices];
                self.title = @"来源";
            }
                break;
                
            case loanPeriodStatus:{
                NSArray *loanPeriod =@[@"1个月",
                                       @"3个月",
                                       @"6个月",@"1年",@"2年",@"3年"];
                [dataArr addObjectsFromArray:loanPeriod];
                self.title = @"月贷期限";
            }
                break;
            case carStyleStatus:{
                NSArray *carStyle =@[@"不限",@"微型车",
                                     @"小型车",
                                     @"紧凑型车",@"中型车",@"中大型车",@"大型车",@"小型SUV",@"紧凑型SUV",@"中型SUV",@"中大型SUV",@"全尺寸SUV",@"入门级跑车",@"中级跑车",@"超级跑车",@"小型MPV",@"大型MPV"];
                [dataArr addObjectsFromArray:carStyle];
                self.title = @"选择车型";
            }
                break;
                
            case creditRecordStatus:{
                NSArray *creditRecor =@[@"信用良好",
                                        @"少数逾期",
                                        @"长期多数逾期",@"无信用记录"];
                [dataArr addObjectsFromArray:creditRecor];
                self.title = @"信用记录";
            }
                break;
            case mortgageStatus:{
                NSArray *mortgage =@[@"有抵押(含贷款未还清)",
                                     @"无抵押"];
                [dataArr addObjectsFromArray:mortgage];
                self.title = @"抵押状态";
            }
                break;
            default:
                break;
        }
    }

}


#pragma mark 创建取消按钮
- (void)configureCancelBtn
{
//    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    [cancelBtn addTarget:self action:@selector(cancelBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
//    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [cancelBtn setTitle:@"取消" forState:UIControlStateHighlighted];
//    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
}

/**点击取消按钮*/
- (void)cancelBtnDidClick
{
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ID = @"JZGOldCarMilleageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [dataArr objectAtIndex:indexPath.row];
    cell.textLabel.font = JZGFont(15);
    cell.textLabel.textColor =COLOR_BLACK_MARCROS;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger newRow = [indexPath row];
    NSInteger oldRow = [self.lastIndexPath row];
    if (self.lastIndexPath == 0) {
        oldRow =0;
    }
    UITableViewCell *cell = (UITableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    
    UITableViewCell *lastrowcell = (UITableViewCell *)[tableView cellForRowAtIndexPath:self.lastIndexPath];
    if (newRow != oldRow) {
        lastrowcell.textLabel.textColor = COLOR_BLACK_MARCROS;
        cell.selected = !cell.selected;
        
        self.lastIndexPath = indexPath;
//        cell.textLabel.textColor =COLOR_BLUE_MARCROS;
        cell.textLabel.textColor =COLOR_BLACK_MARCROS;
    }else
    {
        lastrowcell.textLabel.textColor = COLOR_BLACK_MARCROS;
        cell.selected = !cell.selected;
        self.lastIndexPath = indexPath;
//        cell.textLabel.textColor =COLOR_BLUE_MARCROS;
        cell.textLabel.textColor =COLOR_BLACK_MARCROS;
    }

    if ([self.myDelegate respondsToSelector:@selector(sureWithMilleageSelectCell:)]) {
        [self returnCellData:indexPath.row];
    }
}

//通过index返回给前一个界面数据
-(void)returnCellData:(NSInteger)index{
    NSMutableDictionary *tempDic =[NSMutableDictionary dictionary];
    if (self.optionTitleArray.count!=0) {
        [tempDic setObject:[NSString stringWithFormat:@"%zd",index] forKey:@"optionId"];
        [tempDic setObject:[dataArr objectAtIndex:index] forKey:@"optionName"];
    }else
    {
        
        switch (self.indexType) {
            case yearState:
                [tempDic setObject:[NSString stringWithFormat:@"%zd",index] forKey:@"yearId"];
                [tempDic setObject:[dataArr objectAtIndex:index] forKey:@"yearName"];
                break;
            case carConditionState:
            {
                NSArray *level =@[@"",@"A",@"B",@"C",@"D"];
                [tempDic setObject:[level objectAtIndex:index] forKey:@"carConditionId"];
                [tempDic setObject:[dataArr objectAtIndex:index] forKey:@"carConditionName"];
            }
                
                break;
            case milleageState:
                [tempDic setObject:[NSString stringWithFormat:@"%zd",index] forKey:@"milleageId"];
                [tempDic setObject:[dataArr objectAtIndex:index] forKey:@"milleageName"];
                break;
            case carPriceState:
                [tempDic setObject:[NSString stringWithFormat:@"%zd",index] forKey:@"carPriceId"];
                [tempDic setObject:[dataArr objectAtIndex:index] forKey:@"carPriceName"];
                break;
            case realMilleageState:
                [tempDic setObject:[dataArr objectAtIndex:index] forKey:@"realMilleageName"];
                break;
            case firstPayRateState:
                [tempDic setObject:[dataArr objectAtIndex:index] forKey:@"firstPayRateName"];
                break;
            case loanState:
                [tempDic setObject:[dataArr objectAtIndex:index] forKey:@"loanName"];
                break;
            case loanFirstPayState:
                //            [tempDic setObject:[NSString stringWithFormat:@"%0.1f",0.1*(2+index)] forKey:@"downPaymentRate"];
                [tempDic setObject:[dataArr objectAtIndex:index] forKey:@"downPaymentRate"];
                break;
            case rePayYearState:
                [tempDic setObject:[NSString stringWithFormat:@"%0.0f",6.0*(2+index)] forKey:@"repaymentPeriod"];
                break;
            case carsourceFromState:
                [tempDic setObject:[NSString stringWithFormat:@"%zd",index] forKey:@"carsourceId"];
                [tempDic setObject:[dataArr objectAtIndex:index] forKey:@"carsourceFrom"];
                break;
            case loanPeriodStatus:
                [tempDic setObject:[NSString stringWithFormat:@"%zd",index] forKey:@"loanPeriodId"];
                [tempDic setObject:[dataArr objectAtIndex:index] forKey:@"loanPeriodName"];
                break;
                
            case creditRecordStatus:
                [tempDic setObject:[NSString stringWithFormat:@"%zd",index] forKey:@"creditRecordId"];
                [tempDic setObject:[dataArr objectAtIndex:index] forKey:@"creditRecordName"];
                break;
            case carStyleStatus:
                [tempDic setObject:[NSString stringWithFormat:@"%zd",index] forKey:@"carStyleID"];
                [tempDic setObject:[dataArr objectAtIndex:index] forKey:@"carStyleName"];
                break;
                
            case mortgageStatus:
                [tempDic setObject:[NSString stringWithFormat:@"%zd",index] forKey:@"mortgageId"];
                [tempDic setObject:[dataArr objectAtIndex:index] forKey:@"mortgageName"];
                break;
                
            default:
                break;
        }
    }
    
    [self.myDelegate sureWithMilleageSelectCell:tempDic];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)optionTitleArray
{
    if (!_optionTitleArray) {
        _optionTitleArray = [NSMutableArray array];
    }
    return _optionTitleArray;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
