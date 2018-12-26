//
// Created by majiancheng on 2018/6/13.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "LDSDKManager.h"

#import "MCShareConfig.h"
#import "LDSDKShareService.h"

@class MCShareDto;

@interface MCShareDataVM : NSObject
@property(nonatomic, strong) NSMutableArray *dataList;
@property(nonatomic, strong) NSNumber *currentPos;

- (void)refresh;

@property(nonatomic, strong) MCShareDto *shareDto;

- (void)shareHost:(void (^)(BOOL success))shareCallBack;

@end
