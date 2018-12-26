//
// Created by majiancheng on 2018/6/13.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "MCShareConfig.h"

#import "MCShareDto.h"
#import "MMShareConfigDto.h"

NSString *const DATA_STATUS = @"success";
NSString *const DATA_CONTENT = @"data";

@implementation MCShareConfig

+ (instancetype)share {
    static dispatch_once_t predicate;
    static MCShareConfig *instance;
    dispatch_once(&predicate, ^{
        instance = [MCShareConfig new];
    });
    return instance;
}

- (NSString *)hostForPlatform:(LDSDKPlatformType)type {
    NSString *host;
    switch (type) {
        case LDSDKPlatformQQ: {
            host = self.shareDynamicDto.qqHost;
        }
            break;
        case LDSDKPlatformWeChat: {
            host = self.shareDynamicDto.wechatHost;
        }
            break;
        case LDSDKPlatformWeibo: {
            host = self.shareDynamicDto.sinaHost;

        }
            break;
        case LDSDKPlatformTelegaram: {
            host = self.shareDynamicDto.telegramHost;
        }
            break;
        case LDSDKPlatformDingTalk: {
            host = self.shareDynamicDto.dingTalkHost;
        }
            break;
    }
    return host;
}

- (MCShareDynamicDto *)shareDynamicDto {
    if (!_shareDynamicDto) {
        _shareDynamicDto = [MCShareDynamicDto new];
    }
    return _shareDynamicDto;
}

@end
