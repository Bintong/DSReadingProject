//
//  HBWebController.m
//  HBFinance
//
//  Created by zftank on 16/9/4.
//  Copyright © 2016年 zftank. All rights reserved.
//

#import "HBWebController.h"
#import "TTFileUtils.h"
#import "FMDatabase.h"
#import "ShareItem.h"
//#import "ZSCustomActivity.h"
@interface HBWebController ()<WKUIDelegate,WKNavigationDelegate>

@end

@implementation HBWebController

- (void)dealloc {
    
    [self stopAction];
}



- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.hbWebView.frame = self.view.bounds;
}

- (void)save:(id)sender{
    NSString *path = [TTFileUtils filePathInDocumentDirectoryWithComponents:@[@"save",@"items.db"]];
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    if ([db open]) {
        BOOL result=[db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_items (id integer PRIMARY KEY AUTOINCREMENT, title text NOT NULL, subtitle text ,url text, imgUrl text);"];
        if (result) {
            NSLog(@"创表成功");
           BOOL isok =  [db executeUpdate:@"INSERT INTO t_items (title, subtitle, url, imgUrl) VALUES (?,?,?,?);", self.itemTitle, self.subTitle,self.webUrl,self.imgUrl];
            if (isok) {

                [db close];
            }
            
        }else {
            NSLog(@"创表失败");
        }
    }
}

- (void)share:(id)sender {
    NSString *textToShare = [NSString stringWithFormat:@"Mengxia-%@",self.webTitle];
    UIImage *imageToShare = self.shareLittleImg;
    NSURL *urlToShare = [NSURL URLWithString:self.webUrl];
    NSArray *activityItems = @[textToShare, imageToShare, urlToShare];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems  applicationActivities:nil];
    
    
    
    //尽量不显示其他分享的选项内容
    
    activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook];
    
    if (activityVC) {
        [self presentViewController:activityVC animated:TRUE completion:nil];
//        activityVC.completionWithItemsHandler = 
    }

}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    UIBarButtonItem *saveItem  = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(save:)];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
    self.navigationItem.rightBarButtonItems = @[shareItem,saveItem];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    [self setXloanWebView];
    [self buildCopy];
}

- (void)refreshWeb {
    NSURL *url = [[NSURL alloc] initWithString:self.webUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadRevalidatingCacheData
                                         timeoutInterval:60.0f];
 
    [self.hbWebView loadRequest:request];
    [TTHudHelper showHud];


}

- (void)setXloanWebView {
    NSURL *url = [[NSURL alloc] initWithString:self.webUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadRevalidatingCacheData
                                         timeoutInterval:60.0f];
    self.hbWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.hbWebView.UIDelegate = self;
    self.hbWebView.navigationDelegate = self;
    [self.hbWebView loadRequest:request];
    [self.view addSubview:self.hbWebView];
    [TTHudHelper showHud];
}

- (void)backAction:(UIButton *)button {

    [self stopAction];
    [TTHudHelper hideHud];
}

- (void)stopAction {

    [self.hbWebView stopLoading];
    self.hbWebView.navigationDelegate = nil;
    self.hbWebView.UIDelegate = nil;
    self.hbWebView = nil;
}

#pragma mark -
#pragma mark WKWebView

- (BOOL)navigationActionPolicyCancel:(NSString *)absolute {

    return NO;
}


- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {

    [TTHudHelper hideHud];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

    [TTHudHelper hideHud];
}

- (void)webViewLoadingError:(NSError *)error {

    [TTHudHelper hideHud];
  
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {

    [self webViewLoadingError:error];
}

- (void)buildCopy {
 
    UIMenuItem *copyLink = [[UIMenuItem alloc] initWithTitle:@"放到口袋\(^o^)/~"
                                                       action:@selector(savedb_world:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyLink, nil]];
    [[UIMenuController sharedMenuController] setTargetRect:self.view.frame inView:self.view];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];
}
- (void)cut:(UIMenuController *)menu {
    NSLog(@"-----------%s %@", __func__, menu);
}

- (void)copy:(UIMenuController *)menu {
    NSLog(@"-----------%s %@", __func__, menu);
}
- (void)select:(UIMenuController *)menu {
   NSLog(@"-----------%s %@", __func__, menu);
    [[UIPasteboard generalPasteboard] setString:nil];
}
- (void)savedb_world:(UIMenuController *)sender {
    
    NSData *data = [[UIPasteboard generalPasteboard] dataForPasteboardType:UIPasteboardTypeAutomatic];
    
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"data str ---------%@",dataStr);
    if ([dataStr isKindOfClass:NSClassFromString(@"NSString")]) {
        NSString *path = [TTFileUtils filePathInDocumentDirectoryWithComponents:@[@"save",@"items.db"]];
        FMDatabase *db = [FMDatabase databaseWithPath:path];
        if ([db open]) {
            BOOL result=[db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_words (id integer PRIMARY KEY AUTOINCREMENT, title text NOT NULL);"];
            if (result) {
                NSLog(@"创表成功");
                BOOL isok =  [db executeUpdate:@"INSERT INTO t_words (title) VALUES (?);", dataStr];
                if (isok) {
                    [db close];
                }
                
            }else {
                NSLog(@"创表失败");
            }
        }
    }
   

}

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    NSLog(@"%@", NSStringFromSelector(action));
//    if (action == @selector(cut:)
//        || action == @selector(copy:)
//        || action == @selector(paste:)) {
//        return YES; // YES ->  代表我们只监听 cut: / copy: / paste:方法
//    }
//    return NO; // 除了上面的操作，都不支持
//}
//
//- (BOOL)canBecomeFirstResponder
//{
//    return YES;
//}

@end
