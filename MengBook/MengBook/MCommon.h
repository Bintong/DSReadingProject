//
//  MCommon.h
//  MengP2P
//
//  Created by BinTong on 2017/7/26.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#ifndef MCommon_h
#define MCommon_h


#define kBaseHost @"http://127.0.0.1:5000/"

#define APP_VERSION            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_DISPLAY_NAME       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

#define SCREEN_BOUNDS          [[UIScreen mainScreen] bounds]
#define SCREEN_SIZE            SCREEN_BOUNDS.size
#define SCREEN_WIDTH           SCREEN_SIZE.width
#define SCREEN_HEIGHT          SCREEN_SIZE.height
#define SCREEN_SCALE           [UIScreen mainScreen].scale

#define TAB_BAR_HEIGHT         APPDelegate.rootController.tabBar.height
#define TAB_CONTENT_RECT       CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-TAB_BAR_HEIGHT)

#endif /* MCommon_h */
