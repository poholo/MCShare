//
// Created by majiancheng on 2017/7/20.
// Copyright (c) 2017 poholo Inc. All rights reserved.
//

#import "ShareDto.h"

#import <ReactiveCocoa.h>

#import "LDSDKShareService.h"
#import "StringUtils.h"

@implementation ShareDto

- (NSDictionary *)shareDict {
    NSMutableDictionary *param = @{LDSDKShareTitleKey: self.title ?: @"",
            LDSDKShareImageKey: self.image ?: [UIImage imageNamed:@"icon_commen"],
            LDSDKShareDescKey: self.desc ?: @"",
            LDSDKShareRedirectURIKey: @"https://sns.whalecloud.com/sina2/callback"}.mutableCopy;

    param[LDSDKShareUrlKey] = [NSString stringWithFormat:@"%@&%@", self.shareUrl, [ShareDto sharePlatform:self.platform]];

    return param;
}

- (void)logProcess:(NSString *)target {
    // log process
}

- (void)logResult:(NSString *)target {
    //log result
}

- (void)updateShareURL:(SocialPlatform)platform {
    self.shareUrl = [ShareDto dynamicHost:self.shareUrl platform:platform];
}

- (void)updatePaste {
    self.pasteText = [NSString stringWithFormat:@"%@ %@ %@", [StringUtils hasText:self.title] ? self.title : @"", [StringUtils hasText:[MCShareConfig share].shareDynamicDto.videoDesc] ? [MCShareConfig share].shareDynamicDto.videoDesc : @"", self.shareUrl];


}


+ (NSInteger)target:(SocialPlatform)platform {
    NSInteger result = 0;
    switch (platform) {
        case SocialPlatformWeChat:
            result = 0;
            break;
        case SocialPlatformWeChatFriend:
            result = 1;
            break;
        case SocialPlatformQQ:
            result = 2;
            break;
        case SocialPlatformWeiBo:
            result = 3;
            break;
        case SocialPlatformQQZone:
            result = 4;
            break;
        case SocialPlatformLink:
            result = 10;
            break;
        case SocialPlatformTelegram:
            result = 15;
            break;
        default:
            break;
    }
    return result;
}


+ (NSString *)sharePlatform:(SocialPlatform)socialPlatform {
    return [NSString stringWithFormat:@"appfrom=ios-%@-%zd", kShareAppName, [ShareDto target:socialPlatform]];
}

+ (NSString *)shareCommenParams {
    return [NSString stringWithFormat:@"source=mobileclient&platform=ios&from=singlemessage&appVersion=%@&appName=firebull", [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]];
}

+ (ShareDto *)createShareURL:(NSString *)url {
    NSParameterAssert(url);
    ShareDto *dto = [ShareDto new];
    dto.shareUrl = [ShareDto dynamicHost:url platform:SocialPlatformWeChat];
    dto.sourceDto = @"web";

    //日志参数构造
    {
        dto.logProcessEventName = @"share";
        dto.logResultEventName = @"share_suc";
    }

    return dto;
}


+ (ShareDto *)createShareURL:(NSString *)url title:(NSString *)title desc:(NSString *)desc image:(NSString *)image pasteText:(NSString *)pasteText {
    NSParameterAssert(url);
    ShareDto *dto = [ShareDto new];
    dto.title = title;
    dto.desc = desc;
    dto.shareUrl = [ShareDto dynamicHost:url platform:SocialPlatformWeChat];
    dto.imgUrl = image;
    dto.sourceDto = @"web";
    dto.pasteText = pasteText;

    //日志参数构造
    {
        dto.logProcessEventName = @"share";
        dto.logResultEventName = @"share_suc";
    }

    return dto;
}

+ (NSString *)dynamicHost:(NSString *)url platform:(SocialPlatform)platform {
    NSURLComponents *components = [NSURLComponents componentsWithString:url];
    NSURL *shareURLHost = [NSURL URLWithString:[MCShareConfig share].shareDynamicDto.wechatHost];
    if (platform == SocialPlatformWeiBo) {
        shareURLHost = [NSURL URLWithString:[MCShareConfig share].shareDynamicDto.sinaHost];
    } else if (platform == SocialPlatformQQ || platform == SocialPlatformQQZone) {
        shareURLHost = [NSURL URLWithString:[MCShareConfig share].shareDynamicDto.qqHost];
    }
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
