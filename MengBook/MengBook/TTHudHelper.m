//
// Created by blackmilk on 14-4-21.
//
// 
//


#import "TTHudHelper.h"
#import "AppDelegate.h"

@implementation TTHudHelper {

}

+ (TTHudHelper *)instance {
    static TTHudHelper *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

+ (void)showHud {
    [[TTHudHelper instance] showHudOnWindow:@""
                                      image:nil
                                  acitivity:YES
                               autoHideTime:0];
}

+ (void)showHudInView:(UIView *)v {
    [[TTHudHelper instance] showHudOnView:v caption:@"" image:nil acitivity:YES autoHideTime:0];
}

+ (void)showHudInView:(UIView *)v withMessage:(NSString *)message {
    [[TTHudHelper instance] showHudOnView:v caption:@"" image:nil acitivity:YES autoHideTime:0];
}

+ (void)showHudWithMessage:(NSString *)message {
    [[TTHudHelper instance] showHudOnWindow:message
                                      image:nil
                                  acitivity:YES
                               autoHideTime:0];
}

+ (void)hideHud {
    [[TTHudHelper instance] hideHud];
}

- (void)showHudOnWindow:(NSString *)caption
                  image:(UIImage *)image
              acitivity:(BOOL)active
           autoHideTime:(NSTimeInterval)time1 {
    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
    [self showHudOnWindow:app.window caption:caption image:image acitivity:active autoHideTime:time1];
}

- (void)showHudOnWindow:(UIWindow *)window
                caption:(NSString *)caption
                  image:(UIImage *)image
              acitivity:(BOOL)active
           autoHideTime:(NSTimeInterval)time1 {
    if (_hud) {
        [_hud hideAnimated:NO];
    }

    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
    self.hud = [[MBProgressHUD alloc] initWithView:app.window];
    [app.window addSubview:self.hud];
    self.hud.label.text = caption;
    self.hud.mode = active ? MBProgressHUDModeIndeterminate : MBProgressHUDModeText;
    self.hud.animationType = MBProgressHUDAnimationFade;
    self.hud.removeFromSuperViewOnHide = YES;
    [self.hud showAnimated:YES];
    if (time1 > 0) {
        [self.hud hideAnimated:YES afterDelay:time1];
    }
}

- (void)showHudOnView:(UIView *)view
              caption:(NSString *)caption
                image:(UIImage *)image
            acitivity:(BOOL)active
         autoHideTime:(NSTimeInterval)time1 {

    if (_hud) {
        [_hud hideAnimated:NO];
    }

    self.hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:self.hud];
    self.hud.label.text = caption;
    self.hud.mode = active ? MBProgressHUDModeIndeterminate : MBProgressHUDModeText;
    self.hud.animationType = MBProgressHUDAnimationFade;
    [self.hud showAnimated:YES];
    if (time1 > 0) {
        [self.hud hideAnimated:YES afterDelay:time1];
    }
}


- (void)hideHud {
    if (_hud) {
        [_hud hideAnimated:YES];
    }
}

- (void)hideHudAfter:(NSTimeInterval)time1 {
    if (_hud) {
        [_hud hideAnimated:YES afterDelay:time1];
    }
}

+(void)showTip:(NSString *)tipString {
    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:app.window animated:YES];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = tipString;
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [hud hideAnimated:YES afterDelay:3.f];
}

@end
