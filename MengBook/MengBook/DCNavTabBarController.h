//
//  ViewController.h
//  父子控制器
//
//  Created by 戴川 on 16/6/3.
//  Copyright © 2016年 戴川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCNavTabBarController : UIViewController
-(instancetype)initWithSubViewControllers:(NSArray *)subViewControllers;

@property(nonatomic,copy)UIColor *btnTextNomalColor;
@property(nonatomic,copy)UIColor *btnTextSeletedColor;
@property(nonatomic,copy)UIColor *sliderColor;
@property(nonatomic,copy)UIColor *topBarColor;






@end

