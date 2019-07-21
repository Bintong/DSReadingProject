//
// Created by blackmilk on 14-4-21.
//
// 
//


#import "MBProgressHUD.h"


@interface TTHudHelper : NSObject {
    MBProgressHUD *_hud;
}

@property(nonatomic, strong) MBProgressHUD *hud;

// 单例
+ (TTHudHelper *)instance;

+(void)showHud;
+(void)showHudInView:(UIView *)v;
+(void)showHudInView:(UIView *)v withMessage:(NSString *)message;
+(void)showHudWithMessage:(NSString *)message;
+(void)hideHud;
+(void)showTip:(NSString *)tipString;

// 在window上显示hud
// 参数：
// caption:标题
// bActive：是否显示转圈动画
// time：自动消失时间，如果为0，则不自动消失

- (void)showHudOnWindow:(NSString *)caption
                  image:(UIImage *)image
              acitivity:(BOOL)bAcitve
           autoHideTime:(NSTimeInterval)time;

- (void)showHudOnWindow:(UIWindow *)window
                caption:(NSString *)caption
                  image:(UIImage *)image
              acitivity:(BOOL)bAcitve
           autoHideTime:(NSTimeInterval)time;

// 在当前的view上显示hud
// 参数：
// view：要添加hud的view
// caption:标题
// image:图片
// bActive：是否显示转圈动画
// time：自动消失时间，如果为0，则不自动消失
- (void)showHudOnView:(UIView *)view
              caption:(NSString *)caption
                image:(UIImage *)image
            acitivity:(BOOL)bAcitve
         autoHideTime:(NSTimeInterval)time;

// 隐藏hud
- (void)hideHud;

- (void)hideHudAfter:(NSTimeInterval)time;

@end
