//
//  WordModel.m
//  MengBook
//
//  Created by BinTong on 2017/8/16.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "WordModel.h"
#import "WordJson.h"
@implementation WordModel

- (void)requestWordDataParameters:(NSDictionary *)parameter
                           result:(void(^)(id result))retHandler
                             fail:(void (^)(NSError *error))failHandler {
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1/main_list",kBaseHost];
    
    [HttpRequest postWithURLString:urlStr parameters:parameter success:^(id responseObject) {
        Words *json = [[Words alloc] initWithString:responseObject error:nil];
        
        retHandler(json.items);
    } failure:^(NSError *error) {
        if (failHandler) {
            failHandler(error);
        }
    }];
}


- (void)requestMostDataParameters:(NSDictionary *)parameter
                           result:(void(^)(id result))retHandler
                             fail:(void (^)(NSError *error))failHandler {
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1/most_favorite",kBaseHost];
    
    [HttpRequest postWithURLString:urlStr parameters:parameter success:^(id responseObject) {
        Words *json = [[Words alloc] initWithString:responseObject error:nil];
        retHandler(json.items);
    } failure:^(NSError *error) {
        if (failHandler) {
            failHandler(error);
        }
    }];
}


@end
