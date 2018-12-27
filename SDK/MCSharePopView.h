//
//  MCSharePopView.h
//  WaQuVideo
//
//  Created by majiancheng on 16/11/30.
//  Copyright © 2016年 poholo inc. All rights reserved.
//


#import "MMPopupView.h"

@class MCShareDto;

@interface MCSharePopView : MMPopupView

- (void)show NS_UNAVAILABLE;

- (void)shareCommenShareDto:(MCShareDto *)shareDto;


@end
