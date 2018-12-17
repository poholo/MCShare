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
        [self.dataVM.shareDto updateShareURL:LDSDKPlatformQQ];
    }               error:^(NSError *error) {
        NSLog(@"[Share]->Host.ERROR %@", error);
    }];
}

- (void)createUI {
    [self addSubview:self.backgroundView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.cancelBtn];
    [self.contentView addSubview:self.collectionView];
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
    SocialPlatformDto *platformDto = self.dataVM.dataList[indexPath.item];
    MCShareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MCShareCell identifier] forIndexPath:indexPath];
    [cell loadData:platformDto];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    SocialPlatformDto *platformDto = self.dataVM.dataList[indexPath.item];

    [self.dataVM.shareDto updateSocialPlatform:platformDto];

    ShareDto *dto = self.dataVM.shareDto;
    [MCShareHelper shareCommenShareDto:dto callBack:self.compeleteBlock];

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
        _contentShapeLayer.fillColor = [MCShareColor whiteColor].CGColor;
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
        [_cancelBtn setBackgroundColor:[MCShareColor colorVI] forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[MCShareColor colorI] forState:UIControlStateNormal];
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
