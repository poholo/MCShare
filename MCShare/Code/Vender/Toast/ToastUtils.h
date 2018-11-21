//
// Created by Jiangmingz on 15/12/31.
// Copyright (c) 2015 poholo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface ToastUtils : NSObject

+ (void)showTitle:(NSString *)title;

+ (void)showOnTabTopTitle:(NSString *)title;

+ (void)showTopTitle:(NSString *)title;

+ (void)showCenterTitle:(NSString *)title;

+ (void)showGrayCenter:(NSString *)title;

+ (void)showGrayTop:(NSString *)title;

@end
