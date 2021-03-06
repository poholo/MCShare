//
// Created by majiancheng on 2019/1/10.
// Copyright (c) 2019 majiancheng. All rights reserved.
//

#import "MCAuthCell.h"

#import <Masonry.h>
#import <MCStyle/MCColor.h>

#import "MCSocialPlatformDto.h"

@interface MCAuthCell ()

@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation MCAuthCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.iconImageView = [UIImageView new];
        [self.contentView addSubview:self.iconImageView];

        self.titleLabel = [UILabel new];
        [self.contentView addSubview:self.titleLabel];

        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.contentView);
            make.height.equalTo(self.iconImageView.mas_width);
            make.centerX.equalTo(self.contentView.mas_centerX);
        }];

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImageView.mas_bottom).offset(5);
            make.centerX.equalTo(self.contentView.mas_centerX);
        }];

        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [MCColor custom:@"share_title_color"];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)loadData:(MCSocialPlatformDto *)dto {
    self.iconImageView.image = [UIImage imageNamed:dto.image];
    self.titleLabel.text = dto.name;

}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}
@end