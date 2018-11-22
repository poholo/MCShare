//
//  MCShareCell.h
//  WaQuVideo
//
//  Created by majiancheng on 16/11/30.
//  Copyright © 2016年 poholo inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SocialPlatformDto;

@interface MCShareCell : UICollectionViewCell

- (void)loadData:(SocialPlatformDto *)dto;

+ (NSString *)identifier;

@end
