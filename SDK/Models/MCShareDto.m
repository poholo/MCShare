//
// Created by majiancheng on 2017/7/20.
// Copyright (c) 2017 poholo Inc. All rights reserved.
//

#import "MCShareDto.h"

#import <UIKit/UIKit.h>
#import <LDSDKManager/LDSDKConfig.h>

#import "StringUtils.h"
#import "MCSocialPlatformDto.h"
#import "LDSDKShareService.h"

@implementation MCShareDto

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
    param[LDSDKShareUrlKey] = [NSString stringWithFormat:@"%@&%@", self.shareUrl, [MCShareDto sharePlatform:self.toPlatform type:self.toModule]];
    param[LDSDKShareMeidaUrlKey] = self.meidaUrl;
    param[LDSDKShareRedirectURIKey] = @"https://sns.whalecloud.com/sina2/callback";

    return param;
}


- (NSString *)pasteText {
    NSString *paste = [NSString stringWithFormat:@"%@ %@ %@", self.title ?: @"", self.desc ?: @"", self.shareUrl ?: @""];
    return paste;
}


- (void)updateShareURL:(LDSDKPlatformType)platform {
    if ([self.shareUrl hasPrefix:@"http"]) {
        self.shareUrl = [MCShareDto dynamicHost:self.shareUrl platform:platform module:self.toModule];
    }
}

- (void)updateSocialPlatform:(MCSocialPlatformDto *)platformDto {
    self.toPlatform = platformDto.platform;
    self.toModule = platformDto.module;
}

+ (NSString *)sharePlatform:(LDSDKPlatformType)platformType type:(LDSDKShareToModule)module {
    return [NSString stringWithFormat:@"appfrom=ios-%@-%zd-%zd", @"MCShare", platformType, module];
}

+ (NSString *)shareCommenParams {
    return [NSString stringWithFormat:@"source=mobileclient&platform=ios&from=singlemessage&appVersion=%@&appName=AppName", [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]];
}

+ (MCShareDto *)createShareText:(NSString *)text callBack:(LDSDKShareCallback)callBack {
    MCShareDto *dto = [MCShareDto new];
    dto.desc = text;
    dto.shareCallback = callBack;
    dto.toType = LDSDKShareTypeText;
    return dto;
}

+ (MCShareDto *)createShareImage:(NSString *)image callBack:(LDSDKShareCallback)callBack {
    MCShareDto *dto = [MCShareDto new];
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

+ (MCShareDto *)createShareNews:(NSString *)title desc:(NSString *)desc link:(NSString *)link image:(NSString *)image callBack:(LDSDKShareCallback)callBack {
    MCShareDto *dto = [MCShareDto createShareImage:image callBack:callBack];
    dto.title = title;
    dto.desc = desc;
    dto.shareUrl = link;
    dto.toType = LDSDKShareTypeNews;
    return dto;
}

+ (MCShareDto *)createShareAudio:(NSString *)title desc:(NSString *)desc link:(NSString *)link image:(NSString *)image media:(NSString *)meidaUrl callBack:(LDSDKShareCallback)callBack {
    MCShareDto *dto = [MCShareDto createShareNews:title desc:desc link:link image:image callBack:callBack];
    dto.meidaUrl = meidaUrl;
    dto.toType = LDSDKShareTypeAudio;
    return dto;
}

+ (MCShareDto *)createShareVideo:(NSString *)title desc:(NSString *)desc link:(NSString *)link image:(NSString *)image media:(NSString *)meidaUrl callBack:(LDSDKShareCallback)callBack {
    MCShareDto *dto = [MCShareDto createShareNews:title desc:desc link:link image:image callBack:callBack];
    dto.meidaUrl = meidaUrl;
    dto.toType = LDSDKShareTypeVideo;
    return dto;
}

+ (MCShareDto *)createShareFile:(NSString *)title desc:(NSString *)desc link:(NSString *)link image:(NSString *)image file:(NSString *)filePath callBack:(LDSDKShareCallback)callBack {
    MCShareDto *dto = [MCShareDto createShareNews:title desc:desc link:link image:image callBack:callBack];
    dto.meidaUrl = filePath;
    dto.toType = LDSDKShareTypeFile;
    return dto;
}

+ (MCShareDto *)createShareMiniProgram:(NSString *)programKey miniProgramType:(LDSDKMiniProgramType)type link:(NSString *)link callBack:(LDSDKShareCallback)callBack {

    return nil;
}

+ (MCShareDto *)createCommenShareURL:(NSString *)url title:(NSString *)title desc:(NSString *)desc image:(NSString *)image {
    return nil;
}


+ (NSString *)dynamicHost:(NSString *)url platform:(LDSDKPlatformType)platform module:(LDSDKShareToModule)module {
    NSURLComponents *components = [NSURLComponents componentsWithString:url];
    NSURL *shareURLHost = [NSURL URLWithString:[[MCShareConfig share] hostForPlatform:platform]];
    components.host = shareURLHost.host;
    components.scheme = shareURLHost.scheme;
    return components.URL.absoluteString;
}

@end


@implementation MCShareDynamicDto

- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"qq"]) {
        self.qqHost = value;
    } else if ([key isEqualToString:@"wechat"]) {
        self.wechatHost = value;
    } else if ([key isEqualToString:@""]) {
        self.sinaHost = value;
    } else if ([key isEqualToString:@"alipay"]) {
        self.alipayHost = value;
    } else if ([key isEqualToString:@"telegaram"]) {
        self.telegramHost = value;
    } else if ([key isEqualToString:@"dingtalk"]) {
        self.dingTalkHost = value;
    } else if ([key isEqualToString:@"default"]) {
        self.defalutHost = value;
    }
}

+ (MCShareDynamicDto *)defaultShareDto {
    MCShareDynamicDto *dto = [MCShareDynamicDto new];
    return dto;
}


- (NSString *)qqHost {
    if (!_qqHost) {
        return self.defalutHost;
    }
    return _qqHost;
}

- (NSString *)wechatHost {
    if (!_wechatHost) {
        return self.defalutHost;
    }
    return _wechatHost;
}

- (NSString *)sinaHost {
    if (!_sinaHost) {
        return self.defalutHost;
    }
    return _sinaHost;
}

- (NSString *)alipayHost {
    if (!_alipayHost) {
        return self.defalutHost;
    }
    return _alipayHost;
}

- (NSString *)telegramHost {
    if (!_telegramHost) {
        return self.defalutHost;
    }
    return _telegramHost;
}

- (NSString *)dingTalkHost {
    if (!_dingTalkHost) {
        return self.defalutHost;
    }
    return _dingTalkHost;
}

#pragma mark - getter

- (NSString *)defalutHost {
    if (!_defalutHost) {
        _defalutHost = @"https://baidu.com";
    }
    return _defalutHost;
}


@end
