//
// Created by majiancheng on 2017/7/20.
// Copyright (c) 2017 poholo Inc. All rights reserved.
//

#import "ShareDto.h"

#import <UIKit/UIKit.h>

#import "StringUtils.h"
#import "SocialPlatformDto.h"

@implementation ShareDto

- (NSDictionary *)shareDict {
    NSMutableDictionary *param = [NSMutableDictionary new];
    param[LDSDKIdentifierKey] = self.dtoId;
    param[LDSDKShareTitleKey] = self.title;
    param[LDSDKShareImageKey] = self.image ?: [UIImage imageNamed:@"icon_commen"];
    param[LDSDKShareDescKey] = self.desc;
    param[LDSDKShareRedirectURIKey] = @"https://sns.whalecloud.com/sina2/callback";
    param[LDSDKShareUrlKey] = [NSString stringWithFormat:@"%@&%@", self.shareUrl, [ShareDto sharePlatform:self.toPlatform type:self.toModule]];
    param[LDSDKShareCallBackKey] = self.shareCallback;
    param[LDSDKPlatformTypeKey] = @(self.toPlatform);
    param[LDSDKShareToMoudleKey] = @(self.toModule);
    param[LDSDKShareTypeKey] = @(self.toType);
    return param;
}

- (void)logProcess:(NSString *)target {
    // log process
}

- (void)logResult:(NSString *)target {
    //log result
}

- (void)updateShareURL:(LDSDKPlatformType)platform {
    self.shareUrl = [ShareDto dynamicHost:self.shareUrl platform:platform module:self.toModule];
}

- (void)updateSocialPlatform:(SocialPlatformDto *)platformDto {
    self.toPlatform = platformDto.platform;
    self.toModule = platformDto.module;
}

+ (NSString *)sharePlatform:(LDSDKPlatformType)platformType type:(LDSDKShareToModule)module {
    return [NSString stringWithFormat:@"appfrom=ios-%@-%zd-%zd", kShareAppName, platformType, module];
}

+ (NSString *)shareCommenParams {
    return [NSString stringWithFormat:@"source=mobileclient&platform=ios&from=singlemessage&appVersion=%@&appName=AppName", [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]];
}

+ (ShareDto *)createShareURL:(NSString *)url {
    NSParameterAssert(url);
    ShareDto *dto = [ShareDto new];
    dto.shareUrl = [ShareDto dynamicHost:url platform:LDSDKPlatformWeChat module:LDSDKShareToContact];
    dto.sourceDto = @"web";

    //日志参数构造
    {
        dto.logProcessEventName = @"share";
        dto.logResultEventName = @"share_suc";
    }

    return dto;
}


+ (ShareDto *)createShareURL:(NSString *)url title:(NSString *)title desc:(NSString *)desc image:(NSString *)image {
    NSParameterAssert(url);
    ShareDto *dto = [ShareDto new];
    dto.title = title;
    dto.desc = desc;
    dto.shareUrl = url;
    dto.imgUrl = image;
    dto.sourceDto = @"web";

    //日志参数构造
    {
        dto.logProcessEventName = @"share";
        dto.logResultEventName = @"share_suc";
    }

    return dto;
}

+ (NSString *)dynamicHost:(NSString *)url platform:(LDSDKPlatformType)platform module:(LDSDKShareToModule)module {
    NSURLComponents *components = [NSURLComponents componentsWithString:url];
    NSURL *shareURLHost = [NSURL URLWithString:[MCShareConfig share].shareDynamicDto.wechatHost];
//    if (platform == LDSDKShareToWeiboStory) {
//        shareURLHost = [NSURL URLWithString:[MCShareConfig share].shareDynamicDto.sinaHost];
//    } else if (platform == SocialPlatformQQ || platform == SocialPlatformQQZone) {
//        shareURLHost = [NSURL URLWithString:[MCShareConfig share].shareDynamicDto.qqHost];
//    }
    //TODO:: 动态域名
    components.host = shareURLHost.host;
    components.scheme = shareURLHost.scheme;
    return components.URL.absoluteString;
}


@end


@implementation ShareDynamicDto

- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"commonShare"]) {
        self.title = value[@"shareTitle"];
        self.desc = value[@"shareDesc"];
    }
}

+ (ShareDynamicDto *)defaultShareDto {
    ShareDynamicDto *dto = [ShareDynamicDto new];
    dto.host = @"https://www.baidu.com/";
    return dto;
}


- (NSString *)sinaHost {
    if (!_sinaHost) {
        return self.host;
    }
    return _sinaHost;
}

- (NSString *)qqHost {
    if (!_qqHost) {
        return self.host;
    }
    return _qqHost;
}

- (NSString *)wechatHost {
    if (!_wechatHost) {
        return self.host;
    }
    return _wechatHost;
}

- (NSString *)host {
    if (!_host) {
        return @"https://www.baidu.com/";
    }
    return _host;
}


@end
