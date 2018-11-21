//
// Created by majiancheng on 2018/6/13.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShareDynamicDto;

typedef NS_ENUM(NSInteger, SocialPlatform) {
    SocialPlatformWeChat,
    SocialPlatformQQ,
    SocialPlatformWeChatFriend,
    SocialPlatformQQZone,
    SocialPlatformWeiBo,
    SocialPlatformTelegram,
    SocialPlatformLink,
    SocialPlatformReport,
    SocialPlatformDel
};

typedef NS_ENUM(NSInteger, ShareType) {
    ShareTypeVideo,
    ShareTypeApp,
    ShareTypeWeb,
};

#pragma mark - ShareConfig
extern NSString *const SinaRedirectUri;
extern NSString *const WXAppID;
extern NSString *const WXAppSecret;
extern NSString *const QQAppID;
extern NSString *const QQAppKey;
extern NSString *const SinaAppID;
extern NSString *const SinaAppKey;

extern NSString *const kShareAppName;


extern NSInteger const kShareErrorCodeDel;

@interface SocialShareConfig : NSObject

@property(nonatomic, strong) ShareDynamicDto *shareDynamicDto;
@property(nonatomic, strong) NSNumber *textShareMode;

+ (instancetype)share;

@end
