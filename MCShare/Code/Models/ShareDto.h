//
// Created by majiancheng on 2017/7/20.
// Copyright (c) 2017 poholo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <LDSDKManager/LDSDKConfig.h>
#import <LDSDKManager/LDSDKShareService.h>

#import "MCShareConfig.h"
#import "Dto.h"

@class UIImage;
@class SocialPlatformDto;

@interface ShareDto : Dto

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

- (void)updateShareURL:(LDSDKPlatformType)platform;

- (void)updateSocialPlatform:(SocialPlatformDto *)platformDto;

+ (ShareDto *)createShareText:(NSString *)text callBack:(LDSDKShareCallback)callBack;

+ (ShareDto *)createShareImage:(NSString *)image callBack:(LDSDKShareCallback)callBack;

+ (ShareDto *)createShareNews:(NSString *)title desc:(NSString *)desc link:(NSString *)link image:(NSString *)image callBack:(LDSDKShareCallback)callBack;

+ (ShareDto *)createShareAudio:(NSString *)title desc:(NSString *)desc link:(NSString *)link image:(NSString *)image media:(NSString *)meidaUrl callBack:(LDSDKShareCallback)callBack;

+ (ShareDto *)createShareVideo:(NSString *)title desc:(NSString *)desc link:(NSString *)link image:(NSString *)image media:(NSString *)meidaUrl callBack:(LDSDKShareCallback)callBack;

+ (ShareDto *)createShareFile:(NSString *)title desc:(NSString *)desc link:(NSString *)link image:(NSString *)image file:(NSString *)filePath callBack:(LDSDKShareCallback)callBack;

+ (ShareDto *)createShareMiniProgram:(NSString *)programKey miniProgramType:(LDSDKMiniProgramType)type link:(NSString *)link callBack:(LDSDKShareCallback)callBack;

+ (ShareDto *)createCommenShareURL:(NSString *)url title:(NSString *)title desc:(NSString *)desc image:(NSString *)image;

@end


@interface ShareDynamicDto : Dto

@property(nonatomic, strong) NSString *host;

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *videoDesc;

@property(nonatomic, strong) NSString *desc;

@property(nonatomic, strong) NSString *sinaHost;
@property(nonatomic, strong) NSString *qqHost;
@property(nonatomic, strong) NSString *wechatHost;

+ (ShareDynamicDto *)defaultShareDto;


@end
