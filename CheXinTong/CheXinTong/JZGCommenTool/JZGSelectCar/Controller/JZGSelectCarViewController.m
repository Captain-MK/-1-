//
//  JZGSelectCarViewController.m
//  JingZhenGu
//
//  Created by Mars on 15/12/28.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGSelectCarViewController.h"
#import "JZGSelectCarTableViewCell.h"
#import "JZGCarStyleView.h"
#import "JZGSelectCarModelViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "JZGTableIndexView.h"

#pragma mark - JZGTableIndexView
#define CRAYON_NAME(CRAYON)	[[CRAYON componentsSeparatedByString:@"#"] objectAtIndex:0]

@interface JZGSelectCarViewController ()<UITableViewDataSource,UITableViewDelegate,JZGTableIndexViewDataSource>{
    UITableView *_brandTableView;
    UITableView *_styleTableView;
    UIView *_contentView;
}

/**车系视图*/
@property (strong, nonatomic) JZGCarStyleView *carStyleView;
/**数据数组*/
@property (strong, nonatomic) NSMutableArray *dataSource;
/**上一个indexPath*/
@property (strong, nonatomic) NSIndexPath *lastIndexPath;
/**品牌组头*/
@property (strong, nonatomic) NSMutableArray *brandSectionTitleArray;
/**品牌数组*/
@property (strong, nonatomic) NSMutableArray *brandArray;
/**车系分组名称*/
@property (strong, nonatomic) NSMutableArray *styleSectionArray;
/**车系数组*/
@property (strong, nonatomic) NSMutableArray *styleArray;

/**当前选择数据模型*/
@property (strong, nonatomic) JZGSelectCarModel *selectCarModel;
@property (weak, nonatomic) UIImageView *brandImageView;
@property (weak, nonatomic) UILabel *brandNameLabel;

/**返回按钮*/
//@property (weak, nonatomic) UIButton *backButton;


#pragma mark - JZGTableIndexView
// properties for section array
@property (nonatomic, strong) NSString *pathname;
@property (nonatomic, strong) NSArray *crayons;
@property (nonatomic, strong) NSString *alphaString;
@property (nonatomic, strong) NSMutableArray *sectionArray;

// properties for tableView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIColor *tableColor;
@property (nonatomic, strong) UIColor *tableTextColor;
@property (nonatomic, strong) UIColor *tableSeparatorColor;
@property (nonatomic, strong) UIColor *tableHeaderColor;
@property (nonatomic, strong) UIColor *tableHeaderTextColor;
@property (nonatomic, strong) UIFont *useFont;

@property (weak, nonatomic) JZGSelectCarModelViewController *carModelView;


// JZGTableIndexView
@property (nonatomic, strong) JZGTableIndexView *indexView;

// properties for exampleView delegate
//@property (nonatomic, strong) NSArray * allExamples;

#pragma mark all properties from MJNIndexView
// set this to NO if you want to get selected items during the pan (default is YES)
@property (nonatomic, assign) BOOL getSelectedItemsAfterPanGestureIsFinished;

// set the font of the selected index item (usually you should choose the same font with a bold style and much larger)
// (default is the same font as previous one with size 40.0 points)
@property (nonatomic, strong) UIFont *selectedItemFont;

// set the color for index items
@property (nonatomic, strong) UIColor *fontColor;

// set if items in index are going to darken during a pan (default is YES)
@property (nonatomic, assign) BOOL darkening;

// set if items in index are going ti fade during a pan (default is YES)
@property (nonatomic, assign) BOOL fading;

// set the color for the selected index item
@property (nonatomic, strong) UIColor *selectedItemFontColor;

// set index items aligment (NSTextAligmentLeft, NSTextAligmentCenter or NSTextAligmentRight - default is NSTextAligmentCenter)
@property (nonatomic, assign) NSTextAlignment itemsAligment;

// set the right margin of index items (default is 10.0)
@property (nonatomic, assign) CGFloat rightMargin;

// set the upper margin of index items (default is 20.0)
// please remember that margins are set for the largest size of selected item font
@property (nonatomic, assign) CGFloat upperMargin;

// set the lower margin of index items (default is 20.0)
// please remember that margins are set for the largest size of selected item font
@property (nonatomic, assign) CGFloat lowerMargin;

// set the maximum amount for item deflection (default is 75.0)
@property (nonatomic,assign) CGFloat maxItemDeflection;

// set the number of items deflected below and above the selected one (default is 5)
@property (nonatomic, assign) NSInteger rangeOfDeflection;

// set the curtain color if you want a curtain to appear (default is none)
@property (nonatomic, strong) UIColor *curtainColor;

// set the amount of fading for the curtain between 0 to 1 (default is 0.2)
@property (nonatomic, assign) CGFloat curtainFade;

// set if you need a curtain not to hide completely
@property (nonatomic, assign) BOOL curtainStays;

// set if you want a curtain to move while panning (default is NO)
@property (nonatomic, assign) BOOL curtainMoves;

// set if you need curtain to have the same upper and lower margins (default is NO)
@property (nonatomic, assign) BOOL curtainMargins;

// set this property to YES and it will automatically set margins so that gaps between items are 5.0 points (default is YES)
@property BOOL ergonomicHeight;

@end

@implementation JZGSelectCarViewController

- (NSString *)defaultTitle
{
    return @"车辆选择";
}


//dwx 添加  待测试
- (void)leftButtonMethod {
    if (self.showType == JZGShowNextViewPushType) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
}
#pragma mark - lift cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    [self loadCarBrandData];
    [self initializeOptionView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.indexView.hidden = NO;
}

/**获取请求品牌数据参数*/
- (NSDictionary *)initializaBrandParameters
{
    NSDictionary *dic = nil;
    switch (self.requestType) {
        case JZGRequestUrlDefaultType:
        {
            dic = @{@"op":@"GetMake",@"InSale":@(self.isOldOrNew),@"tokenid":@(1)};
        }
            break;
        case JZGRequestUrlValuationType:
        {
            dic = @{@"op":@"GetValuationMake",@"tokenid":@(1)};
        }
            break;
        case JZGRequestUrlAppointCarType:
        {
            dic = @{@"op":@"carbrandinfo",@"userid":[JZGUserDataModel currentLoginUser].UserID,@"companyid":[JZGUserDataModel currentLoginUser].StoreId,@"token":[JZGUserDataModel currentLoginUser].token};
        }
            break;
            
            
        default:
            break;
    }
    
    return dic;
}

/**加载品牌数据*/
- (void)loadCarBrandData
{
    [[JZGHudManager share] showHUDWithTitle:@"加载中..." inView:self.view isPenetration:NO];
    NSDictionary *dict = [self initializaBrandParameters];
    WS(weakSelf);
    [JZGNetworkManager postReqeustWithURL:self.requestType == JZGRequestUrlAppointCarType ? kSelectAppointUrl :kSelectCarUrl
                               parameters:dict
                             successBlock:^(id returnData, NSInteger code, NSString *msg)
    {
        [[JZGHudManager share] hide];
        if (weakSelf.requestType != JZGRequestUrlAppointCarType) {
            if ([returnData[@"status"] integerValue] == 100) {
                NSArray *array = nil;
                if (weakSelf.requestType == JZGRequestUrlDefaultType) {
                    array = returnData[@"MakeListNew"];
                }else if (weakSelf.requestType == JZGRequestUrlValuationType)
                    array = returnData[@"MakeList"];
                
                [weakSelf sortBrandGroup:array];
            }else
            {
                [MBProgressHUD showError:returnData[@"msg"] toView:JZGAppDelegate.window];
            }
        }else {
            if ([returnData[@"status"] integerValue] == 1) {
                NSArray *array = nil;
                array = returnData[@"MakeList"];
                [weakSelf sortBrandGroup:array];
            }else
            {
                [MBProgressHUD showError:returnData[@"msg"] toView:JZGAppDelegate.window];
            }
            
        }
        
        
        [weakSelf getIndexValue];
        [weakSelf refreshTable];
    }
        failureBlock:^(NSError *error)
    {
        [[JZGHudManager share] hide];
        [MBProgressHUD showError:[JZGNetworkError errorWithCode:error.code] toView:JZGAppDelegate.window];
    }];
}

/**品牌数据排序*/
- (void)sortBrandGroup:(NSArray *)array
{
    if (self.haveAllBrand) {
        [self.brandSectionTitleArray addObject:@"全"];
        
        JZGSelectCarModel *brandModel = [[JZGSelectCarModel alloc] init];
        brandModel.brandIcon = @"";
        brandModel.brandName = @"全部品牌";
        brandModel.brandId = @"0";
        brandModel.brandGroup = @"全";
        NSArray *arr = @[brandModel];
        [self.brandArray addObject:arr];
    }
    
    for (char i = 'A'; i <= 'Z'; i++) {
        NSMutableArray *attArray = [NSMutableArray array];
        
        for (NSDictionary *dic in array) {
            JZGSelectCarModel *model = [JZGSelectCarModel carBrandModelWithDict:dic];

            if ([model.brandGroup isEqualToString:[NSString stringWithFormat:@"%c",i]]) {
                if (![attArray containsObject:model]) {
                    [attArray addObject:model];
                }
                
                if (![self.brandSectionTitleArray containsObject:[NSString stringWithFormat:@"%c",i]]) {
                    [self.brandSectionTitleArray addObject:[NSString stringWithFormat:@"%c",i]];
                }
            }
        }
        
        if (![self.brandArray containsObject:attArray]) {
            if ([attArray count] != 0) {
                [self.brandArray addObject:attArray];
            }
        }
    }
    
    [_brandTableView reloadData];
}

- (void)selectCarModelView {
    JZGSelectCarModelViewController *carModelView = [[JZGSelectCarModelViewController alloc] init];
    [self addChildViewController:carModelView];
    carModelView.selectCarModel = self.selectCarModel;
    carModelView.kTableViewHeight = self.kTableViewHeight;
    __weak typeof(self) weakSelf = self;
    [carModelView returnCarModel:^(JZGSelectCarModel *selectModel) {
        weakSelf.returnCarInfo(selectModel);
        [weakSelf dismissCarModelView];
        [weakSelf dismissViewController];
    }];
    
    self.carModelView = carModelView;
    [self.view addSubview:carModelView.view];
    [carModelView didMoveToParentViewController:self];
}

- (void)dismissViewController
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)dismissCarModelView {
    if (self.carModelView) {
        [self.carModelView willMoveToParentViewController:nil];
        [self.carModelView.view removeFromSuperview];
        [self.carModelView removeFromParentViewController];
    }
}

/**获取请求车系数据参数*/
- (NSDictionary *)initializaStyleParameters
{
    NSDictionary *dict = nil;
    switch (self.requestType) {
        case JZGRequestUrlDefaultType:
        {
            dict = @{@"op":@"GetModel",@"MakeId":self.selectCarModel.brandId,@"InSale":@(self.isOldOrNew),@"tokenid":@"1"};
        }
            break;
        case JZGRequestUrlValuationType:
        {
            dict = @{@"op":@"GetValuationModel",@"MakeId":self.selectCarModel.brandId,@"tokenid":@"1"};
        }
            break;
        case JZGRequestUrlAppointCarType:
        {
            dict = @{@"op":@"carmanufacturerandmodel",@"makeid":self.selectCarModel.brandId,@"tokenid":@"1",@"token":[JZGUserDataModel currentLoginUser].token,@"userid":[JZGUserDataModel currentLoginUser].UserID,@"companyid":[JZGUserDataModel currentLoginUser].StoreId};
        }
            break;
            
        default:
            break;
    }
    
    return dict;
}

- (void)loadCarStyleData
{
    [[JZGHudManager share] showHUDWithTitle:@"加载中..."
                                     inView:nil
                              isPenetration:NO];
    NSDictionary *dict = [self initializaStyleParameters];
    WS(weakSelf);
    [JZGNetworkManager postReqeustWithURL:self.requestType == JZGRequestUrlAppointCarType ? kSelectAppointUrl :kSelectCarUrl
                               parameters:dict
                             successBlock:^(id returnData, NSInteger code, NSString *msg)
     {
         [[JZGHudManager share] hide];
         if (self.requestType != JZGRequestUrlAppointCarType) {
             if ([returnData[@"status"] integerValue] == 100) {
                 [weakSelf.styleArray removeAllObjects];
                 [weakSelf.styleSectionArray removeAllObjects];
                 [weakSelf parsCarStyleData:returnData[@"ManufacturerList"]];
             }else
             {
                 [MBProgressHUD showError:returnData[@"msg"] toView:JZGAppDelegate.window];
             }
             
         }
         else {
             if ([returnData[@"status"] integerValue] == 1) {
                 [weakSelf.styleArray removeAllObjects];
                 [weakSelf.styleSectionArray removeAllObjects];
                 [weakSelf parsCarStyleData:returnData[@"ManufacturerList"]];
             }else
             {
                 [MBProgressHUD showError:returnData[@"msg"] toView:JZGAppDelegate.window];
             }

         }
     }
                             failureBlock:^(NSError *error)
     {
         [[JZGHudManager share] hide];
         [MBProgressHUD showError:[JZGNetworkError errorWithCode:error.code] toView:JZGAppDelegate.window];
     }];
}

- (void)parsCarStyleData:(NSArray *)array
{
    for (NSDictionary *dict in array) {
        NSMutableArray *attArray = [NSMutableArray array];
        NSString *str = dict[@"ManufacturerName"];
        
        NSArray *arr = dict[@"ModelList"];
        for (NSDictionary *dic in arr) {
            JZGSelectCarModel *model = [JZGSelectCarModel carStyleModelWithDict:dic];
            if (![attArray containsObject:model]) {
                [attArray addObject:model];
            }
        }
        
        if (![self.styleArray containsObject:attArray]) {
            [self.styleArray addObject:attArray];
        }
        
        if (![self.styleSectionArray containsObject:str]) {
            [self.styleSectionArray addObject:str];
        }
    }
    
    [self.brandImageView sd_setImageWithURL:[NSURL URLWithString:self.selectCarModel.brandIcon] placeholderImage:[UIImage imageNamed:@"select_car.png"]];
    self.brandNameLabel.text = self.selectCarModel.brandName;
    
    if (self.showType == JZGShowNextViewPresentSlideType) {
        self.indexView.hidden = YES;
    }
    
    [_styleTableView reloadData];
}

- (void)initializeOptionView
{
//    [self createBackButton];
    _contentView = [[UIView alloc] init];
    _contentView.frame = CGRectMake(self.view.bounds.size.width, 0,self.view.bounds.size.width, kScreenHeight - 64);
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    _brandTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kScreenHeight) style:UITableViewStyleGrouped];
    _brandTableView.dataSource = self;
    _brandTableView.delegate = self;
    _brandTableView.tag = JZGSelectCarBrandType;
    _brandTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _brandTableView.showsVerticalScrollIndicator = NO;
    _brandTableView.backgroundColor = [UIColor whiteColor];
    _brandTableView.tableFooterView = [[UIView alloc] init];
    [self.view insertSubview:_brandTableView belowSubview:_contentView];
    
    _styleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _contentView.bounds.size.width, _contentView.bounds.size.height) style:UITableViewStyleGrouped];
    _styleTableView.dataSource = self;
    _styleTableView.delegate = self;
    _styleTableView.tag = JZGSelectCarStyleType;
    _styleTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _styleTableView.showsVerticalScrollIndicator = NO;
    _styleTableView.tableFooterView = [[UIView alloc] init];
    _styleTableView.backgroundColor = [UIColor whiteColor];
    _styleTableView.tableHeaderView = [self loadTableHeaderView];
    [_contentView addSubview:_styleTableView];
    
    CGRect rect = CGRectMake(0, 0, 0, 0);
    rect = [self makeOptionViewFrame];
    
    CGRect frame = _contentView.frame;
    frame.origin.x -= 13.5;
    frame.size.width = 13.5;
    if (self.showType == JZGShowNextViewPresentSlideType) {
        frame.size.height = kScreenHeight - 150;
        rect = CGRectMake(0, 0, kScreenWidth, kScreenHeight
                          - 150);
    }
    _carStyleView = [JZGCarStyleView initializeCarStyleView:_contentView];
    _carStyleView.frame = frame;
    [self.view addSubview:_carStyleView];
    
    self.indexView = [[JZGTableIndexView alloc] initWithFrame:rect];
    self.indexView.dataSource = self;
    
    self.indexView.backgroundColor = [ UIColor redColor];
    [self firstAttributesForMJNIndexView];
    
    [self readAttributes];
    [self.view addSubview:self.indexView];

}

- (CGRect)makeOptionViewFrame
{
    CGRect rect = CGRectMake(0, 0, 0, 0);
    
    switch (self.showType) {
        case JZGShowNextViewPushType:
        {
            _contentView.y = 0;
            _contentView.height = self.kTableViewHeight;
            _brandTableView.height = self.kTableViewHeight;
            rect = CGRectMake(CGRectGetMinX(_brandTableView.frame),CGRectGetMinY(_brandTableView.frame), _brandTableView.width, _brandTableView.height - 64);
        }
            break;
        case JZGShowNextViewPushSlideType:
        {
            _contentView.y = 0;
            _brandTableView.y = 0;
            _contentView.height = self.kTableViewHeight;
            _brandTableView.height = self.kTableViewHeight;
            rect = CGRectMake(CGRectGetMinX(_brandTableView.frame),CGRectGetMinY(_brandTableView.frame), _brandTableView.width, _brandTableView.height - 64);
        }
            break;
        case JZGShowNextViewPresentType:
        {
            _contentView.y = 0;
            _brandTableView.y = 0;
            _contentView.height = self.kTableViewHeight;
            _brandTableView.height = self.kTableViewHeight;
            rect = CGRectMake(CGRectGetMinX(_brandTableView.frame),CGRectGetMinY(_brandTableView.frame), _brandTableView.width, _brandTableView.height - 64);
        }
            break;
        case JZGShowNextViewPresentSlideType:
        {
            _contentView.y = 0;
            _brandTableView.y = 0;
            _contentView.height = self.kTableViewHeight;
            _brandTableView.height = self.kTableViewHeight;
            rect = CGRectMake(CGRectGetMinX(_brandTableView.frame),20, _brandTableView.width, 300);
        }
            break;
            
        default:
            break;
    }
    
    return rect;
}

- (UIView *)loadTableHeaderView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(18, 9, 44, 44)];
    imageView.image = [UIImage imageNamed:@"select_car.png"];
    self.brandImageView = imageView;
        [view addSubview:self.brandImageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 40)];
    label.font = JZGFont(15.0f);
    label.textColor = COLOR_BLACK_MARCROS;
    self.brandNameLabel = label;
    [view addSubview:self.brandNameLabel];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectBrandAllStyle:)];
    tapGesture.numberOfTapsRequired = 1;
    if (self.selectCarType != JZGCarModelType) {
        [view addGestureRecognizer:tapGesture];
    }
    
    
    return view;
}

- (void)selectBrandAllStyle:(UITapGestureRecognizer *)tapGesture
{
    self.selectCarModel.styleId = @"0";
    self.selectCarModel.styleName = self.selectCarModel.brandName;
    self.selectCarModel.styleIcon = self.selectCarModel.brandIcon;
    
    self.returnCarInfo(self.selectCarModel);
    
    if (self.showType == JZGShowNextViewPushType) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(self.showType == JZGShowNextViewPushSlideType){
        [self dismissCarModelView];
        [self selectCarModelView];
    }else if(self.showType == JZGShowNextViewPresentType){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (self.showType == JZGShowNextViewPresentSlideType){
        [self dismissViewController];
    }
}

#pragma mark - 数据源方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JZGSelectCarTableViewCell *cell;
    if (tableView == _brandTableView) {
        cell = [JZGSelectCarTableViewCell cellWithTableView:tableView byCellType:JZGSelectCarBrandType];
        cell.selectCarModel = [[self.brandArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
    }else if([tableView isEqual:_styleTableView]){
        cell = [JZGSelectCarTableViewCell cellWithTableView:tableView byCellType:JZGSelectCarStyleType];
        cell.selectCarModel = [[self.styleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0;
    if ([tableView isEqual:_brandTableView]) {
        cellHeight = 60;
    }else
        cellHeight = 50;
    
    return cellHeight;
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
    
    if ([tableView isEqual:_brandTableView]) {
        label.text = [self.brandSectionTitleArray objectAtIndex:section];
    }else if ([tableView isEqual:_styleTableView])
        label.text = [self.styleSectionArray objectAtIndex:section];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000000001f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger cellNum = 0;
    if (tableView == _brandTableView) {
        if ([self.brandArray count] != 0) {
            cellNum = [[self.brandArray objectAtIndex:section] count];
        }
        
    }else{
        if ([self.styleArray count] != 0) {
            cellNum = [[self.styleArray objectAtIndex:section] count];
        }
    }
    
    return cellNum;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sectionNum = 0;
    if ([tableView isEqual:_brandTableView]) {
        sectionNum = [self.brandArray count];
    }else if([tableView isEqual:_styleTableView])
        sectionNum = [self.styleArray count];
    
    return sectionNum;
}

#pragma mark - tableView 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == _brandTableView) {
        if(self.haveAllBrand){
            if (indexPath.section == 0) {
                JZGSelectCarModel *model = [[self.brandArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                model.brandId = @"0";
                model.brandName = @"全部品牌";
                self.selectCarModel = nil;
                self.selectCarModel = model;
                
                self.returnCarInfo(self.selectCarModel);
                [self dismissViewControllerAnimated:YES completion:nil];
                return;
            }else if (self.selectCarType != JZGSelectCarStyleType){
                JZGSelectCarModel *model = [[self.brandArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//                model.brandId = @"";
//                model.brandName = @"全部品牌";
                self.selectCarModel = nil;
                self.selectCarModel = model;
                
                self.returnCarInfo(self.selectCarModel);
                [self dismissViewControllerAnimated:YES completion:nil];
                return;
            }
        }
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        if (self.lastIndexPath) {
            JZGSelectCarModel *model = [[self.brandArray objectAtIndex:self.lastIndexPath.section] objectAtIndex:self.lastIndexPath.row];
            model.isSelected = NO;
            JZGSelectCarTableViewCell *cell = [tableView cellForRowAtIndexPath:self.lastIndexPath];
            cell.selectCarModel = model;
        }
        JZGSelectCarModel *model = [[self.brandArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        model.isSelected = YES;
        JZGSelectCarTableViewCell *cell = (JZGSelectCarTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.selectCarModel = model;
        self.lastIndexPath = indexPath;
        
        self.selectCarModel = nil;
        self.selectCarModel = model;
        
        [self loadCarStyleData];
        
        [UIView animateWithDuration:0.3 animations:^{
            [_carStyleView hiddenAndShow];
        } completion:^(BOOL finished) {
            self.indexView.hidden = YES;
        }];
        
    }else{
        if ([tableView isEqual:_styleTableView]) {
            JZGSelectCarModel *model = [[self.styleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            self.selectCarModel.styleIcon = model.styleIcon;
            self.selectCarModel.styleId = model.styleId;
            self.selectCarModel.styleName = model.styleName;
            
            JZGSelectCarModelViewController *carModel = [[JZGSelectCarModelViewController alloc] init];
            carModel.hidesBottomBarWhenPushed = YES;
            carModel.requestType = self.requestType;
//            if (self.requestType == JZGRequestUrlValuationType) {
//                carModel.requestType = JZGRequestUrlValuationType;
//            }else if(self.requestType == JZGRequestUrlDefaultType){
//                carModel.requestType = JZGRequestUrlDefaultType;
//            }
            if (self.selectCarType == JZGSelectCarModelType) {
                [UIView animateWithDuration:2 animations:^{
                    [self.carStyleView showAndHidden];
                } completion:^(BOOL finished) {
                    
                    [carModel returnCarModel:^(JZGSelectCarModel *selectModel) {
                        self.returnCarInfo(selectModel);
                    }];
                }];
                
                [self nextView:carModel];
                
            }else if (self.selectCarType == JZGSelectCarStyleType){
                self.returnCarInfo(self.selectCarModel);

                if (self.showType == JZGShowNextViewPushType) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else if(self.showType == JZGShowNextViewPushSlideType){
                    [self dismissCarModelView];
                    [self selectCarModelView];
                }else if(self.showType == JZGShowNextViewPresentType){
                    [self dismissViewControllerAnimated:YES completion:nil];
                }else if (self.showType == JZGShowNextViewPresentSlideType){
                    [self dismissViewController];
                }
            }
        }
    }
}

- (void)nextView:(JZGSelectCarModelViewController *)carModelView
{
    switch (self.showType) {
        case JZGShowNextViewPushType:
        {
            carModelView.showType = JZGShowNextViewPushType;
            carModelView.selectCarModel = self.selectCarModel;
            carModelView.kTableViewHeight = kScreenHeight;
            [self.navigationController pushViewController:carModelView animated:YES];
        }
            break;
        case JZGShowNextViewPushSlideType:
        {
            [self dismissCarModelView];
            [self selectCarModelView];
        }
            break;
        case JZGShowNextViewPresentType:
        {
            carModelView.showType = JZGShowNextViewPresentType;
            carModelView.selectCarModel = self.selectCarModel;
            carModelView.kTableViewHeight = kScreenHeight;
            [self.navigationController pushViewController:carModelView animated:YES];

        }
            break;
        case JZGShowNextViewPresentSlideType:
        {
            [self dismissCarModelView];
            [self selectCarModelView];
        }
            break;
            
        default:
            break;
    }
}

- (void)returnInfoBlock:(ReturnCarInfoBlock)block
{
    self.returnCarInfo = block;
}

#pragma mark - UITableViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    UITableView *tableView = (UITableView *)scrollView;
    
    if (tableView.tag == JZGSelectCarBrandType)
    {
        __weak typeof (self)weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            [weakSelf.carStyleView showAndHidden];
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.indexView.hidden = NO;
            });
            
        }];
    }else if (tableView.tag == JZGSelectCarStyleType){
        __weak typeof (self)weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.carStyleView.transform = CGAffineTransformIdentity;
            self.carStyleView.transform = CGAffineTransformIdentity;
        } completion:NULL];
    }
}

/******************************JZGTableIndexView******************************/
#pragma mark reading/writting attributes for JZGIndexItemsForTableView

- (void)readAttributes
{
    self.getSelectedItemsAfterPanGestureIsFinished = self.indexView.getSelectedItemsAfterPanGestureIsFinished;
    self.useFont = self.indexView.useFont;
    self.selectedItemFont = self.indexView.selectedItemFont;
    self.fontColor = self.indexView.fontColor;
    self.selectedItemFontColor = self.indexView.selectedItemFontColor;
    self.darkening = self.indexView.darkening;
    self.fading = self.indexView.fading;
    self.itemsAligment = self.indexView.itemsAligment;
    self.rightMargin = self.indexView.rightMargin;
    self.upperMargin = self.indexView.upperMargin;
    self.lowerMargin = self.indexView.lowerMargin;
    self.maxItemDeflection = self.indexView.maxItemDeflection;
    self.rangeOfDeflection = self.indexView.rangeOfDeflection;
    self.curtainColor = self.indexView.curtainColor;
    self.curtainFade = self.indexView.curtainFade;
    self.curtainMargins = self.indexView.curtainMargins;
    self.curtainStays = self.indexView.curtainStays;
    self.curtainMoves = self.indexView.curtainMoves;
    self.ergonomicHeight = self.indexView.ergonomicHeight;
}

- (void)writeAttributes
{
    self.indexView.getSelectedItemsAfterPanGestureIsFinished = self.getSelectedItemsAfterPanGestureIsFinished;
    self.indexView.useFont = self.useFont;
    self.indexView.selectedItemFont = self.selectedItemFont;
    self.indexView.fontColor = self.fontColor;
    self.indexView.selectedItemFontColor = self.selectedItemFontColor;
    self.indexView.darkening = self.darkening;
    self.indexView.fading = self.fading;
    self.indexView.itemsAligment = self.itemsAligment;
    self.indexView.rightMargin = self.rightMargin;
    self.indexView.upperMargin = self.upperMargin;
    self.indexView.lowerMargin = self.lowerMargin;
    self.indexView.maxItemDeflection = self.maxItemDeflection;
    self.indexView.rangeOfDeflection = self.rangeOfDeflection;
    self.indexView.curtainColor = self.curtainColor;
    self.indexView.curtainFade = self.curtainFade;
    self.indexView.curtainMargins = self.curtainMargins;
    self.indexView.curtainStays = self.curtainStays;
    self.indexView.curtainMoves = self.curtainMoves;
    self.indexView.ergonomicHeight = self.ergonomicHeight;
}

#pragma mark settigns examples of tableView and JZGTableIndexView
- (void)firstAttributesForMJNIndexView
{
    self.indexView.getSelectedItemsAfterPanGestureIsFinished = YES;
    self.indexView.useFont = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    self.indexView.selectedItemFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0];
    self.indexView.backgroundColor = [UIColor clearColor];
    self.indexView.curtainColor = nil;
    self.indexView.curtainFade = 0.0;
    self.indexView.curtainStays = NO;
    self.indexView.curtainMoves = YES;
    self.indexView.curtainMargins = NO;
    self.indexView.ergonomicHeight = NO;
    self.indexView.upperMargin = 22.0;
    self.indexView.lowerMargin = 22.0;
    self.indexView.rightMargin = 10.0;
    self.indexView.itemsAligment = NSTextAlignmentCenter;
    self.indexView.maxItemDeflection = 100.0;
    self.indexView.rangeOfDeflection = 5;
    self.indexView.fontColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    self.indexView.selectedItemFontColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    self.indexView.darkening = NO;
    self.indexView.fading = YES;
    
}

// refreshing table with a contents of file stored in self.pathname
- (void)refreshTable
{
    [_brandTableView setSeparatorColor:self.tableSeparatorColor];
    [_brandTableView reloadData];
    [_brandTableView reloadSectionIndexTitles];
    [self.indexView refreshIndexItems];
}

// refreshing JZGTableIndexView
- (void)refresh
{
    [self writeAttributes];
    [self.indexView refreshIndexItems];
}

#pragma mark building sectionArray for the tableView
- (NSString *)categoryNameAtIndexPath: (NSIndexPath *)path
{
    NSArray *currentItems = self.sectionArray[path.section];
    NSString *category = currentItems[path.row];
    return category;
}

- (void)getIndexValue
{
    NSArray *indexArray = self.brandSectionTitleArray;
    self.alphaString = @"";
    for (NSString *s in indexArray) {
        self.alphaString = [self.alphaString stringByAppendingString:s];
    }
}

- (NSString *) firstLetter: (NSInteger) section
{
    return [[self.alphaString substringFromIndex:section] substringToIndex:1];
}

#pragma mark MJMIndexForTableView datasource methods
- (NSArray *)sectionIndexTitlesForIndexView:(JZGTableIndexView *)indexView
{
    NSMutableArray *results = [NSMutableArray array];
    
    for (int i = 0; i < [self.alphaString length]; i++)
    {
        NSString *substr = [self.alphaString substringWithRange:NSMakeRange(i,1)];
        [results addObject:substr];
    }
    
    return results;
}


- (void)sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [_brandTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index] atScrollPosition: UITableViewScrollPositionTop animated:self.getSelectedItemsAfterPanGestureIsFinished];
}

/****************************JZGTableIndexView****************************/



#pragma mark - setters and getters
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (NSMutableArray *)brandArray
{
    if (!_brandArray) {
        _brandArray = [NSMutableArray array];
    }
    
    return _brandArray;
}

- (NSMutableArray *)brandSectionTitleArray
{
    if (!_brandSectionTitleArray) {
        _brandSectionTitleArray = [NSMutableArray array];
    }
    
    return _brandSectionTitleArray;
}

- (NSMutableArray *)styleArray
{
    if (!_styleArray) {
        _styleArray = [NSMutableArray array];
    }
    
    return _styleArray;
}

- (NSMutableArray *)styleSectionArray
{
    if (!_styleSectionArray) {
        _styleSectionArray = [NSMutableArray array];
    }
    
    return _styleSectionArray;
}

- (void)dealloc
{
    
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
