//
// Created by majiancheng on 2018/6/13.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "MCSocialPlatformDto.h"


@implementation MCSocialPlatformDto

- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.dtoId = value;
    }
}
@end