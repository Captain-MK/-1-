//
//  JZGDBFile.h
//  JingZhenGu
//
//  Created by Mars on 16/6/14.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZGDBFile : NSObject

/** 复制数据库至可操作文件 */
+ (void)copyFileDatabase;

/** 从项目文件中删除数据库 */
+ (BOOL)deleteFileDatabade;

@end
