//
// Created by majiancheng on 2018/6/13.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShareDynamicDto;

#pragma mark - ShareConfig
extern NSString *const SinaRedirectUri;
extern NSString *const WXAppID;
extern NSString *const WXAppSecret;
extern NSString *const QQAppID;
extern NSString *const QQAppKey;
extern NSString *const SinaAppID;
extern NSString *const SinaAppKey;
extern NSString *const DingTalkId;
extern NSString *const DingTalkAppKey;

extern NSString *const kTelegramGroup;
extern NSString *const kShareAppName;

@interface MCShareConfig : NSObject

@property(nonatomic, strong) ShareDynamicDto *shareDynamicDto;

+ (instancetype)share;

@end
