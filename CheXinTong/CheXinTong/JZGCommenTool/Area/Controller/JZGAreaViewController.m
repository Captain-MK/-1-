//
//  JZGAreaViewController.m
//  JingZhenGu
//
//  Created by Mars on 15/12/14.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGAreaModel.h"
#import "JZGAreaTableViewCell.h"
#import "JZGAreaViewController.h"
#import "JZGCustomButton.h"
#import "JZGEncyptClass.h"

@interface JZGAreaViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *provinceTableView;
@property(nonatomic, strong) UITableView *cityTableView;
/// 省份数据数组
@property(nonatomic, strong) NSMutableArray *provinceArray;
/// 城市数据数组
@property(nonatomic, strong) NSMutableArray *cityArray;
@property(nonatomic, copy) NSString *provinceName;
@property(nonatomic, copy) NSString *provinceId;
@property(nonatomic, copy) NSString *areaIdStr;

@property(nonatomic, assign) CGFloat tableViewY;
@property (nonatomic,strong) UIView *positionView;
@property (nonatomic,strong) JZGCustomButton *positionBtn;
@property (nonatomic,strong) UIImageView *positionImageView;

@property(nonatomic, copy) NSString *cityName;
@property(nonatomic, copy) NSString *proName;

@end

@implementation JZGAreaViewController

- (NSString *)defaultTitle {
    return @"选择地区";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    // 判断定位
    [self judgePosition];
    // 添加tableview视图
    [self creatProvinceTableView];
    //加载省份的数组
    [self loadProvinceData];
}

- (void)judgePosition
{
    if (self.ifHavePosition) { // 有定位显示
        [self creatPositionView];
        if (self.positionStr.length==0) {  // 没存定位城市，开启定位
            [self statrLocation];
        }else
        { // 已存有定位城市 直接赋值
            [self.positionBtn setTitle:[NSString stringWithFormat:@"定位 %@ ",self.positionStr] forState:UIControlStateNormal];
//            self.cityName = self.positionStr;
        }
        self.tableViewY = CGRectGetMaxY(self.positionView.frame)+2;
    }else
    { // 不显示定位
        self.tableViewY = 0;
    }
    
}
/// 开始定位
- (void)statrLocation
{
    __weak typeof (self)weakSelf = self;
    CommonMethods *comment =  [CommonMethods sharedCommonMethods];
    [comment startLocationWithShowAlertView:NO location:^(NSString *stateName, NSString *cityName) {
        weakSelf.proName = [NSString stringWithFormat:@"%@",stateName];
        weakSelf.cityName = [NSString stringWithFormat:@"%@",cityName];
        
        if (![weakSelf.cityName isEqualToString:@"(null)"]) {
            [weakSelf.positionBtn setTitle:[NSString stringWithFormat:@"定位 %@ ",weakSelf.cityName] forState:UIControlStateNormal];
        }else
        {
            [weakSelf.positionBtn setTitle:[NSString stringWithFormat:@"定位 %@ ",@""] forState:UIControlStateNormal];
        }
    }];
}

- (void)selectedLocationBtn:(UIButton *)btn
{
    if (![self.cityName isEqualToString:@"(null)"] &&self.cityName != nil) {
        btn.enabled = YES;
        JZGAreaModel *areaModel  = [[JZGAreaModel alloc] init];
        NSString *fullName = [NSString stringWithFormat:@"%@-%@",self.proName,self.cityName];
        
        areaModel.provinceName = self.proName;
        areaModel.provinceId =@"";
        areaModel.cityName = self.cityName;
        areaModel.cityId = @"";
        
        if ([self.proName isEqualToString:self.cityName]) {
            fullName = self.cityName;
        }
        if ([fullName isEqualToString:@"(null)"]) {
            areaModel.allName = @"";
            areaModel.areaName = @"";
        }else{
            areaModel.allName = fullName;
            areaModel.areaName = fullName;
        }
        
        self.returnCityBlock(areaModel);
        [self.navigationController popViewControllerAnimated:YES];;
    }else
    {
        btn.enabled = NO;
        [MBProgressHUD showError:@"定位失败" toView:self.view];
        //        WAITINGERROR(@"定位失败");
    }
}


- (void)creatPositionView
{
    [self.view addSubview:self.positionView];
    [self.positionView addSubview:self.positionImageView];
    [self.positionView addSubview:self.positionBtn];
}
/// 创建省份的tableview
- (void)creatProvinceTableView {
    [self.view addSubview:self.provinceTableView];
}
/// 创建城市的tableview
- (void)creatCityTableView {
    [self.view addSubview:self.cityTableView];
}
- (void)loadProvinceData {
    
    WS(weakSelf);
    [[JZGHudManager share] showHUDWithTitle:@"加载中..."
                                     inView:self.view
                              isPenetration:YES];
    NSMutableArray *proArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"2CB3147B-D93C-964B-47AE-EEE448C84E3C" forKey:@"sign"];
    [JZGNetworkManager
     postReqeustWithURL:@"http://api.jingzhengu.com/app/area/GetProv.ashx"
     parameters:dict
     successBlock:^(id returnData, NSInteger code, NSString *msg) {
         [[JZGHudManager share] hide];
         if ([[NSString
               stringWithFormat:@"%@", [returnData objectForKey:@"status"]]
              isEqualToString:@"100"]) {
             
             NSMutableArray *array = [returnData objectForKey:@"content"];
             for (NSDictionary *dic in array) {
                 JZGAreaModel *item = [[JZGAreaModel alloc] init];
                 item.provinceId =
                 [NSString stringWithFormat:@"%@", [dic objectForKey:@"Id"]];
                 item.provinceName =
                 [NSString stringWithFormat:@"%@", [dic objectForKey:@"Name"]];
                 item.cityOrProvince = @"province";
                 if (![proArray containsObject:item]) {
                     [proArray addObject:item];
                 }
             }
             // 添加不限省份在顶部
             [weakSelf presentProvinceDataSource:proArray];
         } else {
             [MBProgressHUD showError:[returnData objectForKey:@"msg"]
                               toView:self.view];
         }
         
     }
     failureBlock:^(NSError *error) {
         [[JZGHudManager share] hide];
     }];
}
/// 加入全部地区的选项
- (void)presentProvinceDataSource:(NSMutableArray *)array {
    NSMutableArray *arr = [NSMutableArray array];
    if (self.ifHaveAllPro) {
        JZGAreaModel *tempItem = [[JZGAreaModel alloc] init];
        tempItem.provinceName = @"全部地区";
        tempItem.provinceId = @"0";
        tempItem.cityOrProvince = @"province";
        [arr addObject:tempItem];
    }
    [arr addObjectsFromArray:array];
    self.provinceArray = arr;
    [self.provinceTableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.provinceTableView) {
        return [self.provinceArray count];
    } else {
        return [self.cityArray count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JZGAreaTableViewCell *cell =
    [JZGAreaTableViewCell cellWithTableView:tableView];
    if (tableView == self.provinceTableView) {
        cell.cityItem = self.provinceArray[indexPath.row];
    } else {
        cell.cityItem = self.cityArray[indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.provinceTableView) {
        JZGAreaModel *areaModel = self.provinceArray[indexPath.row];
        self.provinceId = areaModel.provinceId;
        self.provinceName = areaModel.provinceName;
        self.areaIdStr = areaModel.provinceId;
        areaModel.cityId = @"";
        areaModel.cityName = @"";
        areaModel.areaName = areaModel.provinceName;
        areaModel.allName = @"";
        if (self.onlyProvince) { // 只有一级界面时（只选择城市）
            
            self.returnCityBlock(areaModel);
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            areaModel.allName = areaModel.provinceName;
            if (self.ifHaveAllPro && indexPath.row == 0) {
                self.returnCityBlock(areaModel);
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            ///加载城市数据和添加城市的tableview
            [self creatCityTableView];
            [self loadCityDataWithProvinceId:areaModel.provinceId];
            [self pushCityViewToView:self.cityTableView];
        }
    } else if (tableView == self.cityTableView) {
        JZGAreaModel *areaModel = self.cityArray[indexPath.row];
        NSString *fullName = [NSString
                              stringWithFormat:@"%@-%@", self.provinceName, areaModel.cityName];
        
        areaModel.provinceName = self.provinceName;
        areaModel.provinceId = self.provinceId;
        
        if (indexPath.row == 0) {
            areaModel.allName = self.provinceName;
        } else {
            areaModel.allName = fullName;
        }
        if ([self.provinceName isEqualToString:areaModel.cityName]) {
            areaModel.allName = self.provinceName;
            fullName = self.provinceName;
        }
        areaModel.areaName = fullName;
        self.returnCityBlock(areaModel);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)loadCityDataWithProvinceId:(NSString *)provinceId {
    
//    NSString *str = [[JZGEncyptClass
//                      md5HexDigest:
//                      [NSString stringWithFormat:@"?ProvId=%@%@", provinceId,
//                       @"2CB3147B-D93C-964B-47AE-EEE448C84E3C"]]
//                     uppercaseString];
//    NSString *url =
//    [NSString stringWithFormat:
//     @"%@?ProvId=%@&sign=%@",
//     @"http://api.jingzhengu.com/app/area/GetAreaList.ashx",
//     provinceId, str];
    __weak typeof(self) weakSelf = self;
    NSMutableArray *cityArr = [[NSMutableArray alloc] init];
    
    [[JZGHudManager share] showHUDWithTitle:@"加载中..."
                                     inView:JZGAppDelegate.window
                              isPenetration:YES];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"2CB3147B-D93C-964B-47AE-EEE448C84E3C" forKey:@"sign"];
    [dict setValue:provinceId forKey:@"ProvId"];

    [JZGNetworkManager postReqeustWithURL:@"http://api.jingzhengu.com/app/area/GetAreaList.ashx"
                               parameters:dict
                             successBlock:^(id returnData, NSInteger code, NSString *msg) {
                                 [[JZGHudManager share] hide];
                                 if ([[NSString
                                       stringWithFormat:@"%@", [returnData objectForKey:@"status"]]
                                      isEqualToString:@"100"]) {
                                     [MBProgressHUD hideHUDForView:JZGAppDelegate.window animated:YES];
                                     NSMutableArray *array = [NSMutableArray array];
                                     [array addObjectsFromArray:[returnData objectForKey:@"content"]];
                                     
                                     if (weakSelf.ifDontHaveAllCity) {
                                         [array removeObjectAtIndex:0];
                                     }
                                     for (NSDictionary *dic in array) {
                                         JZGAreaModel *item = [[JZGAreaModel alloc] init];
                                         item.cityId =
                                         [NSString stringWithFormat:@"%@", [dic objectForKey:@"Id"]];
                                         item.cityName =
                                         [NSString stringWithFormat:@"%@", [dic objectForKey:@"Name"]];
                                         item.cityOrProvince = @"city";
                                         if (![cityArr containsObject:item]) {
                                             [cityArr addObject:item];
                                         }
                                     }
                                     
                                     [weakSelf presentCityDataSource:cityArr];
                                 } else {
                                     [MBProgressHUD showError:[returnData objectForKey:@"msg"]
                                                       toView:self.view];
                                 }
                                 
                             }
                             failureBlock:^(NSError *error) {
                                 [[JZGHudManager share] hide];
                             }];
}
- (void)presentCityDataSource:(NSMutableArray *)array {
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObjectsFromArray:array];
    self.cityArray = arr;
    [self.cityTableView reloadData];
}
//改变列表坐标动画
- (void)changeCityViewFrame:(UITableView *)tableView {
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.cityTableView.x = kScreenWidth;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}
//改变列表坐标动画
- (void)pushCityViewToView:(UITableView *)tableView {
    [UIView animateWithDuration:0.3
                     animations:^{
                         NSInteger kMarginX = 70;
                         self.cityTableView.x = kMarginX;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

#pragma mark - block
- (void)returnCityInfo:(ReturnBlock)block {
    self.returnCityBlock = block;
}

#pragma mark lazyload
- (UITableView *)provinceTableView {
    if (!_provinceTableView) {
        _provinceTableView = [[UITableView alloc]
                              initWithFrame:CGRectMake(0, self.tableViewY, kScreenWidth,
                                                       kScreenHeight - 64 - self.tableViewY)
                              style:UITableViewStylePlain];
        _provinceTableView.delegate = self;
        _provinceTableView.dataSource = self;
        _provinceTableView.tableFooterView = [[UIView alloc] init];
    }
    return _provinceTableView;
}
- (UITableView *)cityTableView {
    if (!_cityTableView) {
        _cityTableView = [[UITableView alloc]
                          initWithFrame:CGRectMake(kScreenWidth, self.tableViewY, kScreenWidth,
                                                   kScreenHeight - 64 - self.tableViewY)
                          style:UITableViewStylePlain];
        _cityTableView.delegate = self;
        _cityTableView.dataSource = self;
        _cityTableView.tableFooterView = [[UIView alloc] init];
    }
    return _cityTableView;
}
- (NSMutableArray *)provinceArray {
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray array];
    }
    return _provinceArray;
}
- (NSMutableArray *)cityArray {
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}
- (UIView *)positionView
{
    if (!_positionView) {
        _positionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44.0f)];
        _positionView.backgroundColor = [UIColor whiteColor];
    }
    return _positionView;
}
- (JZGCustomButton *)positionBtn
{
    if (!_positionBtn) {
        _positionBtn = [[JZGCustomButton alloc] init];
        _positionBtn.frame = CGRectMake(35, 0, SCREEN_WIDTH-35, 44.0f);
        
        [_positionBtn setTitle:@"定位 北京" forState:UIControlStateNormal];
        _positionBtn.titleLabel.font = JZGFont(15);
        _positionBtn.backgroundColor = [UIColor whiteColor];
        [_positionBtn setTitleColor:COLOR_BLACK_MARCROS forState:UIControlStateNormal];
        
        _positionBtn.imageHorizontalAlignment =  HorizontalAlignmentLeft;
        _positionBtn.titleHorizontalAlignment = HorizontalAlignmentLeft;
        _positionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        [_positionBtn addTarget:self action:@selector(selectedLocationBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _positionBtn;
}
- (UIImageView *)positionImageView
{
    if (!_positionImageView) {
        _positionImageView = [[UIImageView alloc] init];
        _positionImageView.image = [UIImage imageNamed:@"home_ location.png"];
        _positionImageView.frame = CGRectMake(10, 10, 25, 25.0);
        _positionImageView.clipsToBounds = YES;
    }
    return _positionImageView;
}

@end
