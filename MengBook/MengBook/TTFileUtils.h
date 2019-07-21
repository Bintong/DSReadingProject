//
// Created by fengzijie on 15/3/26.
// Copyright (c) 2015 com.tiantian. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TTFileUtils : NSObject

+(NSString *)filePathInLibraryDirectoryWithComponents:(NSArray *)components;
+(NSString *)filePathInDocumentDirectoryWithComponents:(NSArray *)components;
+(NSString *)filePathInCacheDirectoryWithComponents:(NSArray *)components;

+(void)deleteFile:(NSString *)filePath;

@end
