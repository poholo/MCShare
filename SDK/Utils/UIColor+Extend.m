//
// Created by Jiangmingz on 2017/3/16.
// Copyright (c) 2017 poholo Inc. All rights reserved.
//

#import "UIColor+Extend.h"


@implementation UIColor (Extend)

+ (UIColor *)randomColor {
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}

+ (instancetype)r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b alphaComponent:(CGFloat)alpha {
    return [[self r:r g:g b:b] colorWithAlphaComponent:alpha];
}

+ (instancetype)r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b {
    return [self r:r g:g b:b a:0xff];
}

+ (instancetype)r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b a:(uint8_t)a {
    return [self colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:a / 255.f];
}

+ (instancetype)rgba:(NSUInteger)rgba {
    return [self r:(uint8_t) ((rgba >> 24) & 0xFF)
                 g:(uint8_t) ((rgba >> 16) & 0xFF)
                 b:(uint8_t) ((rgba >> 8) & 0xFF)
                 a:(uint8_t) (rgba & 0xFF)];
}

+ (instancetype)colorWithHexInt:(NSUInteger)rgbValue {
    return [UIColor colorWithRed:(CGFloat) (((float) ((rgbValue & 0xFF0000) >> 16)) / 255.0)
                           green:(CGFloat) (((float) ((rgbValue & 0xFF00) >> 8)) / 255.0)
                            blue:(CGFloat) (((float) (rgbValue & 0xFF)) / 255.0)
                           alpha:1.0];
}

+ (instancetype)colorWithHexInt:(NSUInteger)rgbValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(CGFloat) (((float) ((rgbValue & 0xFF0000) >> 16)) / 255.0)
                           green:(CGFloat) (((float) ((rgbValue & 0xFF00) >> 8)) / 255.0)
                            blue:(CGFloat) (((float) (rgbValue & 0xFF)) / 255.0)
                           alpha:alpha];
}
+ (instancetype)colorWithHexString:(NSString *)hexString {
    if (!hexString)
        return nil;

    NSString *hex = [NSString stringWithString:hexString];
    if ([hex hasPrefix:@"#"])
        hex = [hex substringFromIndex:1];

    if (hex.length == 6)
        hex = [hex stringByAppendingString:@"FF"];
    else if (hex.length != 8)
        return nil;

    uint32_t rgba;
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    [scanner scanHexInt:&rgba];
    return [UIColor rgba:rgba];
}

- (NSUInteger)rgbaValue {
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a]) {
        NSUInteger rr = (NSUInteger) (r * 255 + 0.5);
        NSUInteger gg = (NSUInteger) (g * 255 + 0.5);
        NSUInteger bb = (NSUInteger) (b * 255 + 0.5);
        NSUInteger aa = (NSUInteger) (a * 255 + 0.5);

        return (rr << 24) | (gg << 16) | (bb << 8) | aa;
    } else {
        return 0;
    }
}

- (UIImage *)colorImage {
    CGRect frame = CGRectMake(0.0f, 0.0f, 0.5f, 0.5f);
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, frame);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
