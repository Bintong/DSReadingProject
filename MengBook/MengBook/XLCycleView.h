//
//  XLCycleView.h
//  IOSMasterPlate
//
//  Created by zhangfeng on 13-6-5.
//  Copyright (c) 2013年 zhangfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLCycleView : UIView

@property (nonatomic,weak) id delegate;

+ (XLCycleView *)XLCycleView:(CGRect)frame bitmap:(UIImage *)bitmap;

- (void)reloadData:(NSTimeInterval)duration number:(NSInteger)number;

@end

@protocol XLCycleViewDelegate <NSObject>

@optional

- (void)refreshImage:(UIButton *)button withIndex:(NSInteger)index;

- (void)xlcycleView:(XLCycleView *)cycleView didSelectAtIndex:(NSInteger)index;

- (void)autoScrollAction:(XLCycleView *)cycleView;

@end
