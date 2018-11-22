//
// Created by majiancheng on 2018/6/13.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "Dto.h"

#import "MCShareConfig.h"

@interface SocialPlatformDto : Dto

@property(nonatomic, assign) SocialPlatform platform;
@property(nonatomic, copy) NSString *image;
@property(nonatomic, copy) NSString *name;

@end
