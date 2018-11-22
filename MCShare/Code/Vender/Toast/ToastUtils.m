//
// Created by Jiangmingz on 15/12/31.
// Copyright (c) 2015 poholo Inc. All rights reserved.
//


#import "ToastUtils.h"

#import "UIView+Toast.h"
#import "MMPopupWindow.h"
#import "MCShareColor.h"

@implementation ToastUtils

+ (UIView *)keyWindowView {
    UIView *attachView = [MMPopupWindow sharedWindow].attachView;
    if (![MMPopupWindow sharedWindow].hidden) {
        NSArray<__kindof UIView *> *subviews = [attachView subviews];
        if ([subviews count] > 0) {
            __kindof UIView *view = [subviews lastObject];
            if (!view.hidden && view.alpha > 0.0f) {
                return view;
            }
        }
    }

    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if (!window) {
        window = [UIApplication sharedApplication].keyWindow;
    }

    return window;
}

+ (void)showTitle:(NSString *)title {
    [[self keyWindowView] makeToast:title];
}

+ (void)showOnTabTopTitle:(NSString *)title {
    [[self keyWindowView] makeToast:title duration:2.0 position:CSToastPositionTabBottom];
}

+ (void)showTopTitle:(NSString *)title {
    [[self keyWindowView] makeToast:title duration:2.0 position:CSToastPositionTop];
}

+ (void)showCenterTitle:(NSString *)title {
    [[self keyWindowView] makeToast:title duration:2.0 position:CSToastPositionCenter];
}

+ (void)showGrayTop:(NSString *)title {
    UIView *toastView = [[self keyWindowView] makeToast:title duration:2.0 position:CSToastPositionTop];
    toastView.backgroundColor = [MCShareColor colorII];
}

+ (void)showGrayCenter:(NSString *)title {
    UIView *toastView = [[self keyWindowView] makeToast:title duration:2.0 position:CSToastPositionCenter];
    toastView.backgroundColor = [MCShareColor colorII];
}

@end
