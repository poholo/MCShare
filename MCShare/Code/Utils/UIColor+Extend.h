//
// Created by Jiangmingz on 2017/3/16.
// Copyright (c) 2017 poholo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface UIColor (Extend)

+ (UIColor *)randomColor;

+ (instancetype)r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b alphaComponent:(CGFloat)alpha;

+ (instancetype)r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b;

+ (instancetype)r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b a:(uint8_t)a;

+ (instancetype)rgba:(NSUInteger)rgba;

+ (instancetype)colorWithHexInt:(NSUInteger)rgbValue;

+ (instancetype)colorWithHexInt:(NSUInteger)rgbValue alpha:(CGFloat)alpha;

+ (instancetype)colorWithHexString:(NSString *)hexString;

- (NSUInteger)rgbaValue;

- (UIImage *)colorImage;

@end
