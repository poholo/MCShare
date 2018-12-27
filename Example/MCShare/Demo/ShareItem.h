//
// Created by majiancheng on 2018/12/17.
// Copyright (c) 2018 majiancheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDSDKConfig.h"


@interface ShareItem : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) LDSDKShareType type;

@end