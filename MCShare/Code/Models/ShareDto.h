//
// Created by majiancheng on 2017/7/20.
// Copyright (c) 2017 poholo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SocialShareConfig.h"
#import "Dto.h"

@class UIImage;

typedef void (^ShareCallBack)(id value);

@interface ShareDto : Dto

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *imgUrl;
@property(nonatomic, copy) NSString *shareUrl;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, copy) NSString *desc;
@property(nonatomic, copy) NSString *pasteText;
@property(nonatomic, strong) id sourceDto;
@property(nonatomic, assign) SocialPlatform platform;

@property(nonatomic, strong) NSArray *sharePlatformsArray;
@property(nonatomic, copy) NSString *logProcessEventName;
@property(nonatomic, copy) NSString *logResultEventName;

@property(nonatomic, copy) ShareCallBack shareCallback;


- (NSDictionary *)shareDict;

- (void)logProcess:(NSString *)target;

- (void)logResult:(NSString *)target;

- (void)updateShareURL:(SocialPlatform)platform;;

- (void)updatePaste;

+ (NSInteger)target:(SocialPlatform)platform;


+ (ShareDto *)createShareURL:(NSString *)url;

/**
 * web 页面分享~
 * @param url
 * @param title
 * @param desc
 * @param image
 * @param copyText
 * @param logParam
 * @return
 */
+ (ShareDto *)createShareURL:(NSString *)url title:(NSString *)title desc:(NSString *)desc image:(NSString *)image pasteText:(NSString *)pasteText;


@end


@interface ShareDynamicDto : Dto

@property(nonatomic, strong) NSString *host;

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *videoDesc;

@property(nonatomic, strong) NSString *desc;

@property(nonatomic, strong) NSString *sinaHost;
@property(nonatomic, strong) NSString *qqHost;
@property(nonatomic, strong) NSString *wechatHost;

+ (ShareDynamicDto *)defaultShareDto;


@end
