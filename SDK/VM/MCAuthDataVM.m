//
// Created by majiancheng on 2019/1/10.
// Copyright (c) 2019 majiancheng. All rights reserved.
//

#import "MCAuthDataVM.h"
#import "MCSocialPlatformDto.h"


@implementation MCAuthDataVM

- (void)refresh {
    [self.dataList removeAllObjects];
}

- (void)reqAuthPlatforms:(void (^)(NSArray <MCSocialPlatformDto *> *))callBack {
    MCSocialAuthItemsCallBack socialAuthItemsCallBack = [MCSocialManager share].socialAuthItemsCallBack;
    if (socialAuthItemsCallBack) {
        NSDictionary *dictionary = socialAuthItemsCallBack();
        NSArray *datas = dictionary[DATA_CONTENT][@"data"];
        for (NSDictionary *item in datas) {
            MCSocialPlatformDto *dto = [MCSocialPlatformDto createDto:item];
            [self.dataList addObject:dto];
        }
        if (callBack) {
            callBack(self.dataList);
        }
    }
}


- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}

@end