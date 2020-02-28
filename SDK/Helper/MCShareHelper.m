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

+ (void)shareCommenShareDto:(MCShareDto *)dto callBack:(void (^)(BOOL success, NSError *error))successBlock {
  
    if (dto.image && !dto.imgUrl) {
        [self shareCommentAfterGetImageWithShareDto:dto callBack:successBlock];
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
        [MCShareHelper shareCommentAfterGetImageWithShareDto:dto callBack:successBlock];
    } else {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:dto.imgUrl]
                                                              options:0
                                                             progress:nil
                                                            completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                                if (image) {
                                                                    dto.image = image;
                                                                    [[SDWebImageManager sharedManager] saveImageToCache:image forURL:[NSURL URLWithString:dto.imgUrl]];
                                                                }
                                                                [[self class] shareCommentAfterGetImageWithShareDto:dto callBack:successBlock];
                                                            }];
    }
}

+ (void)shareCommentAfterGetImageWithShareDto:(MCShareDto *)shareDto callBack:(void (^)(BOOL success, NSError *error))successBlock {
    [shareDto updateShareURL:shareDto.toPlatform];
//    [shareDto logProcess:[@([MCShareDto target:shareDto.toPlatform]) stringValue]];

    NSDictionary *param = [shareDto shareDict];
//        UIPasteboard *general = [UIPasteboard generalPasteboard];
//        NSString *pasteText = [StringUtils hasText:shareDto.pasteText] ? shareDto.pasteText : param[LDSDKShareUrlKey];
//        [general setString:pasteText];
//        [ToastUtils showOnTabTopTitle:@"复制成功"];
    id <LDSDKShareService> shareService = [[LDSDKManager share] shareService:shareDto.toPlatform];
    [shareService shareContent:param];
//
//        [shareService shareWithContent:param shareModule:[MCShareHelper shareType:socialPlatform] onComplete:^(BOOL success, NSError *error) {
//            [GCDQueue executeInMainQueue:^{
//                if (success) {
//                    NSString *targat = [NSString stringWithFormat:@"%ld", (long) [MCShareDto target:shareDto.platform]];
//                    [shareDto logResult:targat];
//                }
//                if (successBlock) {
//                    successBlock(success, error);
//                }
//            }];
//        }];
}
@end
