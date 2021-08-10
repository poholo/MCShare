//
// Created by majiancheng on 2018/8/18.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "MCShareHelper.h"

#import <LDSDKManager/LDSDKManager.h>
#import <LDSDKManager/LDSDKShareService.h>
#import <SDWebImage/SDWebImageManager.h>

#import "MCShareDto.h"


@implementation MCShareHelper

+ (void)shareCommenShareDto:(MCShareDto *)dto  {
    if (dto.image && !dto.imgUrl) {
        [self shareCommentAfterGetImageWithShareDto:dto];
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
        [MCShareHelper shareCommentAfterGetImageWithShareDto:dto];
    } else {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:dto.imgUrl]
                                                              options:0
                                                             progress:nil
                                                            completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                                if (image) {
                                                                    dto.image = image;
                                                                    [[SDWebImageManager sharedManager] saveImageToCache:image forURL:[NSURL URLWithString:dto.imgUrl]];
                                                                }
                                                                [[self class] shareCommentAfterGetImageWithShareDto:dto];
                                                            }];
    }
}

+ (void)shareCommentAfterGetImageWithShareDto:(MCShareDto *)shareDto {
    [shareDto updateShareURL:shareDto.toPlatform];
    NSDictionary *param = [shareDto shareDict];
    id <LDSDKShareService> shareService = [[LDSDKManager share] shareService:shareDto.toPlatform];
    [shareService shareContent:param];
}
@end
