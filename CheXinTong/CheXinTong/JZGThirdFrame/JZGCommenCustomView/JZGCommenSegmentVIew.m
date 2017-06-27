//
//  JZGCommenSegmentVIew.m
//  JZGERP
//
//  Created by jzg on 16/6/23.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGCommenSegmentVIew.h"

@interface JZGCommenSegmentVIew()

@property (strong, nonatomic)NSArray *itemArray;
@property (strong, nonatomic)UISegmentedControl *segmentControl;

@end

@implementation JZGCommenSegmentVIew

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects perfo  rmance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithArray:(NSArray *)itemArray{

    return [self initWithFrame:CGRectZero itemArray:itemArray];
}

- (instancetype)initWithFrame:(CGRect)frame itemArray:(NSArray *)itemArray
{
    if (self = [super initWithFrame:frame]) {
        self.itemArray = itemArray;
        [self addSubviewToView];
    }
    return self;
}

- (void)addSubviewToView{
    [self addSubview:self.segmentControl];
//    int side = (6 - (int)self.itemArray.count)*10;
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
}

- (void)setSegmentTitle:(NSArray *)changeArray{
    if (changeArray.count !=self.itemArray.count) {
        NSLog(@"%@ 传入的数组不对称",self);
        return;
    }
    for (int i = 0; i < changeArray.count; i++) {
        [self setOneTitle:[changeArray objectAtIndex:i] index:i];
    }
}

- (void)setOneTitle:(NSString *)title index:(int)index{
    [self.segmentControl setTitle:title forSegmentAtIndex:index];
}

- (UISegmentedControl *)segmentControl{

    if (!_segmentControl) {
        _segmentControl = [[UISegmentedControl alloc]initWithItems:self.itemArray];
        _segmentControl.selectedSegmentIndex = 0;
        _segmentControl.tintColor = [JZGCommenTool hexStringToColor:@"#4189E2"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName ,nil];
        [_segmentControl setTitleTextAttributes:dic forState:UIControlStateSelected];
        [_segmentControl addTarget:self action:@selector(selectSegmentMethod:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentControl;
}

- (void)selectSegmentMethod:(id)sender{
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    int index = (int)segment.selectedSegmentIndex;
    if (self.selectSegmentBlock) {
        self.selectSegmentBlock(index);
    }
}

@end
