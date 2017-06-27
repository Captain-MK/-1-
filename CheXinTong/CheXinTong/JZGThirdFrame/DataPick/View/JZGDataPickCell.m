//
//  JZGDataPickCell.m
//  JingZhenGu
//
//  Created by liuqt on 15/12/17.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGDataPickCell.h"
#import "UIView+Tool.h"

@interface JZGDataPickCell ()

@property(nonatomic, weak) UILabel *titleLabel;

@end
@implementation JZGDataPickCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"datePikerCell";
    JZGDataPickCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[JZGDataPickCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        [self makeCellSubviews];
    return self;
}

/**创建cell所有控件*/
- (void)makeCellSubviews
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.width = self.width;
    _titleLabel.height = self.height;
}

- (void)setDatePickModel:(JZGDataPikerModel *)datePickModel
{
    if (datePickModel) {
        _datePickModel = datePickModel;
        _titleLabel.text = _datePickModel.title;
        if (_datePickModel.hightLight) {
            self.titleLabel.textColor = [UIColor whiteColor];
        }else{
            self.titleLabel.textColor = [UIColor lightGrayColor];
        }
    }
}

@end
