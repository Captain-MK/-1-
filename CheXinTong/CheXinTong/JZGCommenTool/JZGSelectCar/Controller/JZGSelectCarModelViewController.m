//
//  JZGSelectCarModelViewController.m
//  JZGDetectionPlatform
//
//  Created by Mars on 15/12/28.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGSelectCarModelViewController.h"
#import "JZGSelectCarTableViewCell.h"
#import "JZGNetworkManager.h"

@interface JZGSelectCarModelViewController ()<UITableViewDataSource,UITableViewDelegate>

/**列表*/
@property (strong, nonatomic) UITableView *tableView;
/**数据数组*/
@property (strong, nonatomic) NSMutableArray *dataSource;
/**组头*/
@property (strong, nonatomic) NSMutableArray *sectionTitleArray;
/**返回按钮*/
//@property (weak, nonatomic) UIButton *backButton;

@end

@implementation JZGSelectCarModelViewController

- (NSString *)defaultTitle{
    return @"车型选择";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [self createBackButton];
    [self.view addSubview:self.tableView];
    
    [self loadCarModelData];
}

- (void)initializaTopView
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 20, kScreenWidth, 44);
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    label.text = self.title;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithHexString:JZG_APP_BACKGROUND_COLOUR];
    label.font = JZGFont(17);
    [view addSubview:label];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, kScreenWidth, 1)];
    line.backgroundColor = COLOR_LINE_MARCROS;
    [view addSubview:line];
    
    [self.view addSubview:view];
}

#pragma mark - private methods
//- (void)createBackButton
//{
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back_button.png"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
//}

//- (void)back
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (NSDictionary *)initializaModelParameters
{
    NSDictionary *dict = nil;
    switch (self.requestType) {
        case JZGRequestUrlDefaultType:
        {
            dict = @{@"op":@"GetStyle",@"ModelId":self.selectCarModel.styleId,@"InSale":@(self.isOldOrNew),@"tokenid":@"1"};
        }
            break;
        case JZGRequestUrlValuationType:
        {
            dict = @{@"op":@"GetValuationStyle",@"ModelId":self.selectCarModel.styleId,@"tokenid":@"1"};
        }
            break;
        case JZGRequestUrlAppointCarType:
        {
            dict = @{@"Op":@"carstyle",@"modleid":self.selectCarModel.styleId,@"tokenid":@"1",@"token":[JZGUserDataModel currentLoginUser].token,@"userid":[JZGUserDataModel currentLoginUser].UserID};
        }
            break;
            
        default:
            break;
    }
    
    return dict;
}

- (void)loadCarModelData
{
    NSDictionary *dict = [self initializaModelParameters];
    [[JZGHudManager share] showHUDWithTitle:@"加载中..." inView:self.view isPenetration:NO];
    [JZGNetworkManager postReqeustWithURL:self.requestType == JZGRequestUrlAppointCarType ? kSelectAppointUrl :kSelectCarUrl parameters:dict successBlock:^(id returnData, NSInteger code, NSString *msg) {
        [[JZGHudManager share] hide];
        if (self.requestType != JZGRequestUrlAppointCarType) {
            if ([returnData[@"status"] integerValue] ==100) {
                [self parsCarModelData:returnData[@"YearGroupList"]];
            }else
            {
                [MBProgressHUD showError:returnData[@"msg"] toView:JZGAppDelegate.window];
            }

        }else
        {
            if ([returnData[@"status"] integerValue] ==1) {
                [self parsCarModelData:returnData[@"YearGroupList"]];
            }else
            {
                [MBProgressHUD showError:returnData[@"msg"] toView:JZGAppDelegate.window];
            }

        }
        
        
    } failureBlock:^(NSError *error) {
        [[JZGHudManager share] hide];
        [MBProgressHUD showError:error.userInfo[PL_ERROR_INFO_KEY] toView:self.view];
    }];
}

- (void)parsCarModelData:(NSArray *)array
{
    for (NSDictionary *dict in array) {
        NSMutableArray *attArray = [NSMutableArray array];
        NSString *str = dict[@"Year"];
        
        NSArray *arr = dict[@"StyleList"];
        for (NSDictionary *dic in arr) {
            JZGSelectCarModel *model = [JZGSelectCarModel carModelWithDict:dic];
            if (![attArray containsObject:model]) {
                [attArray addObject:model];
            }
        }
        if (![self.sectionTitleArray containsObject:str]) {
            [self.sectionTitleArray addObject:str];
        }
        if (![self.dataSource containsObject:attArray]) {
            [self.dataSource addObject:attArray];
        }
    }
    
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JZGSelectCarTableViewCell *cell = nil;
    cell = [JZGSelectCarTableViewCell cellWithTableView:tableView byCellType:JZGSelectCarModelType];
    cell.selectCarModel = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self loadSelectCarModel:indexPath];
    self.returnCarBlock(self.selectCarModel);
    [self selectTableView:tableView atIndexPath:indexPath];
}

- (void)selectTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    switch (self.showType) {
        case JZGShowNextViewPushType:
        {
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 3] animated:YES];
        }
            break;
        case JZGShowNextViewPushSlideType:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case JZGShowNextViewPresentType:
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case JZGShowNextViewPresentSlideType:
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

- (void)loadSelectCarModel:(NSIndexPath *)indexPath
{
    JZGSelectCarModel *model = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    self.selectCarModel.modelId = model.modelId;
    self.selectCarModel.modelName = model.modelName;
    self.selectCarModel.modelYear = model.modelYear;
    self.selectCarModel.modelMsrp = model.modelMsrp;
    self.selectCarModel.modelFullName = model.modelFullName;
    self.selectCarModel.seatNum = model.seatNum;
    self.selectCarModel.displacement = model.displacement;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self initializaTableHeaderView:tableView atSection:section];
}

- (UIView *)initializaTableHeaderView:(UITableView *)tableView atSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = JZGUIColorFromRGB(0xf8f8f8);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, kScreenWidth - 50, 20)];
    label.font = JZGFont(17.0f);
    label.textColor = COLOR_BLUE_MARCROS;
    [view addSubview:label];
    
    label.text = [self.sectionTitleArray objectAtIndex:section];

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000000001f;
}

- (void)returnCarModel:(ReturnCarModelBlock)block
{
    self.returnCarBlock = block;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataSource objectAtIndex:section] count];
}

/**列表组数*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}

#pragma mark - setters and getters
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (UITableView *)tableView
{
    
    CGRect rect = self.view.bounds;
    
    if (self.showType == JZGShowNextViewPushType || self.showType == JZGShowNextViewPresentType) {
        rect = CGRectMake(0, 0, kScreenWidth, self.kTableViewHeight-64);
    }
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

- (NSMutableArray *)sectionTitleArray
{
    if (!_sectionTitleArray) {
        _sectionTitleArray = [NSMutableArray array];
    }
    
    return _sectionTitleArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
