//
//  JZGDBFile.m
//  JingZhenGu
//
//  Created by Mars on 16/6/14.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import "JZGDBFile.h"

@implementation JZGDBFile

//
//+ (NSString *)dbPathWithDirectoryName:(NSString *)directoryName
//{
//    NSString *docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSFileManager *filemanage = [NSFileManager defaultManager];
//    if (directoryName == nil || directoryName.length == 0) {
//        docsdir = [docsdir stringByAppendingPathComponent:@"JingZhenGu"];
//    } else {
//        docsdir = [docsdir stringByAppendingPathComponent:directoryName];
//    }
//    BOOL isDir;
//    BOOL exit =[filemanage fileExistsAtPath:docsdir isDirectory:&isDir];
//    if (!exit || !isDir) {
//        [filemanage createDirectoryAtPath:docsdir withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    NSString *dbpath = [docsdir stringByAppendingPathComponent:@"JZGDatabase.sqlite"];
//    return dbpath;
//}

+ (void)copyFileDatabase
{
    NSString *directoryName = nil;
    NSString *docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *filemanage = [NSFileManager defaultManager];
    if (directoryName == nil || directoryName.length == 0) {
        docsdir = [docsdir stringByAppendingPathComponent:@"JingZhenGu"];
    } else {
        docsdir = [docsdir stringByAppendingPathComponent:directoryName];
    }
    BOOL isDir;
    BOOL exit =[filemanage fileExistsAtPath:docsdir isDirectory:&isDir];
    if (!exit || !isDir) {
        [filemanage createDirectoryAtPath:docsdir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *documentLibraryFolderPath = [docsdir stringByAppendingPathComponent:@"JZGDatabase.sqlite"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:documentLibraryFolderPath]) {
        JZGLog(@"文件已经存在了");
    }else {
        NSString *resourceSampleImagesFolderPath =[[NSBundle mainBundle]
                                                   pathForResource:@"JZGDatabase"
                                                   ofType:@"sqlite"];
        NSData *mainBundleFile = [NSData dataWithContentsOfFile:resourceSampleImagesFolderPath];
        [[NSFileManager defaultManager] createFileAtPath:documentLibraryFolderPath
                                                contents:mainBundleFile
                                              attributes:nil];
    }
}

+ (BOOL)deleteFileDatabade
{
    BOOL res = NO;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *documentLibraryFolderPath = [documentsDirectory stringByAppendingPathComponent:@"JZGDatabase"];
//    
    NSString *directoryName = nil;
    NSString *docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *filemanage = [NSFileManager defaultManager];
    if (directoryName == nil || directoryName.length == 0) {
        docsdir = [docsdir stringByAppendingPathComponent:@"JingZhenGu"];
    } else {
        docsdir = [docsdir stringByAppendingPathComponent:directoryName];
    }
    BOOL isDir;
    BOOL exit =[filemanage fileExistsAtPath:docsdir isDirectory:&isDir];
    if (!exit || !isDir) {
        [filemanage createDirectoryAtPath:docsdir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *documentLibraryFolderPath = [docsdir stringByAppendingPathComponent:@"JZGDatabase"];
//
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager isDeletableFileAtPath:documentLibraryFolderPath];
//    [[NSFileManager defaultManager] delete:documentLibraryFolderPath];
    
    res = YES;
    return res;
}

@end
