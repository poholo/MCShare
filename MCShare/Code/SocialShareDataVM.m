//
// Created by majiancheng on 2018/6/13.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "SocialShareDataVM.h"

#import <TencentOpenAPI/QQApiInterface.h>
#import <ReactiveCocoa.h>

#import "SocialShareConfig.h"
#import "ShareDto.h"
#import "WXApi.h"
#import "SocialPlatformDto.h"
#import "NSString+URLEncoded.h"
#import "NSObject+ShareApi.h"
#import "ShareHelper.h"
#import "SocialShareHelper.h"
#import "StringUtils.h"

@interface SocialShareDataVM ()

@property(nonatomic, strong) NSMutableArray<SocialPlatformDto *> *supportPlatforms;

@end

@implementation SocialShareDataVM

- (void)parseSupportPlatform {
    if (self.supportPlatforms.count > 0)
        return;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SharePlatform" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *item in dictionary[@"data"]) {
        SocialPlatformDto *dto = [SocialPlatformDto createDto:item];
        [self.supportPlatforms addObject:dto];
    }
}

- (void)refresh {
    [self.dataList removeAllObjects];
    [self parseSupportPlatform];

    for (SocialPlatformDto *platformDto in self.supportPlatforms) {
        SocialPlatform platform = platformDto.platform;
        if (platform == SocialPlatformWeChat || platform == SocialPlatformWeChatFriend) {
            if (!([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi])) continue;
        } else if (platform == SocialPlatformQQ || platform == SocialPlatformQQZone) {
            if (!([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi])) continue;
        }
        if (![self limitHide:platformDto]) {
            [self.dataList addObject:platformDto];
        }
    }


}

- (RACSignal *)shareHost {
    RACSignal *signal = [self apiGetShareHost: @"10"];

    @weakify(self);
    return [signal map:^id(id value) {
        @strongify(self);
        [SocialShareConfig share].shareDynamicDto = [ShareDynamicDto createDto:value];
        self.shareDto.title = self.shareDto.title ?: [SocialShareConfig share].shareDynamicDto.title;
        self.shareDto.desc = self.shareDto.desc ?: [SocialShareConfig share].shareDynamicDto.desc;
        return nil;
    }];
}

- (BOOL)limitHide:(SocialPlatformDto *)dto {
    if (self.shareDto.sourceDto == nil) {
        if (dto.platform == SocialPlatformDel) {
            return YES;
        } else if (dto.platform == SocialPlatformReport) {
            return YES;
        }
    } else {
        if (dto.platform == SocialPlatformDel) {
            return YES;
        }
    }
    return NO;
}

- (NSMutableArray<SocialPlatformDto *> *)supportPlatforms {
    if (!_supportPlatforms) {
        _supportPlatforms = [NSMutableArray new];
    }
    return _supportPlatforms;
}

- (LDSDKPlatformType)platform:(SocialPlatform)platform {
    return [SocialShareHelper platform:platform];
}


- (LDSDKShareToModule)shareType:(SocialPlatform)platform {
    return [SocialShareHelper shareType:platform];
}


- (BOOL)share2Telegram {
    NSURL *schema = [NSURL URLWithString:@"tg://"];
    NSString *text = [StringUtils hasText:self.shareDto.pasteText] ? self.shareDto.pasteText : self.shareDto.title;
    NSString *url = [NSString stringWithFormat:@"tg://msg_url?text=%@&url=%@", [text urlEncode], [self.shareDto.shareUrl urlEncode]];

    BOOL success = [ShareHelper action2Telegram:[NSURL URLWithString:url] schema:schema];
    return success;
}

#pragma mark - getter
- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}



@end
