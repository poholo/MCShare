//
// Created by majiancheng on 2018/12/17.
// Copyright (c) 2018 majiancheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LDSDKManager/LDSDKShareService.h>
#import "LDSDKConfig.h"

@class ShareItem;
@class MCShareDto;


@interface ShareListDataVM : NSObject

@property(nonatomic, strong) NSMutableArray<ShareItem *> *dataList;

@property(nonatomic, assign) NSInteger selectIdx;

- (void)refresh;

- (MCShareDto *)prepareShareDto:(LDSDKShareType)shareType shareCallBack:(LDSDKShareCallback)shareCallBack;

@end