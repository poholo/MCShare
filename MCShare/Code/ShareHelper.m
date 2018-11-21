//
// Created by majiancheng on 2018/7/21.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "ShareHelper.h"

#import <ReactiveCocoa.h>


@implementation ShareHelper

+ (BOOL)action2Telegram:(NSURL *)URL schema:(NSURL *)schema {
    __block BOOL isOpen = NO;
    __block BOOL isFinish = NO;
    if ([UIDevice currentDevice].systemName.floatValue > 10) {
        @weakify(self);
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:^(BOOL success) {
            @strongify(self);
            isOpen = success;
            isFinish = YES;
            if (!isOpen) {
                [ShareHelper openGroup];
            }
        }];

    } else {
        isOpen = [[UIApplication sharedApplication] openURL:URL];
        isFinish = YES;
        if (!isOpen) {
            [ShareHelper openGroup];
        }
    }
    while (!isFinish) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
    return isOpen;
}


+ (void)openGroup {
    NSURL *URL = [NSURL URLWithString:@"https://0.plus/firebull"];
    if ([UIDevice currentDevice].systemName.floatValue > 10) {
        @weakify(self);
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:^(BOOL success) {
            @strongify(self);
        }];

    } else {
        [[UIApplication sharedApplication] openURL:URL];
    }
}
@end