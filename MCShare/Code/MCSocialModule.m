//
//  MCSocialModule.m
//  poholo
//
//  Created by majiancheng on 2017/3/17.
//  Copyright © 2017年 poholo inc. All rights reserved.
//

#import "MCSocialModule.h"

#import <LDSDKManager/MMShareConfigDto.h>
#import <LDSDKManager/LDSDKManager.h>

#import "MCShareConfig.h"
#import "MCLoginHelper.h"

@interface MCSocialModule ()

@end

@implementation MCSocialModule

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [MCLoginHelper resgister];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[LDSDKManager share] handleURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[LDSDKManager share] handleURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary *)options {
    return [[LDSDKManager share] handleURL:url];
}

@end
