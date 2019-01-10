//
// Created by majiancheng on 2018/12/27.
// Copyright (c) 2018 majiancheng. All rights reserved.
//

#import "RootDataVM.h"
#import "CateDto.h"
#import "ShareListController.h"
#import "MCAuthDemoController.h"


@implementation RootDataVM

- (void)refresh {
    [self.dataList removeAllObjects];
    {
        CateDto *cateDto = [CateDto new];
        cateDto.name = @"弹出卡片样式";
        cateDto.targetClass = [ShareListController class];
        [self.dataList addObject:cateDto];
    }
    {
        CateDto *cateDto = [CateDto new];
        cateDto.name = @"文章固定样式";
        cateDto.targetClass = [ShareListController class];
        [self.dataList addObject:cateDto];
    }
    {
        CateDto *cateDto = [CateDto new];
        cateDto.name = @"授权Auth";
        cateDto.targetClass = [MCAuthDemoController class];
        [self.dataList addObject:cateDto];
    }
}


#pragma mark -

- (NSMutableArray<CateDto *> *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}


@end