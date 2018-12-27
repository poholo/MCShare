//
//  GCD
//  Reservation
//
//  Created by 江明 赵 on 8/25/14.
//  Copyright (c) 2014 江明 赵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDSemaphore : NSObject

@property(strong, readonly, nonatomic) dispatch_semaphore_t dispatchSemaphore;

#pragma 初始化

- (instancetype)init;

- (instancetype)initWithValue:(long)value;

#pragma mark - 用法

- (BOOL)signal;

- (void)wait;

- (BOOL)wait:(int64_t)delta;

@end
