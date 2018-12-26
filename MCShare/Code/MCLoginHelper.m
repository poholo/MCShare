
//
//  MCLoginHelper.m
//  WaQuVideo
//
//  Created by majiancheng on 16/11/30.
//  Copyright © 2016年 poholo inc. All rights reserved.
//

#import "MCLoginHelper.h"
#import "LDSDKAuthService.h"

#import <LDSDKManager/LDSDKShareService.h>
#import <LDSDKManager/LDSDKManager.h>


@implementation MCLoginHelper

+ (void)resgister {
    NSArray *regPlatformConfigList = @[
            @{LDSDKConfigAppIdKey: WXAppID,
                    LDSDKConfigAppSecretKey: WXAppSecret,
                    LDSDKConfigAppDescriptionKey: [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                    LDSDKConfigAppPlatformTypeKey: @(LDSDKPlatformWeChat)},
            @{LDSDKConfigAppIdKey: QQAppID,
                    LDSDKConfigAppSecretKey: QQAppKey,
                    LDSDKConfigAppPlatformTypeKey: @(LDSDKPlatformQQ)},
            @{LDSDKConfigAppIdKey: SinaAppID,
                    LDSDKConfigAppSecretKey: SinaAppKey,
                    LDSDKShareRedirectURIKey: SinaRedirectUri,
                    LDSDKConfigAppPlatformTypeKey: @(LDSDKPlatformWeibo)},
            @{LDSDKConfigAppIdKey: DingTalkId,
                    LDSDKConfigAppSecretKey: DingTalkAppKey,
                    LDSDKConfigAppPlatformTypeKey: @(LDSDKPlatformDingTalk)}];
    [[LDSDKManager share] registerWithPlatformConfigList:regPlatformConfigList];
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

