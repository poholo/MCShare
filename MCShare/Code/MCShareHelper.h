//
// Created by majiancheng on 2018/8/18.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCShareConfig.h"
#import "LDSDKManager.h"
#import "LDSDKShareService.h"

@class ShareDto;


@interface MCShareHelper : NSObject

+ (void)shareCommenShareDto:(ShareDto *)shareDto platform:(SocialPlatform)socialPlatform callBack:(void (^)(BOOL success, NSError *error))successBlock;

+ (LDSDKPlatformType)platform:(SocialPlatform)platform;

+ (LDSDKShareToModule)shareType:(SocialPlatform)platform;

+ (BOOL)action2Telegram:(NSURL *)URL schema:(NSURL *)schema;

@end