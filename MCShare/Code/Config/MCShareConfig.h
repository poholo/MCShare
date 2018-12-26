//
// Created by majiancheng on 2018/6/13.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShareDynamicDto;
@class MMShareConfigDto;

typedef NSArray<MMShareConfigDto *> *(^MCShareConfigsCallBack)(void);

typedef NSDictionary *(^MCDynamicHostCallback)(NSString *type);

extern NSString *const DATA_STATUS;
extern NSString *const DATA_CONTENT;

@interface MCShareConfig : NSObject

@property(nonatomic, strong) ShareDynamicDto *shareDynamicDto;

@property(nonatomic, copy) MCShareConfigsCallBack shareConfigsCallBack;   ///< 注册各个平台账号回调
@property(nonatomic, copy) MCDynamicHostCallback dynamicHostCallback;     ///< 动态域名

+ (instancetype)share;

@end
