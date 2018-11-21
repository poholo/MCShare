
//
//  SocialLoginHelper.m
//  WaQuVideo
//
//  Created by majiancheng on 16/11/30.
//  Copyright © 2016年 poholo inc. All rights reserved.
//

#import "SocialLoginHelper.h"

#import <LDSDKManager/LDSDKShareService.h>

#import "LDSDKRegisterService.h"
#import "LDSDKManager.h"
#import "LDSDKAuthService.h"
#import "GCD.h"

@implementation SocialLoginHelper

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
                    LDSDKShareContentRedirectURIKey: SinaRedirectUri,
                    LDSDKConfigAppPlatformTypeKey: @(LDSDKPlatformWeibo)}];
    [LDSDKManager registerWithPlatformConfigList:regPlatformConfigList];
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
    [[LDSDKManager getAuthService:LDSDKPlatformQQ] loginToPlatformWithCallback:^(NSDictionary *oauthInfo, NSDictionary *userInfo, NSError *error) {
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
    [[LDSDKManager getAuthService:LDSDKPlatformWeChat] loginToPlatformWithCallback:^(NSDictionary *oauthInfo, NSDictionary *userInfo, NSError *error) {
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
    [[LDSDKManager getAuthService:LDSDKPlatformWeibo] loginToPlatformWithCallback:^(NSDictionary *oauthInfo, NSDictionary *userInfo, NSError *error) {
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

