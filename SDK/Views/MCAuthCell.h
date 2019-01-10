//
// Created by majiancheng on 2019/1/10.
// Copyright (c) 2019 majiancheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCSocialPlatformDto;


@interface MCAuthCell : UICollectionViewCell

- (void)loadData:(MCSocialPlatformDto *)dto;

+ (NSString *)identifier;

@end