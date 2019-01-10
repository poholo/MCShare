//
// Created by majiancheng on 2018/12/27.
// Copyright (c) 2018 majiancheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CateDto;


@interface RootDataVM : NSObject

@property(nonatomic, strong) NSMutableArray <CateDto *> *dataList;

- (void)refresh;

@end