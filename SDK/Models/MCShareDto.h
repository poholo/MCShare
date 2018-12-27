//
// Created by majiancheng on 2017/7/20.
// Copyright (c) 2017 poholo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <LDSDKManager/LDSDKConfig.h>
#import <LDSDKManager/LDSDKShareService.h>

#import "MCDto.h"
#import "LDSDKConfig.h"

@class UIImage;
@class MCSocialPlatformDto;

@interface MCShareDto : MCDto

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *imgUrl;
@property(nonatomic, copy) NSString *shareUrl;
@property(nonatomic, copy) NSString *meidaUrl;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, copy) NSString *desc;
@property(nonatomic, strong) id sourceDto;

@property(nonatomic, assign) LDSDKPlatformType toPlatform;
@property(nonatomic, assign) LDSDKShareToModule toModule;
@property(nonatomic, assign) LDSDKShareType toType;

@property(nonatomic, copy) LDSDKShareCallback shareCallback;


- (NSDictionary *)shareDict;

- (NSString *)pasteText;

- (void)updateShareURL:(LDSDKPlatformType)platform;

- (void)updateSocialPlatform:(MCSocialPlatformDto *)platformDto;

+ (MCShareDto *)createShareText:(NSString *)text callBack:(LDSDKShareCallback)callBack;

+ (MCShareDto *)createShareImage:(NSString *)image callBack:(LDSDKShareCallback)callBack;

+ (MCShareDto *)createShareNews:(NSString *)title desc:(NSString *)desc link:(NSString *)link image:(NSString *)image callBack:(LDSDKShareCallback)callBack;

+ (MCShareDto *)createShareAudio:(NSString *)title desc:(NSString *)desc link:(NSString *)link image:(NSString *)image media:(NSString *)meidaUrl callBack:(LDSDKShareCallback)callBack;

+ (MCShareDto *)createShareVideo:(NSString *)title desc:(NSString *)desc link:(NSString *)link image:(NSString *)image media:(NSString *)meidaUrl callBack:(LDSDKShareCallback)callBack;

+ (MCShareDto *)createShareFile:(NSString *)title desc:(NSString *)desc link:(NSString *)link image:(NSString *)image file:(NSString *)filePath callBack:(LDSDKShareCallback)callBack;

+ (MCShareDto *)createShareMiniProgram:(NSString *)programKey miniProgramType:(LDSDKMiniProgramType)type link:(NSString *)link callBack:(LDSDKShareCallback)callBack;

+ (MCShareDto *)createCommenShareURL:(NSString *)url title:(NSString *)title desc:(NSString *)desc image:(NSString *)image;

@end


@interface MCShareDynamicDto : MCDto

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *desc;

@property(nonatomic, strong) NSString *qqHost;
@property(nonatomic, strong) NSString *wechatHost;
@property(nonatomic, strong) NSString *sinaHost;
@property(nonatomic, strong) NSString *alipayHost;
@property(nonatomic, strong) NSString *telegramHost;
@property(nonatomic, strong) NSString *dingTalkHost;
@property(nonatomic, strong) NSString *defalutHost;

@end
