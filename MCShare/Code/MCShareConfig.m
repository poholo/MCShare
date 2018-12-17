//
// Created by majiancheng on 2018/6/13.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "MCShareConfig.h"
#import "ShareDto.h"

#pragma mark - ShareConfig
NSString *const SinaRedirectUri = @"https://sns.whalecloud.com/sina2/callback";

//TODO:: 各个账号id
#pragma mark - warning 各个账号id
NSString *const WXAppID = @"wxd6b4d4ada6beb442";
NSString *const WXAppSecret = @"a2be3d08a304c26d1e538cd3f02e5362";
NSString *const QQAppID = @"1106976672";
NSString *const QQAppKey = @"D76uzXaBnfC4hxyO";
NSString *const SinaAppID = @"4272693281";
NSString *const SinaAppKey = @"3e6b76df2ff8b3aafb050c5defe7427f";
NSString *const kTelegramGroup = @"https://0.plus/firebull";  ///< 你的telegram、币用群组
NSString *const kShareAppName = @"MCShare";

@implementation MCShareConfig

+ (instancetype)share {
    static dispatch_once_t predicate;
    static MCShareConfig *instance;
    dispatch_once(&predicate, ^{
        instance = [MCShareConfig new];
    });
    return instance;
}

- (NSURL *)shareURLHost {
    NSURL *URL = [NSURL URLWithString:self.shareDynamicDto.host];
    return URL;
}

- (ShareDynamicDto *)shareDynamicDto {
    if (!_shareDynamicDto) {
        _shareDynamicDto = [ShareDynamicDto defaultShareDto];
    }
    return _shareDynamicDto;
}

@end
