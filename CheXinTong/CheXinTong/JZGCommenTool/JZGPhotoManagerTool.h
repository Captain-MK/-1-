//
//  JZGPhotoManagerTool.h
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/19.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZGPhotoManagerTool : NSObject

+ (JZGPhotoManagerTool *)sharePhotoManagerTool;

- (BOOL)savePhotoToDocuments:(NSString *)path name:(NSString *)name image:(UIImage *)image;

- (UIImage *)readPhotoToDocuments:(NSString *)path name:(NSString *)name;

- (BOOL)deleteItemBufferImage:(NSString *)name;

- (void)deleteBufferImage;

- (NSArray *)getSaveBufferImageNameArray;

@end
