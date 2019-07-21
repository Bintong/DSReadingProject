//
// Created by fengzijie on 15/3/26.
// Copyright (c) 2015 com.tiantian. All rights reserved.
//

#import "TTFileUtils.h"



@implementation TTFileUtils {

}

+ (NSString *)filePathInLibraryDirectoryWithComponents:(NSArray *)components {
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *folderPath = documentPaths[0];
    for (NSInteger idx = 0; idx < (components.count - 1); idx++) {
        folderPath = [folderPath stringByAppendingPathComponent:components[(NSUInteger) idx]];
    }
    [[NSFileManager defaultManager] createDirectoryAtPath:folderPath
                              withIntermediateDirectories:YES attributes:nil error:nil];

    return [folderPath stringByAppendingPathComponent:components.lastObject];
}

+ (NSString *)filePathInDocumentDirectoryWithComponents:(NSArray *)components {
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *folderPath = documentPaths[0];
    for (NSUInteger idx = 0; idx < (components.count - 1); idx++) {
        folderPath = [folderPath stringByAppendingPathComponent:components[idx]];
    }
    [[NSFileManager defaultManager] createDirectoryAtPath:folderPath
                              withIntermediateDirectories:YES attributes:nil error:nil];

    return [folderPath stringByAppendingPathComponent:components.lastObject];
}

+ (NSString *)filePathInCacheDirectoryWithComponents:(NSArray *)components {
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *folderPath = documentPaths[0];
    for (NSUInteger idx = 0; idx < (components.count - 1); idx++) {
        folderPath = [folderPath stringByAppendingPathComponent:components[idx]];
    }
    [[NSFileManager defaultManager] createDirectoryAtPath:folderPath
                              withIntermediateDirectories:YES attributes:nil error:nil];

    return [folderPath stringByAppendingPathComponent:components.lastObject];
}
+ (void)deleteFile:(NSString *)filePath {
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

@end
