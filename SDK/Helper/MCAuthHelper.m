
//
//  MCAuthHelper.m
//  MCShare
//
//  Created by majiancheng on 16/11/30.
//  Copyright © 2016年 poholo inc. All rights reserved.
//

#import "MCAuthHelper.h"

#import <LDSDKManager/LDSDKManager.h>

@implementation MCAuthHelper

+ (void)auth:(LDSDKPlatformType)socialPlatform callBack:(LDSDKAuthCallback)callBack {
    id <LDSDKAuthService> authService = [[LDSDKManager share] authService:socialPlatform];
    [authService authPlatformCallback:callBack ext:nil];
}

@end

