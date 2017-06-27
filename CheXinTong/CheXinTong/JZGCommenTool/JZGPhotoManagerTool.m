//
//  JZGPhotoManagerTool.m
//  JZGERSecondPhase
//
//  Created by jzg on 16/8/19.
//  Copyright © 2016年 jzg. All rights reserved.
//

#import "JZGPhotoManagerTool.h"

@implementation JZGPhotoManagerTool

+ (JZGPhotoManagerTool *)sharePhotoManagerTool{
    static JZGPhotoManagerTool *photoManagerTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (!photoManagerTool) {
            photoManagerTool = [[self alloc] init];
        }
    });
    return photoManagerTool;
}

- (BOOL)savePhotoToDocuments:(NSString *)path name:(NSString *)name image:(UIImage *)image{

    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"buffer"]];
     // 保存文件的名称
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        NSLog(@"FileDir is exists.");
    }
    NSString *fullPath = [self documentPath:name];
    BOOL result = [UIImagePNGRepresentation(image) writeToFile:fullPath atomically:YES]; // 保存成功会返回YES
    return result;
}

- (UIImage *)readPhotoToDocuments:(NSString *)path name:(NSString *)name{

    NSString *filePath = [self documentPath:name];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

- (BOOL)deleteItemBufferImage:(NSString *)name{

    NSString *filePath = [self documentPath:name];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL isOk;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        isOk = [fileManager removeItemAtPath:filePath error:nil];
    } else {
        NSLog(@"FileDir is not exists.");
        isOk = NO;
    }
    return isOk;
}

- (NSArray *)getSaveBufferImageNameArray{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"buffer/"]];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [[NSArray alloc] init];
    } else {
        return [fileManager subpathsAtPath:filePath];
    }
}

- (void)deleteBufferImage{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"buffer"]];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:nil];
    } else {
        NSLog(@"FileDir is not exists.");
    }
}

- (NSString *)documentPath:(NSString *)name{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"buffer/%@",name]];
    return filePath;
}

@end
