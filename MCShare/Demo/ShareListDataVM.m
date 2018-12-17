//
// Created by majiancheng on 2018/12/17.
// Copyright (c) 2018 majiancheng. All rights reserved.
//

#import "ShareListDataVM.h"
#import "ShareItem.h"
#import "ShareDto.h"


@implementation ShareListDataVM

- (void)refresh {
    [self.dataList removeAllObjects];
    {
        ShareItem *item = [ShareItem new];
        item.name = @"文本内容";
        item.type = LDSDKShareTypeText;
        [self.dataList addObject:item];
    }

    {
        ShareItem *item = [ShareItem new];
        item.name = @"图片内容";
        item.type = LDSDKShareTypeImage;
        [self.dataList addObject:item];
    }

    {
        ShareItem *item = [ShareItem new];
        item.name = @"新闻格式";
        item.type = LDSDKShareTypeNews;
        [self.dataList addObject:item];
    }

    {
        ShareItem *item = [ShareItem new];
        item.name = @"音乐";
        item.type = LDSDKShareTypeAudio;
        [self.dataList addObject:item];
    }

    {
        ShareItem *item = [ShareItem new];
        item.name = @"视频";
        item.type = LDSDKShareTypeVideo;
        [self.dataList addObject:item];
    }

    {
        ShareItem *item = [ShareItem new];
        item.name = @"文件";
        item.type = LDSDKShareTypeFile;
        [self.dataList addObject:item];
    }

    {
        ShareItem *item = [ShareItem new];
        item.name = @"小程序";
        item.type = LDSDKShareTypeMiniProgram;
        [self.dataList addObject:item];
    }

}


- (NSString *)title {
    return @"标题LDSDKManager_SDK";
}

- (NSString *)desc {
    return @"集成的第三方SDK（目前包括QQ,微信,易信,支付宝）进行集中管理，按照功能（目前包括第三方登录,分享,支付）开放给各个产品使用。通过接口的方式进行产品集成，方便对第三方SDK进行升级维护。";
}


- (NSString *)link {
    return @"https://github.com/poholo/LDSDKManager_IOS";
}


- (ShareDto *)prepareShareDto:(LDSDKShareType)shareType shareCallBack:(LDSDKShareCallback)shareCallBack {
    ShareDto *dto = nil;
    switch (shareType) {
        case LDSDKShareTypeText: {
            dto = [ShareDto createShareText:[self desc] callBack:shareCallBack];
        }
            break;
        case LDSDKShareTypeImage: {
            dto = [ShareDto createShareImage:@"think.jpg" callBack:shareCallBack];
        }
            break;
        case LDSDKShareTypeNews: {
            dto = [ShareDto createShareNews:[self title] desc:[self desc] link:self.link image:@"think.jpg" callBack:shareCallBack];
        }
            break;
        case LDSDKShareTypeAudio: {
            dto = [ShareDto createShareAudio:self.title desc:self.desc link:self.link image:@"think.jpg"
                                       media:[[NSBundle mainBundle] pathForResource:@"media" ofType:@"mp4"] callBack:shareCallBack];

        }
            break;
        case LDSDKShareTypeVideo: {
            dto = [ShareDto createShareVideo:self.title desc:self.desc link:self.link image:@"think.jpg"
                                       media:[[NSBundle mainBundle] pathForResource:@"media" ofType:@"mp4"] callBack:shareCallBack];
        }
            break;
        case LDSDKShareTypeFile: {
            dto = [ShareDto createShareFile:self.title desc:self.desc link:self.link image:@"think.jpg"
                                       file:[[NSBundle mainBundle] pathForResource:@"media" ofType:@"mp4"] callBack:shareCallBack];
        }
            break;
        case LDSDKShareTypeMiniProgram: {
            dto = [ShareDto createShareMiniProgram:@"" miniProgramType:LDSDKMiniProgramTypePreview link:self.link callBack:shareCallBack];
        }
            break;
    }
    return dto;
}

#pragma mark - getter

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}
@end
