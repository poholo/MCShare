//
// Created by majiancheng on 2018/6/13.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "MCShareConfig.h"

#import "MCShareDto.h"
#import "MMShareConfigDto.h"

NSString *const DATA_STATUS = @"success";
NSString *const DATA_CONTENT = @"data";

@implementation MCShareConfig

+ (instancetype)share {
    static dispatch_once_t predicate;
    static MCShareConfig *instance;
    dispatch_once(&predicate, ^{
        instance = [MCShareConfig new];
    });
    return instance;
}

- (NSURL *)shareURLHost {
    NSURL *URL = [NSURL URLWithString:self.shareDynamicDto.host];
    return URL;
}

- (ShareDynamicDto *)shareDynamicDto {
    if (!_shareDynamicDto) {
        _shareDynamicDto = [ShareDynamicDto defaultShareDto];
    }
    return _shareDynamicDto;
}

@end
