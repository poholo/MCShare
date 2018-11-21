//
// Created by majiancheng on 2017/8/2.
// Copyright (c) 2017 poholo inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIColor;

/***
 * 通用颜色
 */
@interface AppColor : UIColor

/***
 * 字体色 - 主要
 */
+ (UIColor *)colorI;

/***
 * 字体色 - 次要II
 */
+ (UIColor *)colorII;

/***
 * 字体色 - 次要III
 */
+ (UIColor *)colorIII;

/***
 * 字体色 - 提示性文字
 */
+ (UIColor *)colorIV;

/***
 * 背景 - 分行&底色
 */
+ (UIColor *)colorV;

/***
 * 分割线
 */
+ (UIColor *)colorVI;


/***
 * 主色 - 蓝
 */
+ (UIColor *)colorVII;

/***
 * 主色 - 黄
 */
+ (UIColor *)colorVIII;

/***
 * 副主色 - 深灰色
 */
+ (UIColor *)colorIX;

/**
 * 副主色 - 浅灰色
 */
+ (UIColor *)colorX;

/**
 * 副主色 - 浅绿色
 */
+ (UIColor *)colorXI;

/**
 * 副主色 - 浅红色
 */
+ (UIColor *)colorXII;

/**
 * 宝蓝色
 */
+ (UIColor *)colorXIII;

+ (UIColor *)randomImageColor;

@end
