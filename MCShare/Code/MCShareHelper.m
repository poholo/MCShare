//
// Created by majiancheng on 2018/8/18.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "MCShareHelper.h"

#import <SDWebImage/SDWebImageManager.h>
#import <ReactiveCocoa.h>

#import "ShareDto.h"
#import "GCDQueue.h"
#import "StringUtils.h"
#import "ToastUtils.h"


@implementation MCShareHelper

+ (void)shareCommenShareDto:(ShareDto *)dto platform:(SocialPlatform)socialPlatform callBack:(void (^)(BOOL success, NSError *error))successBlock {
    if (dto.image && !dto.imgUrl) {
        [self shareCommentAfterGetImageWithSocialPlatform:socialPlatform dto:dto callBack:successBlock];
        return;
    }

    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:dto.imgUrl]];
    UIImage *iMemory = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:key];
    UIImage *iDisk = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    if (iMemory || iDisk) {
        if (iMemory) {
            dto.image = iMemory;
        } else if (iDisk) {
            dto.image = iDisk;
        }
        [MCShareHelper shareCommentAfterGetImageWithSocialPlatform:socialPlatform dto:dto callBack:successBlock];
    } else {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:dto.imgUrl]
                                                              options:0
                                                             progress:nil
                                                            completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                                if (image) {
                                                                    dto.image = image;
                                                                }
                                                                [[self class] shareCommentAfterGetImageWithSocialPlatform:socialPlatform dto:dto callBack:successBlock];
                                                            }];
    }
}

+ (void)shareCommentAfterGetImageWithSocialPlatform:(SocialPlatform)socialPlatform dto:(ShareDto *)shareDto callBack:(void (^)(BOOL success, NSError *error))successBlock {
    [shareDto updateShareURL:socialPlatform];
    [shareDto logProcess:[@([ShareDto target:socialPlatform]) stringValue]];

    shareDto.platform = socialPlatform;
    NSDictionary *param = [shareDto shareDict];
    if (socialPlatform == SocialPlatformLink) {
        UIPasteboard *general = [UIPasteboard generalPasteboard];
        NSString *pasteText = [StringUtils hasText:shareDto.pasteText] ? shareDto.pasteText : param[LDSDKShareContentWapUrlKey];
        [general setString:pasteText];
        [ToastUtils showOnTabTopTitle:@"复制成功"];
    } else {
        [[LDSDKManager getShareService:[MCShareHelper platform:socialPlatform]] shareWithContent:param shareModule:[MCShareHelper shareType:socialPlatform] onComplete:^(BOOL success, NSError *error) {
            [GCDQueue executeInMainQueue:^{
                if (success) {
                    NSString *targat = [NSString stringWithFormat:@"%ld", (long) [ShareDto target:shareDto.platform]];
                    [shareDto logResult:targat];
                }
                if (successBlock) {
                    successBlock(success, error);
                }
            }];
        }];
    }
}

+ (LDSDKPlatformType)platform:(SocialPlatform)platform {
    switch (platform) {
        case SocialPlatformQQ:
            return LDSDKPlatformQQ;
            break;
        case SocialPlatformQQZone:
            return LDSDKPlatformQQ;
            break;
        case SocialPlatformWeiBo:
            return LDSDKPlatformWeibo;
            break;
        case SocialPlatformWeChat:
            return LDSDKPlatformWeChat;
            break;
        case SocialPlatformWeChatFriend:
            return LDSDKPlatformWeChat;
            break;
        default:
            break;
    }
    return LDSDKPlatformQQ;
}


+ (LDSDKShareToModule)shareType:(SocialPlatform)platform {
    switch (platform) {
        case SocialPlatformQQZone:
        case SocialPlatformWeChatFriend:
            return LDSDKShareToTimeLine;
            break;
        default:
            break;
    }
    return LDSDKShareToContact;
}


+ (BOOL)action2Telegram:(NSURL *)URL schema:(NSURL *)schema {
    __block BOOL isOpen = NO;
    __block BOOL isFinish = NO;
    if ([UIDevice currentDevice].systemName.floatValue > 10) {
        @weakify(self);
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:^(BOOL success) {
            @strongify(self);
            isOpen = success;
            isFinish = YES;
            if (!isOpen) {
                [MCShareHelper openGroup];
            }
        }];

    } else {
        isOpen = [[UIApplication sharedApplication] openURL:URL];
        isFinish = YES;
        if (!isOpen) {
            [MCShareHelper openGroup];
        }
    }
    while (!isFinish) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
    return isOpen;
}


+ (void)openGroup {
    NSURL *URL = [NSURL URLWithString:@"https://0.plus/firebull"];
    if ([UIDevice currentDevice].systemName.floatValue > 10) {
        @weakify(self);
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:^(BOOL success) {
            @strongify(self);
        }];

    } else {
        [[UIApplication sharedApplication] openURL:URL];
    }
}

@end
