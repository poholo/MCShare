//
//  GCD
//  Reservation
//
//  Created by 江明 赵 on 8/25/14.
//  Copyright (c) 2014 江明 赵. All rights reserved.
//

#import "GCDReTimer.h"
#import "GCDQueue.h"

@implementation GCDReTimer

- (id)initTimerAt:(dispatch_time_t)beginningTime
      repeatEvery:(dispatch_time_t)repeatTime
        withQueue:(GCDQueue *)queue
        doingTask:(void (^)())task {
    if (self = [super init]) {
        timer = [GCDReTimer timerBeginAt:beginningTime repeatEvery:repeatTime withQueue:queue doing:task];
        state = YES;
    }
    return self;
}

+ (dispatch_source_t)timerBeginAt:(dispatch_time_t)beginningTime repeatEvery:(dispatch_time_t)repeatTime withQueue:(GCDQueue *)queue doing:(void (^)())job {
    BOOL jobOnce = NO;
    if (repeatTime == 0) {
        repeatTime = 2ull * NSEC_PER_SEC;
        jobOnce = YES;
    }

    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0));
    dispatch_source_set_timer(_timer, beginningTime, repeatTime, 0);
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(queue.dispatchQueue, ^{
            if (jobOnce) {
                if (_timer)
                    dispatch_suspend(_timer);
            }
            job();
        });
    });

    dispatch_resume(_timer);
    job = nil;
    return _timer;
}

- (void)startTimer {
    if (!state) {
        dispatch_resume(timer);
        state = YES;
    }
}

- (void)stopTimer {
    if (state) {
        dispatch_suspend(timer);
        state = NO;
    }
}

- (BOOL)timerState {
    return state;
}

@end