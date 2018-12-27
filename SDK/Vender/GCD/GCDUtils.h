//
// Created by 赵江明 on 2016/10/8.
// Copyright (c) 2016 poholo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GCDUtils : NSObject

void runOnMainThread(void (^block)(void));

@end