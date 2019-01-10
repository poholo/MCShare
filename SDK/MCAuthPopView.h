//
// Created by majiancheng on 2019/1/10.
// Copyright (c) 2019 majiancheng. All rights reserved.
//

#import "MMPopupView.h"

#import <LDSDKManager/LDSDKAuthService.h>


@interface MCAuthPopView : MMPopupView

- (void)showWithCallBack:(LDSDKAuthCallback)authCallback;

@end