//
// Created by majiancheng on 2019/1/10.
// Copyright (c) 2019 majiancheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MCSocialPlatformDto;


@interface MCAuthDataVM : NSObject


@property(nonatomic, strong) NSMutableArray<MCSocialPlatformDto *> *dataList;

- (void)refresh;

- (void)reqAuthPlatforms:(void (^)(NSArray <MCSocialPlatformDto *> *))callBack;

@end