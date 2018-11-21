//
//  SocialModule.m
//  poholo
//
//  Created by majiancheng on 2017/3/17.
//  Copyright © 2017年 poholo inc. All rights reserved.
//

#import "SocialModule.h"

#import <AlipaySDK/AlipaySDK.h>

#import "SocialLoginHelper.h"
#import "LDSDKManager.h"

@interface SocialModule ()

@end

@implementation SocialModule

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [SocialLoginHelper resgister];

    return YES;
}

// 分享SSO免登陆配置
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [LDSDKManager handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    /*if ([url.host isEqualToString:@"safepay"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificaitonAlipayResult object:url];
        [[BindHelper share] aliPayProcessAuth_V2Result:url];
        return YES;
    }

    BOOL open = [WXApi handleOpenURL:url delegate:(id <WXApiDelegate>) [WechatPayHelper share]];
*/
    BOOL open;
    if (!open) {
//        open = [SchemaOpenUtils handleOpenURL:url];
    }
    return open;
}

// Availability : iOS (9.0 and later)
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary *)options {
    /*
     if ([url.host isEqualToString:@"safepay"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificaitonAlipayResult object:url];
        [[BindHelper share] aliPayProcessAuth_V2Result:url];
        return YES;
    }

    BOOL open = [WXApi handleOpenURL:url delegate:(id <WXApiDelegate>) [WechatPayHelper share]];
    */
    BOOL open;
    if (!open) {
//        open = [SchemaOpenUtils handleOpenURL:url];
    }
    return open;
}

@end
