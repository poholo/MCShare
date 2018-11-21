//
//  SocialShareCell.m
//  WaQuVideo
//
//  Created by majiancheng on 16/11/30.
//  Copyright © 2016年 poholo inc. All rights reserved.
//

#import "SocialShareCell.h"

#import <Masonry.h>
#import <ReactiveCocoa.h>

#import "SocialPlatformDto.h"
#import "AppColor.h"


@interface SocialShareCell ()

@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *titleLabel;

@end


@implementation SocialShareCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.iconImageView = [UIImageView new];
        [self.contentView addSubview:self.iconImageView];

        self.titleLabel = [UILabel new];
        [self.contentView addSubview:self.titleLabel];

        @weakify(self);
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.right.top.equalTo(self.contentView);
            make.height.equalTo(self.iconImageView.mas_width);
            make.centerX.equalTo(self.contentView.mas_centerX);
        }];

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.iconImageView.mas_bottom).offset(5);
            make.centerX.equalTo(self.contentView.mas_centerX);
        }];

        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [AppColor colorII];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)loadData:(SocialPlatformDto *)dto {
    self.iconImageView.image = [UIImage imageNamed:dto.image];
    self.titleLabel.text = dto.name;

}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}


@end
