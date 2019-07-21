//
//  HomeModel.m
//  MengBook
//
//  Created by BinTong on 2017/8/14.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "HomeModel.h"
#import "HttpRequest.h"


@implementation HomeModel

- (void)requestHomeDataParameters:(NSDictionary *)parameter
                           result:(void(^)(id result))retHandler
                             fail:(void (^)(NSError *error))failHandler {
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1/main_info",kBaseHost];
    
    [HttpRequest postWithURLString:urlStr parameters:parameter success:^(id responseObject) {
        HomeJson *items = [[HomeJson alloc] initWithString:responseObject error:nil];
        if (items.items.count == 0) {
            self.homeJson = items;
        }else {
            self.homeJson = items;
        }
        
        retHandler(items);
    } failure:^(NSError *error) {
        if (failHandler) {
            failHandler(error);
        }
    }];
}

@end
