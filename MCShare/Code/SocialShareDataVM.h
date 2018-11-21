//
// Created by majiancheng on 2018/6/13.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "LDSDKManager.h"
#import "SocialShareConfig.h"
#import "LDSDKShareService.h"

@class ShareDto;
@class RACSignal;


@interface SocialShareDataVM : NSObject
@property(nonatomic, strong) NSMutableArray *dataList;
@property(nonatomic, strong) NSNumber *currentPos;

- (void)refresh;

@property(nonatomic, strong) ShareDto *shareDto;

- (RACSignal *)shareHost;

- (BOOL)share2Telegram;

- (LDSDKPlatformType)platform:(SocialPlatform)platform;

- (LDSDKShareToModule)shareType:(SocialPlatform)platform;

@end
