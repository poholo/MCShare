//
//  AppDelegate.m
//  MCShare
//
//  Created by majiancheng on 2018/11/20.
//  Copyright © 2018 majiancheng. All rights reserved.
//

#import "AppDelegate.h"

#import <LDSDKManager/MCShareConfigDto.h>
#import <MCStyle/MCStyleManager.h>

#import "MCSocialModule.h"
#import "MCSocialManager.h"

@interface AppDelegate ()

@property(nonatomic, strong) MCSocialModule *socialModule;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /***账号配置 分享 & 授权***/
    __weak typeof(self) weakSelf = self;
    [MCSocialManager share].socialConfigsCallBack = ^NSArray<MCShareConfigDto *> *(void) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        return [strongSelf configs];
    };

    /*** 动态域名*/
    [MCSocialManager share].dynamicHostCallback = ^NSDictionary *(NSString *type) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"DynamicHost" ofType:@"json"];
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:&error];
        NSMutableDictionary *result = [NSMutableDictionary new];
        result[DATA_STATUS] = @( error ? NO : YES);
        result[DATA_CONTENT] = dictionary;
        return result;
    };

    /** 分享展示项***/
    [MCSocialManager share].shareItemsCallBack = ^NSDictionary *(void) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SharePlatform" ofType:@"json"];
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:&error];
        NSMutableDictionary *result = [NSMutableDictionary new];
        result[DATA_STATUS] = @( error ? NO : YES);
        result[DATA_CONTENT] = dictionary;
        return result;
    };

    /** 授权展示项目 ***/
    [MCSocialManager share].socialAuthItemsCallBack = ^NSDictionary *(void) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SocialAuth" ofType:@"json"];
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:&error];
        NSMutableDictionary *result = [NSMutableDictionary new];
        result[DATA_STATUS] = @( error ? NO : YES);
        result[DATA_CONTENT] = dictionary;
        return result;
    };


    // 配置自定义颜色
    [MCStyleManager share].colorStyleDataCallback = ^NSDictionary *(void) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CustomColor" ofType:@"json"];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:nil];
        return dict[@"data"];
    };
    [[MCStyleManager share] loadData];

    [self.socialModule application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (NSArray<MCShareConfigDto *> *)configs {
    //    NSString *const kTelegramGroup = @"https://0.plus/firebull";  ///< 你的telegram、币用群组
//    NSString *const kShareAppName = @"MCShare";

    NSMutableArray<MCShareConfigDto *> *configs = [NSMutableArray new];
    /*************配置账号Id 秘钥(非必须)****************/
    {
        MCShareConfigDto *configDto = [MCShareConfigDto new];
        configDto.appId = @"1106976672";
        configDto.appSecret = @"D76uzXaBnfC4hxyO";
        configDto.appPlatformType = LDSDKPlatformQQ;
        [configs addObject:configDto];
    }

    {
        MCShareConfigDto *configDto = [MCShareConfigDto new];
        configDto.appId = @"wxd6b4d4ada6beb442";
        configDto.appSecret = @"a2be3d08a304c26d1e538cd3f02e5362";
        configDto.appPlatformType = LDSDKPlatformWeChat;
        [configs addObject:configDto];
    }
    {
        MCShareConfigDto *configDto = [MCShareConfigDto new];
        configDto.appId = @"4272693281";
        configDto.appSecret = @"3e6b76df2ff8b3aafb050c5defe7427f";
        configDto.redirectURI = @"https://sns.whalecloud.com/sina2/callback";
        configDto.appPlatformType = LDSDKPlatformWeibo;
        [configs addObject:configDto];
    }
    {
        MCShareConfigDto *configDto = [MCShareConfigDto new];
        configDto.appId = @"2018121462531700";
        configDto.appSecret = @"AivRsxOiPoiXklp5";
        configDto.appPlatformType = LDSDKPlatformAliPay;
        [configs addObject:configDto];
    }
    {
        MCShareConfigDto *configDto = [MCShareConfigDto new];
        configDto.appId = @"";
        configDto.appSecret = @"";
        configDto.appPlatformType = LDSDKPlatformTelegaram;
        [configs addObject:configDto];
    }
    {
        MCShareConfigDto *configDto = [MCShareConfigDto new];
        configDto.appId = @"dingoak5hqhuvmpfhpnjvt";
        configDto.appSecret = @"ECV9fyHQhgraFwq3rn-7cOrII24stKBCB0NWb2pQHLKYOCM2HXOYZZtyR1A2p0Fb";
        configDto.appPlatformType = LDSDKPlatformDingTalk;
        [configs addObject:configDto];
    }
    /*****************************/
    return configs;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL hand = [self.socialModule application:application handleOpenURL:url];
    return hand;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL rsp = [self.socialModule application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    if (rsp) {
        return rsp;
    }
    return NO;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary *)options {
    BOOL rsp = [self.socialModule application:application openURL:url options:options];
    if (rsp) {
        return rsp;
    }
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - getter

- (MCSocialModule *)socialModule {
    if (!_socialModule) {
        _socialModule = [MCSocialModule new];
    }
    return _socialModule;
}


@end
