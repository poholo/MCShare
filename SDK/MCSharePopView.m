//
//  MCSharePopView.m
//  MCShare
//
//  Created by majiancheng on 16/11/30.
//  Copyright © 2016年 poholo inc. All rights reserved.
//

#import "MCSharePopView.h"

#import <Masonry.h>
#import <MCStyle/MCColor.h>

#import "MCShareDto.h"
#import "MCShareCell.h"
#import "MCSocialPlatformDto.h"
#import "MCShareDataVM.h"
#import "MCShareHelper.h"
#import "UIButton+MCBackgroundColor.h"
#import "MCToastUtils.h"
#import "MCDeviceUtils.h"

@interface MCSharePopView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) CAShapeLayer *contentShapeLayer;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UIButton *cancelBtn;

@property(nonatomic, strong) MCShareDataVM *dataVM;

@end

@implementation MCSharePopView

#pragma mark  interface

- (void)shareCommenShareDto:(MCShareDto *)shareDto {
    self.dataVM.shareDto = shareDto;
    [MMPopupWindow sharedWindow].touchWildToHide = YES;

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

    __weak typeof(self) weakSelf = self;
    [self.dataVM shareHost:^(BOOL success) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.dataVM.shareDto updateShareURL:LDSDKPlatformQQ];
        if (!success) {
            NSLog(@"[Share]->Host.ERROR ");
        }
    }];
}

- (void)createUI {
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.cancelBtn];
    [self.contentView addSubview:self.collectionView];
}

- (void)addLayout {


    CGSize size = [self collectionCellSize];
    UIEdgeInsets insets = [self collectionView:self.collectionView layout:self.collectionView.collectionViewLayout insetForSectionAtIndex:0];
    CGFloat verticalMargin = [self collectionView:self.collectionView layout:self.collectionView.collectionViewLayout minimumLineSpacingForSectionAtIndex:0];
    CGFloat row = self.dataVM.dataList.count / 5 + (self.dataVM.dataList.count % 5 > 0 ? 1 : 0);


    CGFloat height = size.height * row + verticalMargin * (row - 1) + insets.top + insets.bottom + 49 + [MCDeviceUtils xBottom];

    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), height));
    }];

    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.cancelBtn.mas_top);
    }];

    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-[MCDeviceUtils xBottom]);
        make.height.mas_equalTo(49);
    }];


}


#pragma mark UICollectionViewDataSource

- (CGSize)collectionCellSize {
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 30) / 5.0f - 10.0f;
    CGFloat height = width + 20;
    return CGSizeMake(width, height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataVM.dataList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self collectionCellSize];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 15, 20, 15);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 16;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MCSocialPlatformDto *platformDto = self.dataVM.dataList[indexPath.item];
    MCShareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MCShareCell identifier] forIndexPath:indexPath];
    [cell loadData:platformDto];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    MCSocialPlatformDto *platformDto = self.dataVM.dataList[indexPath.item];
    [self.dataVM.shareDto updateSocialPlatform:platformDto];

    if (platformDto.platform == kShareAction2Copy) {
        UIPasteboard *general = [UIPasteboard generalPasteboard];
        [general setString:[self.dataVM.shareDto pasteText]];
        [MCToastUtils showOnTabTopTitle:@"复制成功"];
    } else if(platformDto.platform == kShareActionUnknow) {
        if(self.dataVM.shareDto.shareCallback) {
            NSError *error = [NSError errorWithDomain:@"unknow" code:kShareActionUnknow userInfo:@{kShareErrorObj: self.dataVM.shareDto}];
            self.dataVM.shareDto.shareCallback(kShareActionUnknow, error);
        }
    } else if (platformDto.platform == kShareAction2System) {
        [self.dataVM.shareDto updateShareURL:self.dataVM.shareDto.toPlatform];
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.dataVM.shareDto.desc ?: @"", self.dataVM.shareDto.image ?: @"", self.dataVM.shareDto.shareUrl ?: @""] applicationActivities:NULL];
        [[UIApplication sharedApplication].windows.firstObject.rootViewController presentViewController:activityViewController animated:YES completion:NULL];
    } else {
        [MCShareHelper shareCommenShareDto:self.dataVM.shareDto callBack:nil];
    }
    [self hide];
}


#pragma mark  getter

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
        _contentShapeLayer.fillColor = [MCColor custom:@"share_background_color"].CGColor;
        _contentShapeLayer.path = path.CGPath;
    }
    return _contentShapeLayer;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
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
        [_cancelBtn setBackgroundColor:[MCColor custom:@"share_background_color"] forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[MCColor custom:@"share_title_color"] forState:UIControlStateNormal];

        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _cancelBtn;
}

- (MCShareDataVM *)dataVM {
    if (!_dataVM) {
        _dataVM = [MCShareDataVM new];
    }
    return _dataVM;
}

@end
