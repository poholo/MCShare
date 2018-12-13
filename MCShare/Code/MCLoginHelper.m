
//
//  MCLoginHelper.m
//  WaQuVideo
//
//  Created by majiancheng on 16/11/30.
//  Copyright © 2016年 poholo inc. All rights reserved.
//

#import "MCLoginHelper.h"

#import <LDSDKManager/LDSDKShareService.h>

#import "LDSDKRegisterService.h"
#import "LDSDKManager.h"
#import "LDSDKAuthService.h"
#import "GCD.h"

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
                    LDSDKConfigAppPlatformTypeKey: @(LDSDKPlatformWeibo)}];
    [[LDSDKManager share] registerWithPlatformConfigList:regPlatformConfigList];
}

+ (void)loginType:(SocialPlatform)socialPlatform callback:(OauthResult)callback {
    switch (socialPlatform) {
        case SocialPlatformQQ:
            [self loginQQCallback:callback];
            break;
        case SocialPlatformWeiBo:
            [self loginWeiBoCallback:callback];
            break;
        case SocialPlatformWeChat:
            [self loginWeiChatCallback:callback];
            break;
        default:
            break;
    }
}

+ (void)loginQQCallback:(OauthResult)callback {
    id <LDSDKAuthService> authService = [[LDSDKManager share] authService:LDSDKPlatformQQ];
    [authService authPlatformCallback:^(LDSDKLoginCode code, NSError *error, NSDictionary *oauthInfo, NSDictionary *userInfo) {
        [[GCDQueue mainQueue] execute:^{
            if (callback) {
                NSLog(@"NSLocalizedDescription");
                if (error) {
                    callback(nil, error);
                } else {
                    if (userInfo) {
                        NSDictionary *dic = @{@"thirdPartId": oauthInfo[@"openId"], @"picAddress": userInfo[@"figureurl_qq_2"], @"nickName": userInfo[@"nickname"], @"gender": userInfo[@"gender"]};
                        callback(dic, nil);

                    }
                }
            }
        }];

    }];
}

+ (void)loginWeiChatCallback:(OauthResult)callback {
    id <LDSDKAuthService> authService = [[LDSDKManager share] authService:LDSDKPlatformWeChat];
    [authService authPlatformCallback:^(LDSDKLoginCode code, NSError *error, NSDictionary *oauthInfo, NSDictionary *userInfo) {
        [[GCDQueue mainQueue] execute:^{
            if (callback) {
                if (error) {
                    callback(nil, error);
                } else {
                    if (userInfo) {
                        NSDictionary *dic = @{@"thirdPartId": userInfo[@"openid"], @"picAddress": userInfo[@"headimgurl"], @"nickName": userInfo[@"nickname"], @"unionid": userInfo[@"unionid"]};
                        callback(dic, nil);
                    }
                }
            }
        }];
    }];
}

+ (void)loginWeiBoCallback:(OauthResult)callback {
    id <LDSDKAuthService> authService = [[LDSDKManager share] authService:LDSDKPlatformWeibo];
    [authService authPlatformCallback:^(LDSDKLoginCode code, NSError *error, NSDictionary *oauthInfo, NSDictionary *userInfo) {
        [[GCDQueue mainQueue] execute:^{
            if (callback) {
                if (error) {
                    callback(nil, error);
                } else {
                    if (userInfo) {
                        NSDictionary *dic = @{@"thirdPartId": userInfo[@"thirdId"], @"picAddress": userInfo[@"pic"], @"nickName": userInfo[@"name"], @"gender": userInfo[@"gender"]};
                        callback(dic, nil);
                    }
                }
            }
        }];

    }];
}

@end

