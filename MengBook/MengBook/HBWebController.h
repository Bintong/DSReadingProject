//
//  HBWebController.h
//  HBFinance
//
//  Created by zftank on 16/9/4.
//  Copyright © 2016年 zftank. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "BaseViewController.h"

@interface HBWebController : BaseViewController <WKUIDelegate>

@property (nonatomic,copy) NSString *webTitle;

@property (nonatomic,copy) NSString *webUrl;   

@property(nonatomic, copy) NSString *itemTitle;

@property(nonatomic, copy) NSString *subTitle;

@property(nonatomic, copy) NSString *imgUrl;

@property(nonatomic, strong) UIImage *shareLittleImg;

@property (nonatomic,strong) WKWebView *hbWebView;

@property(nonatomic, assign) BOOL showAddButton;

- (void)setXloanWebView;

- (BOOL)navigationActionPolicyCancel:(NSString *)absolute;

- (void)refreshWeb;

@end
