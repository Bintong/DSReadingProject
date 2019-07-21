//
//  ShareItem.h
//  TimeAndLoop
//
//  Created by BinTong on 2017/3/16.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareItem : NSObject <UIActivityItemSource>

- (instancetype)initWithData:(UIImage *)img andfile:(NSURL *)file;

@property(nonatomic, strong) UIImage *img;
@property(nonatomic, strong) NSURL *path ;

@end
