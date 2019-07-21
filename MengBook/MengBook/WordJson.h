//
//  WordJson.h
//  MengBook
//
//  Created by BinTong on 2017/8/16.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol WordJson;

@interface WordJson : JSONModel

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *img;
@property(nonatomic, copy) NSString *author;
@property(nonatomic, copy) NSString *bookname;
@property(nonatomic, copy) NSString *star;
@property(nonatomic, copy) NSString *wm_star;
@property(nonatomic, copy) NSString *time;
@property(nonatomic, copy) NSString *href;
@property(nonatomic, copy) NSString *wm_id;
@property(nonatomic, copy) NSString *articl;

@end


@interface Words : JSONModel

@property(nonatomic, strong) NSArray <WordJson >*items;

@end
