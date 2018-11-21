//
//  GCD
//  Reservation
//
//  Created by 江明 赵 on 8/25/14.
//  Copyright (c) 2014 江明 赵. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GCDQueue;

@interface GCDTimer : NSObject

@property(strong, readonly, nonatomic) dispatch_source_t dispatchSource;

#pragma 初始化

- (instancetype)init;

- (instancetype)initInQueue:(GCDQueue *)queue;

#pragma mark - 用法

- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval;

- (void)event:(dispatch_block_t)block timeIntervalWithSecs:(float)secs;

- (void)start;

- (void)destroy;

@end
