//
//  MCAuthHelper.h
//  MCShare
//
//  Created by majiancheng on 16/11/30.
//  Copyright © 2016年 poholo inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <LDSDKManager/LDSDKConfig.h>
#import <LDSDKManager/LDSDKAuthService.h>

#import "MCSocialManager.h"


@interface MCAuthHelper : NSObject

+ (void)auth:(LDSDKPlatformType)socialPlatform callBack:(LDSDKAuthCallback)callBack;

@end
