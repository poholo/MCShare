//
// Created by 赵江明 on 2016/10/8.
// Copyright (c) 2016 poholo Inc. All rights reserved.
//

#import "GCDUtils.h"
#import "GCDQueue.h"


@implementation GCDUtils

void runOnMainThread(void (^block)(void)) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        [GCDQueue executeInMainQueue:block];
    }
}


@end