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
    param[LDSDKShareCallBackKey] = self.shareCallback;
    param[LDSDKPlatformTypeKey] = @(self.toPlatform);
    param[LDSDKShareToMoudleKey] = @(self.toModule);
    param[LDSDKShareTypeKey] = @(self.toType);

    param[LDSDKIdentifierKey] = self.dtoId;
    param[LDSDKShareTitleKey] = self.title;
    param[LDSDKShareDescKey] = self.desc;
    param[LDSDKShareImageKey] = self.image;
    param[LDSDKShareUrlKey] = [NSString stringWithFormat:@"%@&%@", self.shareUrl, [ShareDto sharePlatform:self.toPlatform type:self.toModule]];
    param[LDSDKShareMeidaUrlKey] = self.meidaUrl;
    param[LDSDKShareRedirectURIKey] = @"https://sns.whalecloud.com/sina2/callback";

    return param;
}


- (void)updateShareURL:(LDSDKPlatformType)platform {
    if ([self.shareUrl hasPrefix:@"http"]) {
        self.shareUrl = [ShareDto dynamicHost:self.shareUrl platform:platform module:self.toModule];
    }
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

+ (ShareDto *)createShareText:(NSString *)text callBack:(LDSDKShareCallback)callBack {
    ShareDto *dto = [ShareDto new];
    dto.desc = text;
    dto.shareCallback = callBack;
    dto.toType = LDSDKShareTypeText;
    return dto;
}

+ (ShareDto *)createShareImage:(NSString *)image callBack:(LDSDKShareCallback)callBack {
    ShareDto *dto = [ShareDto new];
    if ([image hasPrefix:@"http"]) {
        dto.imgUrl = image;
    } else if ([image hasPrefix:@"file:"]) {
        dto.image = [UIImage imageWithContentsOfFile:image];
    } else if (image.length > 0) {
        dto.image = [UIImage imageNamed:image];
    }
    dto.shareCallback = callBack;
    dto.toType = LDSDKShareTypeImage;
    return dto;
}

+ (ShareDto *)createShareNews:(NSString *)title desc:(NSString *)desc link:(NSString *)link image:(NSString *)image callBack:(LDSDKShareCallback)callBack {
    ShareDto *dto = [ShareDto createShareImage:image callBack:callBack];
    dto.title = title;
    dto.desc = desc;
    dto.shareUrl = link;
    dto.toType = LDSDKShareTypeNews;
    return dto;
}

+ (ShareDto *)createShareAudio:(NSString *)title desc:(NSString *)desc link:(NSString *)link image:(NSString *)image media:(NSString *)meidaUrl callBack:(LDSDKShareCallback)callBack {
    ShareDto *dto = [ShareDto createShareNews:title desc:desc link:link image:image callBack:callBack];
    dto.meidaUrl = meidaUrl;
    dto.toType = LDSDKShareTypeAudio;
    return dto;
}

+ (ShareDto *)createShareVideo:(NSString *)title desc:(NSString *)desc link:(NSString *)link image:(NSString *)image media:(NSString *)meidaUrl callBack:(LDSDKShareCallback)callBack {
    ShareDto *dto = [ShareDto createShareNews:title desc:desc link:link image:image callBack:callBack];
    dto.meidaUrl = meidaUrl;
    dto.toType = LDSDKShareTypeVideo;
    return dto;
}

+ (ShareDto *)createShareFile:(NSString *)title desc:(NSString *)desc link:(NSString *)link image:(NSString *)image file:(NSString *)filePath callBack:(LDSDKShareCallback)callBack {
    ShareDto *dto = [ShareDto createShareNews:title desc:desc link:link image:image callBack:callBack];
    dto.meidaUrl = filePath;
    dto.toType = LDSDKShareTypeFile;
    return dto;
}

+ (ShareDto *)createShareMiniProgram:(NSString *)programKey miniProgramType:(LDSDKMiniProgramType)type link:(NSString *)link callBack:(LDSDKShareCallback)callBack {

    return nil;
}

+ (ShareDto *)createCommenShareURL:(NSString *)url title:(NSString *)title desc:(NSString *)desc image:(NSString *)image {
    return nil;
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
