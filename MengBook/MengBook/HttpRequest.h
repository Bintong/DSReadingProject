//
//  HttpRequest.h
//  TimeAndLoop
//
//  Created by BinTong on 2016/12/15.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UploadParam.h"

typedef NS_ENUM(NSUInteger,HTTPRequestType) {
    HTTPRequestGET = 0,
    HTTPRequestPOST
};

@interface HttpRequest : NSObject

/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */

+ (void)getWithURLString:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)postWithURLString:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


/**
 *  发送网络请求
 *
 *  @param URLString   请求的网址字符串
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)requestWithURLString:(NSString *)URLString parameters:(id)parameters type:(HTTPRequestType)type success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  上传图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param uploadParam 上传图片的信息
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
+ (void)uploadWihtURLString:(NSString *)URLString parameters:(id)parameters uploadParam:(UploadParam *)uploadParam success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
