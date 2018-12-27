//
// Created by majiancheng on 2018/6/13.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "MCDto.h"

#import "MCShareConfig.h"
#import "LDSDKConfig.h"

@interface MCSocialPlatformDto : MCDto

@property(nonatomic, assign) LDSDKPlatformType platform;
@property(nonatomic, assign) LDSDKShareToModule module;
@property(nonatomic, copy) NSString *image;
@property(nonatomic, copy) NSString *name;

@end
