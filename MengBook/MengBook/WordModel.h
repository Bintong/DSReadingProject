//
//  WordModel.h
//  MengBook
//
//  Created by BinTong on 2017/8/16.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordModel : NSObject

 

- (void)requestWordDataParameters:(NSDictionary *)parameter
                           result:(void(^)(id result))retHandler
                             fail:(void (^)(NSError *error))failHandler;


- (void)requestMostDataParameters:(NSDictionary *)parameter
                           result:(void(^)(id result))retHandler
                             fail:(void (^)(NSError *error))failHandler;

@end
