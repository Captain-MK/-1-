//
//  JZGAreaTableViewCell.h
//  JingZhenGu
//
//  Created by Mars on 15/12/14.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JZGAreaModel.h"

@interface JZGAreaTableViewCell : UITableViewCell

/**内容显示*/
@property (strong, nonatomic) UILabel *areaLabel;
///**省份数据模型*/
//@property (strong, nonatomic) JZGProvincesModel *provinceModel;
///**城市数据模型*/
//@property (strong, nonatomic) JZGCityModel *cityModel;
@property (nonatomic,strong) JZGAreaModel *cityItem;
/**
 *  类方法创建cell
 *
 *  @param tableView tableView
 *
 *  @return UITableViewCell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
