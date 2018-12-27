//
//  GCD
//  Reservation
//
//  Created by 江明 赵 on 8/25/14.
//  Copyright (c) 2014 江明 赵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDGroup : NSObject

@property(strong, nonatomic, readonly) dispatch_group_t dispatchGroup;

#pragma 初始化

- (instancetype)init;

#pragma mark - 用法

- (void)enter;

- (void)leave;

- (void)wait;

- (BOOL)wait:(int64_t)delta;

- (void)notify:(dispatch_block_t)block;

@end
