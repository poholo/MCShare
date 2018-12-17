//
// Created by majiancheng on 2018/12/17.
// Copyright (c) 2018 majiancheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShareItem;


@interface ShareListDataVM : NSObject

@property(nonatomic, strong) NSMutableArray<ShareItem *> *dataList;

@property(nonatomic, assign) NSInteger selectIdx;

- (void)refresh;

@end