
//
//  MCLoginHelper.m
//  WaQuVideo
//
//  Created by majiancheng on 16/11/30.
//  Copyright © 2016年 poholo inc. All rights reserved.
//

#import "MCLoginHelper.h"

#import <LDSDKManager/MCShareConfigDto.h>
#import <LDSDKManager/LDSDKManager.h>
#import <LDSDKManager/LDSDKAuthService.h>

@implementation MCLoginHelper

+ (void)resgister {
    MCShareConfigsCallBack  shareConfigsCallBack  = [MCShareConfig share].shareConfigsCallBack;
    NSAssert(shareConfigsCallBack, @"[MCShare][MCShareConfig share].shareConfigsCallBack un implement.");
    NSArray<MCShareConfigDto *> * configs = shareConfigsCallBack();
    NSMutableArray<NSDictionary *> * dealConfigs = [NSMutableArray new];
    for(MCShareConfigDto * configDto in configs) {
        [dealConfigs addObject:configDto.dict];
    }
    [[LDSDKManager share] registerWithPlatformConfigList:dealConfigs];
}

+ (void)loginType:(LDSDKPlatformType)socialPlatform callBack:(OauthResult)callBack {
    id <LDSDKAuthService> authService = [[LDSDKManager share] authService:socialPlatform];
    [authService authPlatformCallback:^(LDSDKLoginCode code, NSError *error, NSDictionary *oauthInfo, NSDictionary *userInfo) {
        LDLog(@"[Login] %@ %@ %@", oauthInfo, userInfo, error);
        if (!callBack) return;
        if (code == LDSDKLoginSuccess) {
            if (userInfo == nil && oauthInfo != nil) {
                callBack(oauthInfo, nil);
            } else {
                callBack(userInfo, nil);
            }
        } else {
            callBack(nil, error);
        }
    }                             ext:nil];
}

@end

