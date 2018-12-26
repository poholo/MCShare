//
// Created by majiancheng on 2018/6/13.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "MCShareDataVM.h"

#import <TencentOpenAPI/QQApiInterface.h>
#import <ReactiveCocoa.h>

#import "MCShareDto.h"
#import "WXApi.h"
#import "MCSocialPlatformDto.h"
#import "NSString+URLEncoded.h"
#import "NSObject+ShareApi.h"
#import "MCShareHelper.h"

@interface MCShareDataVM ()

@property(nonatomic, strong) NSMutableArray<MCSocialPlatformDto *> *supportPlatforms;

@end

@implementation MCShareDataVM

- (void)parseSupportPlatform {
    if (self.supportPlatforms.count > 0)
        return;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SharePlatform" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *item in dictionary[@"data"]) {
        MCSocialPlatformDto *dto = [MCSocialPlatformDto createDto:item];
        [self.supportPlatforms addObject:dto];
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
        [MCShareConfig share].shareDynamicDto = [MCShareDynamicDto createDto:dict];
        strongSelf.shareDto.title = strongSelf.shareDto.title ?: [MCShareConfig share].shareDynamicDto.title;
        strongSelf.shareDto.desc = strongSelf.shareDto.desc ?: [MCShareConfig share].shareDynamicDto.desc;
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
