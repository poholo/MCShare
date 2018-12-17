//
// Created by majiancheng on 2018/12/17.
// Copyright (c) 2018 majiancheng. All rights reserved.
//

#import "ShareListDataVM.h"
#import "ShareItem.h"


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

#pragma mark - getter

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}
@end