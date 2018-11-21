//
// Created by majiancheng on 2018/6/13.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "SocialShareConfig.h"
#import "ShareDto.h"

#pragma mark - ShareConfig
NSString *const SinaRedirectUri = @"https://sns.whalecloud.com/sina2/callback";

//TODO:: 各个账号id
#pragma mark - warning 各个账号id
NSString *const WXAppID = @"WXAppID";
NSString *const WXAppSecret = @"WXAppSecret";
NSString *const QQAppID = @"QQAppID";
NSString *const QQAppKey = @"QQAppKey";
NSString *const SinaAppID = @"SinaAppID";
NSString *const SinaAppKey = @"SinaAppKey";

NSString *const kShareAppName = @"MCShare";

NSInteger const kShareErrorCodeDel = -99;

@implementation SocialShareConfig

+ (instancetype)share {
    static dispatch_once_t predicate;
    static SocialShareConfig *instance;
    dispatch_once(&predicate, ^{
        instance = [[self class] new];
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
