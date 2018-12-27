//
//  GCD
//  Reservation
//
//  Created by 江明 赵 on 8/25/14.
//  Copyright (c) 2014 江明 赵. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GCDQueue;

/**
 GCD timer class — added to be easily embedded in collections class. As a general
 rule, to not fall in compromise state, use the method to handle the timer. Some
 behavior with the suspend/resume/cancel state for dispatch source are clearly
 undefine.
 */
@interface GCDReTimer : NSObject {
    dispatch_source_t timer;
    BOOL state;
}

/**
 Init the timer and launch the timer.
 
 @param beginningTime when to start the timer. With a zero (or now) value, will
 execute immediately the block.
 @param repeatTime when to repeat it.
 @param queue on which queue to execute this timer. Accept serial and concurrent queue
 @param task the block which will be executed
 @return self
 */
- (id)initTimerAt:(dispatch_time_t)beginningTime
      repeatEvery:(dispatch_time_t)repeatTime
        withQueue:(GCDQueue *)queue
        doingTask:(void (^)())task;


/**
 Will initialize a simple timer the GCD way.
 Timer is started after being created, and is always put on the DISPATCH_QUEUE_PRIORITY_HIGH

 @param beginningTime when to start the timer. With a zero (or now) value, will
 execute immediately the block.
 @param repeatTime when to repeat it. With a value of 0 it will cancel itself to prevent unwanted loop
 @param queue on which queue to execute this timer. Accept serial and concurrent queue, but will always be executed with dispatch_async;
 @param job the block which will be executed
 @return the initialized timer
 */
+ (dispatch_source_t)timerBeginAt:(dispatch_time_t)beginningTime repeatEvery:(dispatch_time_t)repeatTime withQueue:(GCDQueue *)queue doing:(void (^)())job;

/**
 Start the timer.
 */
- (void)startTimer;

/**
 Stop the timer.
 */
- (void)stopTimer;

/**
 Return the state of the timer, activated or not
 */
- (BOOL)timerState;

@end
