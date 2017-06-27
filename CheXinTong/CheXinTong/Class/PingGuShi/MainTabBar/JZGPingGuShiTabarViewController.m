//
//  JZGPingGuShiTabarViewController.m
//  CheXinTong
//
//  Created by jzg on 2017/4/11.
//  Copyright © 2017年 jzg. All rights reserved.
//

#import "JZGPingGuShiTabarViewController.h"
#import "JZGMaiCheViewController.h"
#import "JZGGongZuoTaiViewController.h"
#import "JZGUserCenterViewController.h"
#import "JZGShouCheViewController.h"

@interface JZGPingGuShiTabarViewController ()

@end

@implementation JZGPingGuShiTabarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    测试
    JZGGongZuoTaiViewController *gongzuotai = [[JZGGongZuoTaiViewController alloc] init];
    JZGShouCheViewController *shouche = [[JZGShouCheViewController alloc] init];
    JZGMaiCheViewController *maiche = [[JZGMaiCheViewController alloc] init];
    JZGUserCenterViewController *gerenzhongxin = [[JZGUserCenterViewController alloc] init];
    
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:gongzuotai];
    UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:shouche];
    UINavigationController *thirdNav = [[UINavigationController alloc] initWithRootViewController:maiche];
    UINavigationController *fourthNav = [[UINavigationController alloc] initWithRootViewController:gerenzhongxin];
    
    firstNav.tabBarItem.title = @"工作台";
    secondNav.tabBarItem.title = @"收车";
    thirdNav.tabBarItem.title = @"卖车";
    fourthNav.tabBarItem.title = @"我";
    
    firstNav.tabBarItem.image = [UIImage imageNamed:@"tabbar_daiban_normal"];
    firstNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_daiban_select"];
    secondNav.tabBarItem.image = [UIImage imageNamed:@"tabbar_kehu_normal"];
    secondNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_kehu_selected"];
    thirdNav.tabBarItem.image = [UIImage imageNamed:@"tabbar_cheyuan_normal"];
    thirdNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_cheyuan_selected"];
    fourthNav.tabBarItem.image = [UIImage imageNamed:@"tabbar_wode_normal"];
    fourthNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_wode_selected"];
    
    [self addChildViewController:firstNav];
    [self addChildViewController:secondNav];
    [self addChildViewController:thirdNav];
    [self addChildViewController:fourthNav];
    
    UITabBar *tabBar = [self tabBar];
    [tabBar setTintColor:[JZGCommenTool hexStringToColor:JZG_APP_COMMEN_BLUE_COLOR]];
    [tabBar setBarTintColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
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
