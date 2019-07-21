//
//  HomeJson.m
//  MengBook
//
//  Created by BinTong on 2017/8/14.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "HomeJson.h"


@implementation BookInfo

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation Banner

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation HomeJson

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"banners": @"data.banners",
                                                                  @"items":@"data.items"}];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
