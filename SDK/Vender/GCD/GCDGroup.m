//
//  GCD
//  Reservation
//
//  Created by 江明 赵 on 8/25/14.
//  Copyright (c) 2014 江明 赵. All rights reserved.
//
#import "GCDGroup.h"

@interface GCDGroup ()

@property(strong, nonatomic, readwrite) dispatch_group_t dispatchGroup;

@end

@implementation GCDGroup

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dispatchGroup = dispatch_group_create();
    }

    return self;
}

- (void)enter {
    dispatch_group_enter(self.dispatchGroup);
}

- (void)leave {
    dispatch_group_leave(self.dispatchGroup);
}

- (void)wait {
    dispatch_group_wait(self.dispatchGroup, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(int64_t)delta {
    return dispatch_group_wait(self.dispatchGroup, dispatch_time(DISPATCH_TIME_NOW, delta)) == 0;
}

- (void)notify:(dispatch_block_t)block {
    dispatch_group_notify(self.dispatchGroup, dispatch_get_main_queue(), block);
}

@end
