//
// Created by majiancheng on 2017/7/20.
// Copyright (c) 2017 挖趣智慧科技（北京）有限公司. All rights reserved.
//

#import "ShareDto.h"

#import <ReactiveCocoa.h>

#import "LDSDKShareService.h"
#import "AppConfig.h"
#import "User.h"
#import "NSUserDefaults+User.h"
#import "VideoDto.h"
#import "LogParam.h"
#import "LogService.h"
#import "StringUtils.h"
#import "UserSession.h"
#import "NetConfig.h"
#import "LiveInfo.h"
#import "NSURL+Convert2HTTPS.h"
#import "NSDate+Number.h"

@implementation ShareDto

- (NSDictionary *)shareDict {
    NSMutableDictionary *param = @{LDSDKShareContentTitleKey: self.title ?: @"",
            LDSDKShareContentImageKey: self.image ?: [UIImage imageNamed:@"icon_commen"],
            LDSDKShareIsImageShareKey: @(self.isImageShare),
            LDSDKShareContentDescriptionKey: self.desc ?: @"",
            LDSDKShareContentTextKey: self.desc ?: @"",
            LDSDKShareContentRedirectURIKey: @"https://sns.whalecloud.com/sina2/callback"}.mutableCopy;

    param[LDSDKShareContentWapUrlKey] = [NSString stringWithFormat:@"%@&%@", self.shareUrl, [ShareDto sharePlatform:self.platform]];

    return param;
}

- (void)logProcess:(NSString *)target {
    [self.logParam setValue:target key:@"target"];
    [LogService createCommen:self.logProcessEventName logParam:self.logParam filterUseKeys:@[@"refer", @"info", @"target", @"type"]];
}

- (void)logResult:(NSString *)target {
    [self.logParam setValue:target key:@"target"];
    [LogService createCommen:self.logResultEventName logParam:self.logParam filterUseKeys:@[@"info", @"target", @"type"]];
}

- (void)updateShareURL:(SocialPlatform)platform; {
    self.shareUrl = [ShareDto dynamicHost:self.shareUrl platform:platform];
    if ([self.sourceDto isKindOfClass:[VideoDto class]] || [self.sourceDto isKindOfClass:[LiveInfo class]]) {
        self.desc = [AppConfig share].shareDynamicDto.videoDesc;
    }
}

- (void)updatePaste {
    self.pasteText = [NSString stringWithFormat:@"%@ %@ %@", [StringUtils hasText:self.title] ? self.title : @"", [StringUtils hasText:[AppConfig share].shareDynamicDto.videoDesc] ? [AppConfig share].shareDynamicDto.videoDesc : @"", self.shareUrl];

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
    return [NSString stringWithFormat:@"appfrom=ios-%@-%zd", [NSUserDefaults getAppName], [ShareDto target:socialPlatform]];
}

+ (NSString *)shareCommenParams {
    return [NSString stringWithFormat:@"source=mobileclient&platform=ios&from=singlemessage&appVersion=%@&appName=firebull", [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]];
}

+ (ShareDto *)createShareVideo:(VideoDto *)video logParam:(LogParam *)logParam {
    //分享参数
    NSParameterAssert(video);
    ShareDto *dto = [ShareDto new];
    dto.sourceDto = video;
    dto.title = [StringUtils hasText:video.title] ? video.title : @"这有个超火视频等你来捧场";
    NSString *path = [NetConfig sharedInstance].netConfigType == NetConfigDevelop ? @"static/firebull/video.html" : @"vshare/index.php";
    dto.shareUrl = [NSString stringWithFormat:@"%@%@?wid=%@&%@&roomId=%@&uid=%@",
                                              [[AppConfig share] shareURLHost].absoluteString,
                                              path,
                                              video.dtoId,
                                              [ShareDto shareCommenParams],
                                              [UserSession share].user.roomId,
                                              [UserSession share].user.entityId];
    dto.imgUrl = video.imageUrl;

    //日志参数构造
    {
        dto.logParam = [logParam copy];
        [dto.logParam setValue:video.dtoId key:@"info"];
        [dto.logParam setValue:@"1" key:@"type"];

        dto.logProcessEventName = @"share";
        dto.logResultEventName = @"share_suc";
    }


    return dto;
}

+ (ShareDto *)createShareURL:(NSString *)url logParam:(LogParam *)logParam {
    NSParameterAssert(url);
    ShareDto *dto = [ShareDto new];
    dto.shareUrl = [ShareDto dynamicHost:url platform:SocialPlatformWeChat];
    dto.image = [UIImage imageNamed:@"icon_commen"];

    @weakify(dto);
    dto.shareCallback = ^(id value) {
        @strongify(dto);
    };

    //日志参数构造
    {
        dto.logParam = [logParam copy];
        [dto.logParam setValue:@"3" key:@"type"];
        dto.logProcessEventName = @"share";
        dto.logResultEventName = @"share_suc";
    }

    return dto;
}

+ (ShareDto *)createLive:(LiveInfo *)liveInfo logParam:(LogParam *)logParam {
    NSParameterAssert(liveInfo);
    ShareDto *dto = [ShareDto new];
    dto.title = [StringUtils hasText:liveInfo.name] ? liveInfo.name : @"这有个超火的直播等你捧场";

    dto.shareUrl = [NSString stringWithFormat:@"%@static/firebull/share/live.html?lsid=%@&roomId=%@&uid=%@&%@",
                                              [[AppConfig share] shareURLHost].absoluteString,
                                              liveInfo.lsid,
                                              [UserSession share].user.roomId,
                                              [UserSession share].user.entityId,
                                              [ShareDto shareCommenParams]];
    dto.imgUrl = liveInfo.thumbnailUrl;
    dto.sourceDto = liveInfo;

    @weakify(dto);
    dto.shareCallback = ^(id value) {
        @strongify(dto);
    };

    //日志参数构造
    {
        dto.logParam = [logParam copy];
        [dto.logParam setValue:@"6" key:@"type"];
        [dto.logParam setValue:liveInfo.lsid key:@"info"];
        dto.logProcessEventName = @"share";
        dto.logResultEventName = @"share_suc";
    }

    return dto;
}


+ (ShareDto *)createShareURL:(NSString *)url title:(NSString *)title desc:(NSString *)desc image:(NSString *)image pasteText:(NSString *)pasteText logParam:(LogParam *)logParam {
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
        dto.logParam = [logParam copy];
        [dto.logParam setValue:@"2" key:@"type"];
        dto.logProcessEventName = @"share";
        dto.logResultEventName = @"share_suc";
    }

    return dto;
}

+ (NSString *)dynamicHost:(NSString *)url platform:(SocialPlatform)platform {
    NSURLComponents *components = [NSURLComponents componentsWithString:url];
    NSURL *shareURLHost = [NSURL URLWithString:[AppConfig share].shareDynamicDto.wechatHost];
    if (platform == SocialPlatformWeiBo) {
        shareURLHost = [NSURL URLWithString:[AppConfig share].shareDynamicDto.sinaHost];
    } else if (platform == SocialPlatformQQ || platform == SocialPlatformQQZone) {
        shareURLHost = [NSURL URLWithString:[AppConfig share].shareDynamicDto.qqHost];
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
    dto.host = @"https://www.feixun.tv/";
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
        return @"https://www.feixun.tv/";
    }
    return _host;
}


@end
