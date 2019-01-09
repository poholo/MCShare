//
//  MCShareCell.h
//  MCShare
//
//  Created by majiancheng on 16/11/30.
//  Copyright © 2016年 poholo inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCSocialPlatformDto;

@interface MCShareCell : UICollectionViewCell

- (void)loadData:(MCSocialPlatformDto *)dto;

+ (NSString *)identifier;

@end
