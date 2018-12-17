//
//  MCLoginHelper.h
//  WaQuVideo
//
//  Created by majiancheng on 16/11/30.
//  Copyright © 2016年 poholo inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MCShareConfig.h"
#import "LDSDKConfig.h"


typedef void (^OauthResult)(NSDictionary * userInfo, NSError * error);

@interface MCLoginHelper : NSObject

+ (void)resgister;

+ (void)loginType:(LDSDKPlatformType)socialPlatform callback:(OauthResult)callback;

@end
