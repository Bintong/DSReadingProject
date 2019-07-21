//
//  WordJson.m
//  MengBook
//
//  Created by BinTong on 2017/8/16.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "WordJson.h"

@implementation WordJson
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"img": @"book_img",
                                                                  @"author": @"user_name",
                                                                  @"bookname": @"book_name",
                                                                  @"href": @"book_href",
                                                                  @"articl":@"sub_articl",
                                                                  @"wm_id":@"book_id"
                                                                  }];
}


+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
@implementation Words

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"items": @"data"}];
}

@end
