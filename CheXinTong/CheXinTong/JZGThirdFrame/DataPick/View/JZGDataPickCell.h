//
//  JZGDataPickCell.h
//  JingZhenGu
//
//  Created by liuqt on 15/12/17.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZGDataPikerModel.h"

@interface JZGDataPickCell : UITableViewCell
@property(nonatomic, strong) JZGDataPikerModel *datePickModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
