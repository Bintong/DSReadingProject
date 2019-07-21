//
//  HomeJson.h
//  MengBook
//
//  Created by BinTong on 2017/8/14.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol BookInfo ;
@interface BookInfo : JSONModel
 


@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *author ;
@property(nonatomic, copy) NSString *book_id;
@property(nonatomic, copy) NSString *book_type;
@property(nonatomic, copy) NSString *img ;
@property(nonatomic, copy) NSString *href;
@property(nonatomic, copy) NSString *abstract;
@property(nonatomic, copy) NSString *time;
@property(nonatomic, copy) NSString *publisher;

@end

@protocol Banner ;
@interface Banner : JSONModel

@property(nonatomic, copy) NSString *img_url;
@property(nonatomic, copy) NSString *img_href;

@end

@interface HomeJson : JSONModel

@property(nonatomic, strong) NSArray <Banner>*banners;
@property(nonatomic, strong) NSArray <BookInfo>*items;

@end
