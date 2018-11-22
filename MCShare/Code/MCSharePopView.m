//
//  MCSharePopView.m
//  WaQuVideo
//
//  Created by majiancheng on 16/11/30.
//  Copyright © 2016年 poholo inc. All rights reserved.
//

#import "MCSharePopView.h"

#import <Masonry.h>
#import <ReactiveCocoa.h>
#import <SDWebImage/SDWebImageManager.h>

#import "ShareDto.h"
#import "MCShareCell.h"
#import "SocialPlatformDto.h"
#import "MCShareDataVM.h"
#import "ShareDto.h"
#import "MCShareHelper.h"
#import "ToastUtils.h"
#import "StringUtils.h"
#import "UIColor+Extend.h"
#import "MCShareColor.h"
#import "UIButton+BackgroundColor.h"
#import "DeviceUtils.h"

@interface MCSharePopView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UIView *backgroundView;
@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) CAShapeLayer *contentShapeLayer;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UIButton *cancelBtn;

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *mentionLabel;

@property(nonatomic, copy) void (^compeleteBlock)(BOOL success, NSError *error);

@property(nonatomic, strong) MCShareDataVM *dataVM;

@end

@implementation MCSharePopView

#pragma mark  interface

- (void)shareCommenShareDto:(ShareDto *)shareDto callBack:(void (^)(BOOL success, NSError *error))successBlock {
    self.compeleteBlock = successBlock;
    self.dataVM.shareDto = shareDto;

    [self initilizer];

    self.type = MMPopupTypeSheet;

    [super show];
}

- (void)initilizer {
    [self.dataVM refresh];
    [self createUI];
    [self addLayout];
    [self updateHost];
}

- (void)updateHost {
    RACSignal *signal = [self.dataVM shareHost];
    @weakify(self);
    [signal subscribeNext:^(id x) {
        @strongify(self);
        [self.dataVM.shareDto updateShareURL:SocialPlatformWeChat];
    }               error:^(NSError *error) {
        NSLog(@"[Share]->Host.ERROR %@", error);
    }];
}

- (void)createUI {
    [self addSubview:self.backgroundView];
    [self addSubview:self.contentView];

    if ([self __isPasteShareStyle]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.mentionLabel];
        self.titleLabel.text = [StringUtils hasText:self.dataVM.shareDto.pasteText] ? self.dataVM.shareDto.pasteText : self.dataVM.shareDto.title;
        ((UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout).scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [self __copy];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;

    } else {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        ((UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout).scrollDirection = UICollectionViewScrollDirectionVertical;
        [self.contentView addSubview:self.cancelBtn];
    }
    [self.contentView addSubview:self.collectionView];
}

- (void)__copy {
    if ([StringUtils hasText:self.dataVM.shareDto.pasteText]) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.dataVM.shareDto.pasteText;
        [ToastUtils showTopTitle:@"粘贴内容已经拷贝到剪贴板"];
    }
}

- (void)addLayout {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(UIScreen.mainScreen.bounds.size);
    }];

    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    CGSize size = [self collectionCellSize];
    UIEdgeInsets insets = [self collectionView:self.collectionView layout:self.collectionView.collectionViewLayout insetForSectionAtIndex:0];
    CGFloat verticalMargin = [self collectionView:self.collectionView layout:self.collectionView.collectionViewLayout minimumLineSpacingForSectionAtIndex:0];
    CGFloat row = self.dataVM.dataList.count / 5 + (self.dataVM.dataList.count % 5 > 0 ? 1 : 0);


    if (![self __isPasteShareStyle]) {
        CGFloat height = size.height * row + verticalMargin * (row - 1) + insets.top + insets.bottom + 49 + [DeviceUtils xBottom];

        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(height);
        }];

        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.cancelBtn.mas_top);
        }];

        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-[DeviceUtils xBottom]);
            make.height.mas_equalTo(49);
        }];

    } else {
        CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * 24, CGFLOAT_MAX)];
        CGFloat height = size.height * row + 16 + titleSize.height + 20 + [DeviceUtils xBottom];

        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(height);
        }];

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(16);
            make.left.equalTo(self.contentView.mas_left).offset(24);
            make.right.equalTo(self.contentView.mas_right).offset(-24);
            make.height.mas_equalTo(titleSize.height);
        }];

        [self.mentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
            make.left.right.equalTo(self.titleLabel);
            make.height.mas_equalTo(23);
        }];

        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mentionLabel.mas_bottom).offset(0);
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-[DeviceUtils xBottom]);
        }];
    }
}

- (BOOL)__isPasteShareStyle {
    return self.dataVM.shareDto.pasteText.length > 0;
}

#pragma mark - Action

- (void)shareCommen:(SocialPlatform)socialPlatform {
    ShareDto *dto = self.dataVM.shareDto;
    [MCShareHelper shareCommenShareDto:dto platform:socialPlatform callBack:self.compeleteBlock];
}

- (void)openSchema:(SocialPlatform)socialPlatform {
    [self.dataVM.shareDto logProcess:[@([ShareDto target:socialPlatform]) stringValue]];

    NSString *schema = @"";
    switch (socialPlatform) {
        case SocialPlatformWeChat: {
            schema = @"wechat://";
        }
            break;
        case SocialPlatformQQ: {
            schema = @"mqq://";
        }
            break;
        case SocialPlatformWeChatFriend: {
            schema = @"wechat://";
        }
            break;
        case SocialPlatformQQZone: {
            schema = @"mqq://";
        }
            break;
        case SocialPlatformWeiBo: {
            schema = @"weibo://";
        }
            break;
        case SocialPlatformTelegram: {
            schema = @"tg://";
        }
            break;
    }

    NSURL *schemaURL = [NSURL URLWithString:schema];
    NSString *targat = [NSString stringWithFormat:@"%ld", (long) [ShareDto target:self.dataVM.shareDto.platform]];
    if (@available(iOS 10.0, *)) {
        @weakify(self);
        [[UIApplication sharedApplication] openURL:schemaURL options:nil completionHandler:^(BOOL success) {
            @strongify(self);
            if (success) {
                [ToastUtils showTopTitle:@"打开失败 - 1"];
            } else {
                [self.dataVM.shareDto logResult:targat];
            }
        }];
    } else {
        BOOL open = [[UIApplication sharedApplication] openURL:schemaURL];
        if (!open) {
            [ToastUtils showTopTitle:@"打开失败 - 2"];
        } else {
            [self.dataVM.shareDto logResult:targat];
        }
    }

}


#pragma mark UICollectionViewDataSource

- (CGSize)collectionCellSize {
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 30) / 5.0f - 10.0f;
    CGFloat height = width + 20;
    if (![self __isPasteShareStyle]) {
        return CGSizeMake(width, height);
    } else {
        return CGSizeMake(width, width + 5);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataVM.dataList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self collectionCellSize];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (![self __isPasteShareStyle]) {
        return UIEdgeInsetsMake(20, 15, 20, 15);
    } else {
        return UIEdgeInsetsZero;
    }
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 16;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SocialPlatformDto *platformDto = self.dataVM.dataList[indexPath.item];
    MCShareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MCShareCell identifier] forIndexPath:indexPath];
    [cell loadData:platformDto];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    SocialPlatformDto *platformDto = self.dataVM.dataList[indexPath.item];

    if (platformDto.platform == SocialPlatformDel) {
        if (self.compeleteBlock) {
            self.compeleteBlock(YES, nil);
        }
    } else if (platformDto.platform == SocialPlatformReport) {

    } else if (platformDto.platform == SocialPlatformTelegram) {
        BOOL success = [self.dataVM share2Telegram];
        [self.dataVM.shareDto logProcess:[NSString stringWithFormat:@"%ld", (long) [ShareDto target:platformDto.platform]]];
        if (self.compeleteBlock) {
            self.compeleteBlock(success, nil);
        }
    } else {
        SocialPlatform socialPlatform = platformDto.platform;
        if (socialPlatform == SocialPlatformWeiBo
                || socialPlatform == SocialPlatformLink
                || ![self __isPasteShareStyle]) {
            if (socialPlatform == SocialPlatformQQ && [MCShareConfig share].textShareMode.boolValue) {
                [self.dataVM.shareDto updatePaste];
                [self __copy];
                [self openSchema:socialPlatform];
            } else {
                [self shareCommen:socialPlatform];
            }
            if (self.compeleteBlock) {
                self.compeleteBlock(YES, nil);
            }
        } else {
            [self openSchema:socialPlatform];
        }
    }
    self.compeleteBlock = nil;
    [self hide];
}


#pragma mark  getter

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    }
    return _backgroundView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        [_contentView.layer addSublayer:self.contentShapeLayer];
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}

- (CAShapeLayer *)contentShapeLayer {
    if (!_contentShapeLayer) {
        _contentShapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGFloat r = 20;
        CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
        CGFloat scrrenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
        [path moveToPoint:CGPointMake(0, r)];
        [path addQuadCurveToPoint:CGPointMake(r, 0) controlPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(screenWidth - r, 0)];
        [path addQuadCurveToPoint:CGPointMake(screenWidth, r) controlPoint:CGPointMake(screenWidth, 0)];
        [path addLineToPoint:CGPointMake(screenWidth, scrrenHeight - r)];
        [path addLineToPoint:CGPointMake(0, scrrenHeight - r)];
        [path addLineToPoint:CGPointMake(0, r)];
        [path closePath];
        _contentShapeLayer.fillColor = [UIColor rgba:0x191b28e6].CGColor;
        _contentShapeLayer.path = path.CGPath;
    }
    return _contentShapeLayer;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[MCShareCell class] forCellWithReuseIdentifier:[MCShareCell identifier]];

    }
    return _collectionView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton new];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setBackgroundColor:[MCShareColor colorIII] forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[MCShareColor colorI] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _cancelBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [MCShareColor colorI];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)mentionLabel {
    if (!_mentionLabel) {
        _mentionLabel = [UILabel new];
        _mentionLabel.textColor = [MCShareColor colorI];
        _mentionLabel.font = [UIFont systemFontOfSize:13];
        _mentionLabel.textAlignment = NSTextAlignmentCenter;
        _mentionLabel.text = @"马上粘贴给朋友";
    }
    return _mentionLabel;
}

- (MCShareDataVM *)dataVM {
    if (!_dataVM) {
        _dataVM = [MCShareDataVM new];
    }
    return _dataVM;
}

@end
