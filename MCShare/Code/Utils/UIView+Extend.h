//
// Created by Jiangmingz on 2017/3/16.
// Copyright (c) 2017 挖趣智慧科技（北京）有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface UIView (Extend)

@property(nonatomic, assign) CGFloat mm_x;
@property(nonatomic, assign) CGFloat mm_y;
@property(nonatomic, assign) CGFloat mm_width;
@property(nonatomic, assign) CGFloat mm_height;
@property(nonatomic, assign) CGFloat mm_right;
@property(nonatomic, assign) CGFloat mm_left;
@property(nonatomic, assign) CGFloat mm_top;
@property(nonatomic, assign) CGFloat mm_bottom;
@property(nonatomic, assign) CGFloat mm_centerX;
@property(nonatomic, assign) CGFloat mm_centerY;
@property(nonatomic, assign) CGPoint mm_origin;
@property(nonatomic, assign) CGSize mm_size;

- (UIView *)subViewOfClassName:(NSString *)className;

@end
