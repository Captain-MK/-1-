//
//  JZGSelectCarTableViewCell.m
//  JingZhenGu
//
//  Created by Mars on 15/12/28.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGSelectCarTableViewCell.h"

/**进制颜色转换*/
#define JZGUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**蓝色*/
#define COLOR_BLUE_MARCROS           JZGUIColorFromRGB(0x4790ef)
#define COVER_ALPHA    0.3f      //蒙版透明度

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#define Padding 13
@interface JZGSelectCarTableViewCell()

@property(nonatomic, assign) NSInteger selectCarType;
/**选中指示器view*/
@property(nonatomic, weak) UIView *selectedIndicator;
@property(nonatomic, weak) UIImageView *iconImageView;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *priceLabel;
/**分割线*/
@property(nonatomic, weak) UILabel *separator;

@end

@implementation JZGSelectCarTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView byCellType:(JZGSelectCarType)selectCarType
{
    static NSString *ID = @"SelectCarCell";
    JZGSelectCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[JZGSelectCarTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID byCellType:selectCarType];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

/**获取类名字符串*/
- (NSString *)cellIdentifier
{
    return NSStringFromClass([self class]);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier byCellType:(JZGSelectCarType)selectCarType
{
    _selectCarType = selectCarType;
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        [self makeCellSubviews];
    return self;
}

/**创建cell所有控件*/
- (void)makeCellSubviews
{
    UIView *selectedIndicator = [[UIView alloc]init];
    selectedIndicator.backgroundColor = COLOR_BLUE_MARCROS;
    self.selectedIndicator = selectedIndicator;
    [self addSubview:selectedIndicator];
    
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    iconImageView.clipsToBounds = YES;
    iconImageView.image = [UIImage imageNamed:@"select_car.png"];
    self.iconImageView = iconImageView;
    [self addSubview:iconImageView];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    if (self.selectCarType == JZGSelectCarModelType) {
        titleLabel.numberOfLines = 0;
    }
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    /**指导价*/
    UILabel *priceLabel = [[UILabel alloc]init];
    priceLabel.font = [UIFont systemFontOfSize:13];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    self.priceLabel = priceLabel;
    [self addSubview:priceLabel];
    
    
    UILabel *separator = [[UILabel alloc]init];
    separator.backgroundColor = [UIColor lightGrayColor];
    separator.alpha = COVER_ALPHA;
    self.separator = separator;
    [self addSubview:separator];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat padding = 13;
    CGFloat separatorH = 0.5;// 分割线高度
    
    _selectedIndicator.height = self.height;
    _selectedIndicator.width = 5;
    
    if (_selectCarType != JZGSelectCarModelType) {
        _iconImageView.hidden = NO;
        if (_selectCarType == JZGSelectCarBrandType) {// 品牌
            _iconImageView.size = CGSizeMake(44, 44);
        }else if (_selectCarType == JZGSelectCarStyleType){// 车系
            //            _iconImageView.size = CGSizeMake(60, 40);
            _iconImageView.hidden = YES;
        }
        _iconImageView.x = CGRectGetMaxX(_selectedIndicator.frame)+padding;
        _iconImageView.centerY = self.height*0.5;
        
        _titleLabel.x = CGRectGetMaxX(_iconImageView.frame)+padding;
        _titleLabel.width = self.width-_titleLabel.x;
        
        _titleLabel.height = self.height-separatorH;
        
        _separator.x = _titleLabel.x;
        _separator.y = self.height - separatorH;
        _separator.height = separatorH;
        _separator.width = _titleLabel.width;
        
    }else{
        _iconImageView.hidden = YES;
        
        _titleLabel.x = CGRectGetMaxX(_selectedIndicator.frame)+4;
        _titleLabel.width = self.width-TABLEMODEL_OFFSET_X - 4 - _titleLabel.x;
        _titleLabel.width = SCREEN_WIDTH;
        _titleLabel.height = self.height-separatorH - 25;
        
        /**指导价*/
        _priceLabel.frame = CGRectMake(_titleLabel.x, CGRectGetMaxY(_titleLabel.frame) + 5, SCREEN_WIDTH, 15);
        
        _separator.x = _titleLabel.x;
        _separator.y = self.height - separatorH;
        _separator.height = separatorH;
        _separator.width = _titleLabel.width;
        
    }
}

- (void)setSelectCarModel:(JZGSelectCarModel *)selectCarModel
{
    if (selectCarModel) {
        _selectCarModel = selectCarModel;
        switch (_selectCarType) {
            case JZGSelectCarBrandType:
            {
                self.titleLabel.text = _selectCarModel.brandName;
                self.iconImageView.hidden = NO;
                NSURL *iconUrl = [NSURL URLWithString:_selectCarModel.brandIcon];
                [self.iconImageView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"select_car.png"]];
                if (_selectCarModel.isSelected) {
                    self.titleLabel.textColor = COLOR_BLUE_MARCROS;
                    _selectedIndicator.hidden = NO;
                }else{
                    self.titleLabel.textColor = [UIColor blackColor];
                    _selectedIndicator.hidden = YES;
                }
            }
                break;
            case JZGSelectCarStyleType:
            {
                self.iconImageView.hidden = YES;
                _selectedIndicator.hidden = YES;
                self.titleLabel.text = _selectCarModel.styleName;
                
                
            }
                break;
            case JZGSelectCarModelType:
            {
                _selectedIndicator.hidden = YES;
                self.titleLabel.text = _selectCarModel.modelName;
                NSString *lmpString = [NSString stringWithFormat:@"厂商指导价：%@万元",[NSString newNotNullStr:_selectCarModel.modelMsrp]];
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:lmpString];
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,6)];
                self.priceLabel.textColor = [UIColor orangeColor];
                self.priceLabel.attributedText = str;
            }
                break;
                
            default:
                break;
        }
        
    }
}

//- (void)awakeFromNib {
//    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
