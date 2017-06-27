//
//  JZGSelectCarTableViewCell.h
//  JingZhenGu
//
//  Created by Mars on 15/12/28.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZGSelectCarModel.h"

#define TABLESERIES_OFFSET_X 57.5 // 车系table偏移x
#define TABLEMODEL_OFFSET_X  143  // 车型table偏移x

typedef NS_ENUM(NSInteger,JZGSelectCarType)
{
    JZGSelectCarBrandType = 0,
    JZGSelectCarStyleType = 1,
    JZGSelectCarModelType = 2,
};


@interface JZGSelectCarTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView byCellType:(JZGSelectCarType)selectCarType;
//@property(nonatomic, weak) UIImageView *iconImageView;
@property(nonatomic, strong) JZGSelectCarModel *selectCarModel;

@end
