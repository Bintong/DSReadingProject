//
//  UIView+Coordinate.h
//  GJDD
//
//  Created by zftank on 15-4-14.
//  Copyright (c) 2015年 zftank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Coordinate)

@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat top;

@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat width;

@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;

@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;

@property (nonatomic) CGSize size;

@property (nonatomic) CGFloat rightToSuper;

@property (nonatomic) CGFloat bottomToSuper;

@end
