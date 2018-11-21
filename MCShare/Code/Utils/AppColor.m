//
// Created by majiancheng on 2017/8/2.
// Copyright (c) 2017 poholo inc. All rights reserved.
//

#import "AppColor.h"
#import "UIColor+Extend.h"


@implementation AppColor

+ (UIColor *)colorI {
    return [UIColor colorWithHexInt:0x333333];
}

+ (UIColor *)colorII {
    return [UIColor colorWithHexInt:0x666666];
}

+ (UIColor *)colorIII {
    return [UIColor colorWithHexInt:0x999999];
}

+ (UIColor *)colorIV {
    return [UIColor colorWithHexInt:0xcacaca];
}

+ (UIColor *)colorV {
    return [UIColor colorWithHexInt:0xf7f7f9];
}

+ (UIColor *)colorVI {
    return [UIColor colorWithHexInt:0xdedede];
}

+ (UIColor *)colorVII {
    return [UIColor colorWithHexInt:0x76bdff];
}

+ (UIColor *)colorVIII {
    return [UIColor colorWithHexInt:0xffbc1c];
}

+ (UIColor *)colorIX {
    return [UIColor colorWithHexInt:0x7789a8];
}

+ (UIColor *)colorX {
    return [UIColor colorWithHexInt:0xebf2fa];
}

+ (UIColor *)colorXI {
    return [UIColor colorWithHexInt:0x30c84d];
}

+ (UIColor *)colorXII {
    return [UIColor colorWithHexInt:0xff6d69];
}

+ (UIColor *)colorXIII {
    return [UIColor colorWithHexInt:0x33BFFF];
}

+ (UIColor *)randomImageColor {
    static dispatch_once_t once_t;
    static NSMutableArray *randomColors;
    dispatch_once(&once_t, ^{
        randomColors = [NSMutableArray array];
        [randomColors addObject:[UIColor colorWithHexInt:0x77B2CF]];
        [randomColors addObject:[UIColor colorWithHexInt:0x7EA3B0]];
        [randomColors addObject:[UIColor colorWithHexInt:0xA99DCA]];
        [randomColors addObject:[UIColor colorWithHexInt:0x7F9DC1]];
        [randomColors addObject:[UIColor colorWithHexInt:0x98CAAE]];
        [randomColors addObject:[UIColor colorWithHexInt:0xE2D0EB]];
    });

    return randomColors[arc4random() % 6];
}

@end
