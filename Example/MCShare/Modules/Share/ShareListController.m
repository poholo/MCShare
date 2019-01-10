//
//  ShareListController.m
//  MCShare
//
//  Created by majiancheng on 2018/11/20.
//  Copyright © 2018 majiancheng. All rights reserved.
//

#import "ShareListController.h"

#import <MCStyle/MCColor.h>

#import "UIButton+BackgroundColor.h"
#import "MCSharePopView.h"
#import "MCShareDto.h"
#import "ShareListDataVM.h"
#import "ShareItem.h"
#import "DeviceUtils.h"
#import "MCStyle.h"
#import "MCStyleManager.h"

@interface ShareListController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIButton *shareButton;
@property(nonatomic, strong) ShareListDataVM *dataVM;

@end

@implementation ShareListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.shareButton];
    [self refresh];
}

- (void)refresh {

    [self.dataVM refresh];
    [self.tableView reloadData];
}

- (void)shareButtonClick {
    ShareItem *item = self.dataVM.dataList[self.dataVM.selectIdx];
    __weak typeof(self) weakSelf = self;
    MCShareDto *dto = [self.dataVM prepareShareDto:item.type shareCallBack:^(LDSDKErrorCode code, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
    }];

    MCSharePopView *sharePopView = [MCSharePopView new];
    [sharePopView shareCommenShareDto:dto];
}


#pragma mark - table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataVM.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    ShareItem *shareItem = self.dataVM.dataList[indexPath.row];
    cell.textLabel.text = shareItem.name;
    cell.accessoryType = self.dataVM.selectIdx == indexPath.row ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.dataVM.selectIdx = indexPath.row;
    [self.tableView reloadData];
}


#pragma mark -getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 40 - [DeviceUtils xBottom]) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 40 - [DeviceUtils xBottom], CGRectGetWidth(self.view.frame), 40)];
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        [_shareButton setBackgroundColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

- (ShareListDataVM *)dataVM {
    if (!_dataVM) {
        _dataVM = [ShareListDataVM new];
    }
    return _dataVM;
}

@end
