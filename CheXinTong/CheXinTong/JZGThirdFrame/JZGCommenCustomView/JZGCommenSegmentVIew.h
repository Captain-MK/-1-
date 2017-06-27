//
//  JZGCommenSegmentVIew.h
//  JZGERP
//
//  Created by jzg on 16/6/23.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZGCommenSegmentVIew : UIView

@property (nonatomic, copy)segmentSelect   selectSegmentBlock;

- (instancetype)initWithArray:(NSArray *)itemArray;

- (instancetype)initWithFrame:(CGRect)frame itemArray:(NSArray *)itemArray;

/**
 *  修改全部title
 *
 *  @param changeArray changeArray description
 */
- (void)setSegmentTitle:(NSArray *)changeArray;

/**
 *  修改单个的title
 *
 *  @param title title
 *  @param index index
 */
- (void)setOneTitle:(NSString *)title index:(int)index;


@end
