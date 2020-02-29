//
//  MCSharePopView.h
//  MCShare
//
//  Created by majiancheng on 16/11/30.
//  Copyright © 2016年 poholo inc. All rights reserved.
//


#import "MMPopupView.h"

@class MCShareDto;

#define kShareAction2Copy 99
#define kShareAction2System 98
#define kShareActionUnknow 97
#define kShareErrorObj @"share_error_obj"
#define kSharePlatformObj @"share_platform_obj"


@interface MCSharePopView : MMPopupView

- (void)show NS_UNAVAILABLE;

- (void)shareCommenShareDto:(MCShareDto *)shareDto;


@end
