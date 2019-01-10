//
// Created by majiancheng on 2018/6/13.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <LDSDKManager/LDSDKConfig.h>

@class MCShareDynamicDto;
@class MCShareConfigDto;

typedef NSArray<MCShareConfigDto *> *(^MCSocialConfigsCallBack)(void);

typedef NSDictionary *(^MCDynamicHostCallback)(NSString *type);

typedef NSDictionary *(^MCShareItemsCallBack)(void);

typedef NSDictionary *(^MCSocialAuthItemsCallBack)(void);

extern NSString *const DATA_STATUS;
extern NSString *const DATA_CONTENT;

@interface MCSocialManager : NSObject

@property(nonatomic, strong) MCShareDynamicDto *shareDynamicDto;

@property(nonatomic, copy) MCSocialConfigsCallBack socialConfigsCallBack;   ///< 注册各个平台账号回调
@property(nonatomic, copy) MCDynamicHostCallback dynamicHostCallback;     ///< 动态域名
@property(nonatomic, copy) MCShareItemsCallBack shareItemsCallBack;       ///< 分享展示项回调
@property(nonatomic, copy) MCSocialAuthItemsCallBack socialAuthItemsCallBack; ///< 授权项目回调

+ (instancetype)share;

- (void)registerPlatform;

- (NSString *)hostForPlatform:(LDSDKPlatformType)type;

@end
