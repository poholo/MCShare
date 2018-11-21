//
//  SocialLoginHelper.h
//  WaQuVideo
//
//  Created by majiancheng on 16/11/30.
//  Copyright © 2016年 poholo inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SocialShareConfig.h"


typedef void (^OauthResult)(NSDictionary * userInfo, NSError * error);

@interface SocialLoginHelper : NSObject

+ (void)resgister;

+ (void)loginType:(SocialPlatform)socialPlatform callback:(OauthResult)callback;

@end
