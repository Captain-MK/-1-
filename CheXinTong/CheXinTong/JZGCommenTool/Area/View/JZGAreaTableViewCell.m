//
//  JZGAreaTableViewCell.m
//  JingZhenGu
//
//  Created by Mars on 15/12/14.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGAreaTableViewCell.h"

#define JZGColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@implementation JZGAreaTableViewCell

/**类方法创建cell对象*/
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *identifier = [[self alloc] cellIdentifier];
    JZGAreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[JZGAreaTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    return cell;
}

/**创建不同风格的对象*/
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadOptionView];
    }
    
    return self;
}

/**获取类名字符串*/
- (NSString *)cellIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)setCityItem:(JZGAreaModel *)cityItem
{
    if (cityItem) {
        _cityItem = cityItem;
        if ([_cityItem.cityOrProvince isEqualToString:@"province"]) {
             self.areaLabel.text = _cityItem.provinceName;
        }else if([_cityItem.cityOrProvince isEqualToString:@"city"])
        {
        self.areaLabel.text = _cityItem.cityName;
        }
    }
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeOptionViewBounds];
}

- (void)loadOptionView
{
    [self.contentView addSubview:self.areaLabel];
}

- (void)makeOptionViewBounds
{
    UIEdgeInsets areaPadding = UIEdgeInsetsMake(10, 20, 10, 20);
    [self.areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(areaPadding.top); //with is an optional semantic filler
        make.left.equalTo(self.contentView.mas_left).with.offset(areaPadding.left);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-areaPadding.bottom);
        make.right.equalTo(self.contentView.mas_right).with.offset(-areaPadding.right);
    }];
}

- (UILabel *)areaLabel
{
    if (!_areaLabel) {
        _areaLabel = [[UILabel alloc] init];
        _areaLabel.font = JZGFont(15.0f);
        _areaLabel.textColor = JZGColorFromRGB(0x333333);
        _areaLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _areaLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
