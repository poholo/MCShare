//
// Created by majiancheng on 2019/1/10.
// Copyright (c) 2019 majiancheng. All rights reserved.
//

#import "MCAuthPopView.h"

#import <Masonry.h>
#import <MCStyle/MCColor.h>

#import "MCAuthDataVM.h"
#import "MCAuthCell.h"
#import "MCAuthHelper.h"
#import "MCSocialPlatformDto.h"


@interface MCAuthPopView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, copy) LDSDKAuthCallback authCallback;

@property(nonatomic, strong) MCAuthDataVM *dataVM;
@end

@implementation MCAuthPopView

- (void)showWithCallBack:(LDSDKAuthCallback)authCallback {
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    self.authCallback = authCallback;

    [self initilizer];
    [self loadData];
    self.type = MMPopupTypeAlert;
    [super show];
}

- (void)initilizer {
    [self.dataVM refresh];
    [self createUI];
    [self addLayout];
}

- (void)createUI {
    [self addSubview:self.collectionView];
    self.backgroundColor = [MCColor custom:@"share_background_color"];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
}

- (void)addLayout {


    CGSize size = [self collectionCellSize];
    UIEdgeInsets insets = [self collectionView:self.collectionView layout:self.collectionView.collectionViewLayout insetForSectionAtIndex:0];
    CGFloat verticalMargin = [self collectionView:self.collectionView layout:self.collectionView.collectionViewLayout minimumLineSpacingForSectionAtIndex:0];
    CGFloat margin = [self collectionView:self.collectionView layout:self.collectionView.collectionViewLayout minimumInteritemSpacingForSectionAtIndex:0];
    CGFloat row = self.dataVM.dataList.count / 3 + (self.dataVM.dataList.count % 3 > 0 ? 1 : 0);


    CGFloat height = size.height * row + verticalMargin * (row - 1) + insets.top + insets.bottom;

    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) * .7 + 20, height + 20));
    }];

    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    if (self.dataVM.dataList.count == 1) {
        edgeInsets.left += (size.width + margin);
        edgeInsets.right += (size.width + margin);
    } else if (self.dataVM.dataList.count == 2) {
        edgeInsets.left += (size.width / 2.0f + margin);
        edgeInsets.right += (size.width / 2.0f + margin);
    }

    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(edgeInsets);
    }];
}

- (void)loadData {
    __weak typeof(self) weakSelf = self;
    [self.dataVM reqAuthPlatforms:^(NSArray<MCSocialPlatformDto *> *array) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf addLayout];
        [strongSelf.collectionView reloadData];
    }];
}


#pragma mark UICollectionViewDataSource

- (CGSize)collectionCellSize {
    CGFloat width = ([UIScreen mainScreen].bounds.size.width * .7f - 30) / 3.0f - 10.0f;
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
    MCAuthCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MCAuthCell identifier] forIndexPath:indexPath];
    [cell loadData:platformDto];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MCSocialPlatformDto *platformDto = self.dataVM.dataList[indexPath.item];
    [MCAuthHelper auth:platformDto.platform callBack:self.authCallback];
}


#pragma mark  getter


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
        [_collectionView registerClass:[MCAuthCell class] forCellWithReuseIdentifier:[MCAuthCell identifier]];

    }
    return _collectionView;
}


- (MCAuthDataVM *)dataVM {
    if (!_dataVM) {
        _dataVM = [MCAuthDataVM new];
    }
    return _dataVM;
}
@end