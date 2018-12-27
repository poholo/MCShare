//
// Created by 赵江明 on 15/11/13.
// Copyright (c) 2015 SunYuanYang. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

+ (BOOL)hasText:(NSString *)text {
    if (![text isKindOfClass:[NSString class]]) {
        return NO;
    }
    return [[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] != 0;
}

@end
