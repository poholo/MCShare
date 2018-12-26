//
//  NSObject+ShareApi.m
//  Bull
//
//  Created by majiancheng on 2018/7/14.
//  Copyright © 2018年 poholo Inc. All rights reserved.
//

#import "NSObject+ShareApi.h"

#import <LDSDKManager/LDSDKConfig.h>

#import "MCShareConfig.h"

@implementation NSObject (ShareApi)

- (void)apiGetShareHost:(NSString *)type callBack:(void (^)(BOOL success, NSDictionary *dict))callBack {
    MCDynamicHostCallback dynamicHostCallback = [MCShareConfig share].dynamicHostCallback;
    if (dynamicHostCallback) {
        NSDictionary *dictionary = dynamicHostCallback(type);
        if (callBack) {
            callBack([dictionary[DATA_STATUS] boolValue], dictionary[DATA_CONTENT]);
        }
    } else {
        LDLog(@"[MCShare][ShareApi] callback == nil")
    }
}

@end
