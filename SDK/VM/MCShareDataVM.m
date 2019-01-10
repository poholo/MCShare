//
// Created by majiancheng on 2018/6/13.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "MCShareDataVM.h"

#import <TencentOpenAPI/QQApiInterface.h>

#import "MCShareDto.h"
#import "WXApi.h"
#import "MCSocialPlatformDto.h"
#import "NSObject+ShareApi.h"

@interface MCShareDataVM ()

@property(nonatomic, strong) NSMutableArray<MCSocialPlatformDto *> *supportPlatforms;

@end

@implementation MCShareDataVM

- (void)parseSupportPlatform {
    if (self.supportPlatforms.count > 0)
        return;
    MCShareItemsCallBack callBack = [MCSocialManager share].shareItemsCallBack;
    if (callBack) {
        NSDictionary *dictionary = callBack();
        NSArray *datas = dictionary[DATA_CONTENT][@"data"];
        for (NSDictionary *item in datas) {
            MCSocialPlatformDto *dto = [MCSocialPlatformDto createDto:item];
            [self.supportPlatforms addObject:dto];
        }
    }
}

- (void)refresh {
    [self.dataList removeAllObjects];
    [self parseSupportPlatform];

    for (MCSocialPlatformDto *platformDto in self.supportPlatforms) {
        LDSDKPlatformType platform = platformDto.platform;
        if (platform == LDSDKPlatformWeChat) {
            if (!([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi])) continue;
        } else if (platform == LDSDKPlatformQQ) {
            if (!([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi])) continue;
        }
        if (![self limitHide:platformDto]) {
            [self.dataList addObject:platformDto];
        }
    }


}

- (void)shareHost:(void (^)(BOOL success))shareCallBack {
    __weak typeof(self) weakSelf = self;
    [self apiGetShareHost:@"" callBack:^(BOOL success, NSDictionary *dict) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSDictionary *dataDict = dict[@"data"];
        [MCSocialManager share].shareDynamicDto = [MCShareDynamicDto createDto:dataDict];
        strongSelf.shareDto.title = strongSelf.shareDto.title ?: [MCSocialManager share].shareDynamicDto.title;
        strongSelf.shareDto.desc = strongSelf.shareDto.desc ?: [MCSocialManager share].shareDynamicDto.desc;
        if (shareCallBack) {
            shareCallBack(success);
        }
    }];
}

- (BOOL)limitHide:(MCSocialPlatformDto *)dto {
    return NO;
}

- (NSMutableArray<MCSocialPlatformDto *> *)supportPlatforms {
    if (!_supportPlatforms) {
        _supportPlatforms = [NSMutableArray new];
    }
    return _supportPlatforms;
}


#pragma mark - getter

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}


@end
