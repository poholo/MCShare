//
// Created by Jiangmingz on 2018/6/11.
// Copyright (c) 2018 挖趣智慧科技（北京）有限公司. All rights reserved.
//

#import "DeviceUtils.h"

#import <SDVersion/SDVersion.h>

@implementation DeviceUtils

+ (BOOL)iPhoneX {
    return [SDiOSVersion deviceVersion] == iPhoneX
            || [SDiOSVersion deviceVersion] == iPhoneXR
            || [SDiOSVersion deviceVersion] == iPhoneXS
            || [SDiOSVersion deviceVersion] == iPhoneXSMax;
}

+ (CGFloat)xTop {
    if ([DeviceUtils iPhoneX]) {
        return 24.0f;
    }

    return 0.0f;
}

+ (CGFloat)xBottom {
    if ([DeviceUtils iPhoneX]) {
        return 34.0f;
    }

    return 0.0f;
}

+ (CGFloat)xStatusBarHeight {
    if ([DeviceUtils iPhoneX]) {
        return 24.0f + 20.0f;
    }

    return 20.0f;
}

+ (CGFloat)xNavBarHeight {
    if ([DeviceUtils iPhoneX]) {
        return 44.0f + 44.0f;
    }

    return 20.0f + 44;
}

+ (CGFloat)xTabBarHeight {
    if ([DeviceUtils iPhoneX]) {
        return 49.0f + 34.0f;
    }

    return 49;
}

+ (CGFloat)xVideoLeftRight {
    if ([DeviceUtils iPhoneX]) {
        return ([DeviceUtils xMax] - [DeviceUtils xVideoLandscapeWidth]) * 0.5f;
    }

    return 0.0f;
}

//竖屏高度
+ (CGFloat)xVideoPortraitHeight {
    return [DeviceUtils xMax] - [DeviceUtils xTop] - [DeviceUtils xBottom];
}

//横屏宽度
+ (CGFloat)xVideoLandscapeWidth {
    return (16.0f * [DeviceUtils xMin]) / 9.0f;
}

+ (CGFloat)xMin {
    CGFloat w = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat h = CGRectGetHeight([UIScreen mainScreen].bounds);
    return MIN(h, w);
}

+ (CGFloat)xMax {
    CGFloat w = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat h = CGRectGetHeight([UIScreen mainScreen].bounds);
    return MAX(h, w);
}

+ (CGFloat)xProgress {
    if ([DeviceUtils iPhoneX]) {
        return 8.0f;
    }

    return 0.0f;
}

+ (BOOL)showSpecialAnimate {
    return NO;
}


@end
