//
// Created by majiancheng on 2018/8/18.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCShareConfig.h"
#import "LDSDKManager.h"
#import "LDSDKShareService.h"

@class MCShareDto;


@interface MCShareHelper : NSObject

+ (void)shareCommenShareDto:(MCShareDto *)shareDto callBack:(void (^)(BOOL success, NSError *error))successBlock;

@end