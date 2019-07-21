//
//  HomeModel.h
//  MengBook
//
//  Created by BinTong on 2017/8/14.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeJson.h"
@interface HomeModel : NSObject
@property(nonatomic, strong) HomeJson *homeJson;

- (void)requestHomeDataParameters:(NSDictionary *)parameter
                           result:(void(^)(id result))retHandler
                             fail:(void (^)(NSError *error))failHandler;
@end
