//
//  WhereController.m
//  MengBook
//
//  Created by BinTong on 2017/8/7.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "WhereController.h"
#import "DZNSegmentedControl.h"
#import "WorldViewController.h"
#import "MostViewController.h"
#import "DCNavTabBarController.h"


@interface WhereController ()<DZNSegmentedControlDelegate>

@end

@implementation WhereController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildTopVarView];
    // Do any additional setup after loading the view.
}

- (void)buildTopVarView{
    WorldViewController *one = [[WorldViewController alloc] init];
    one.title = @"说说";
    MostViewController *two = [[MostViewController alloc]  init];
    two.title = @"多的说说";
 
    NSArray *ar = @[one,two];
    DCNavTabBarController *tab = [[DCNavTabBarController alloc] initWithSubViewControllers:ar];
    tab.btnTextNomalColor = HB_COLOR_B;
    tab.btnTextSeletedColor = HB_COLOR_B;
    tab.sliderColor = MX_COLOR_A;
    tab.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    [self.view addSubview:tab.view];
    [self addChildViewController:tab];
 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
