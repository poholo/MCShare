//
// Created by Jiangmingz on 2017/3/16.
// Copyright (c) 2017 挖趣智慧科技（北京）有限公司. All rights reserved.
//

#import "UIView+Extend.h"


@implementation UIView (Extend)

- (CGFloat)mm_x {
    return self.frame.origin.x;
}

- (void)setMm_x:(CGFloat)x {
    self.frame = CGRectMake(x, [self mm_y], [self mm_width], [self mm_height]);
}

- (CGFloat)mm_y {
    return self.frame.origin.y;
}

- (void)setMm_y:(CGFloat)y {
    self.frame = CGRectMake([self mm_x], y, [self mm_width], [self mm_height]);
}

- (CGFloat)mm_width {
    return self.frame.size.width;
}

- (void)setMm_width:(CGFloat)width {
    self.frame = CGRectMake([self mm_x], [self mm_y], width, [self mm_height]);
}

- (CGFloat)mm_height {
    return self.frame.size.height;
}

- (void)setMm_height:(CGFloat)height {
    self.frame = CGRectMake([self mm_x], [self mm_y], [self mm_width], height);
}

- (CGFloat)mm_left {
    return self.frame.origin.x;
}

- (void)setMm_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)mm_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setMm_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)mm_top {
    return self.frame.origin.y;
}

- (void)setMm_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)mm_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setMm_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)mm_centerX {
    return self.center.x;
}

- (void)setMm_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)mm_centerY {
    return self.center.y;
}

- (void)setMm_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)mm_origin {
    return self.frame.origin;
}

- (void)setMm_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)mm_size {
    return self.frame.size;
}

- (void)setMm_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (UIView*)subViewOfClassName:(NSString*)className {
    for (UIView* subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        
        UIView* resultFound = [subView subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}


@end
