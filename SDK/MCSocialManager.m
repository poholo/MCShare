//
// Created by majiancheng on 2018/6/13.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "MCSocialManager.h"

#import <LDSDKManager/LDSDKManager.h>

#import "MCShareDto.h"
#import "MCShareConfigDto.h"

NSString *const DATA_STATUS = @"success";
NSString *const DATA_CONTENT = @"data";

@implementation MCSocialManager

+ (instancetype)share {
    static dispatch_once_t predicate;
    static MCSocialManager *instance;
    dispatch_once(&predicate, ^{
        instance = [MCSocialManager new];
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

- (void)registerPlatform {
    MCSocialConfigsCallBack shareConfigsCallBack = self.socialConfigsCallBack;
    NSAssert(shareConfigsCallBack, @"[MCShare][MCSocialManager share].socialConfigsCallBack un implement.");
    NSArray<MCShareConfigDto *> *configs = shareConfigsCallBack();
    NSMutableArray<NSDictionary *> *dealConfigs = [NSMutableArray new];
    for (MCShareConfigDto *configDto in configs) {
        [dealConfigs addObject:configDto.dict];
    }
    [[LDSDKManager share] registerWithPlatformConfigList:dealConfigs];
}


- (MCShareDynamicDto *)shareDynamicDto {
    if (!_shareDynamicDto) {
        _shareDynamicDto = [MCShareDynamicDto new];
    }
    return _shareDynamicDto;
}

@end
