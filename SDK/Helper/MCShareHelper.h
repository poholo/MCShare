//
// Created by majiancheng on 2018/8/18.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCSocialManager.h"
#import "LDSDKManager.h"
#import "LDSDKShareService.h"

@class MCShareDto;


@interface MCShareHelper : NSObject
/**
 * callback 用MCShareDto.shareCallback
 */
+ (void)shareCommenShareDto:(MCShareDto *)shareDto;

@end