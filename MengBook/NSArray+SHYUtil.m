//
//  NSArray+SHYUtil.m
//  MengBook
//
//  Created by BinTong on 2017/8/27.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "NSArray+SHYUtil.h"

@implementation NSArray (SHYUtil)

- (id)objectAtIndexCheck:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}



@end
