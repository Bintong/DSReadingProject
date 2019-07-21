//
//  ShareItem.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/3/16.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "ShareItem.h"

@implementation ShareItem

- (instancetype)initWithData:(UIImage *)img andfile:(NSURL *)file {
    self = [super init];
    if (self) {
        _img = img;
        _path = file;
    }
    return self;
}

- (id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(UIActivityType)activityType{
    return _path;
}

- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController {
    return _img;
}

- (NSString *)activityViewController:(UIActivityViewController *)activityViewController subjectForActivityType:(UIActivityType)activityType {
    return @"hello";
}

@end
