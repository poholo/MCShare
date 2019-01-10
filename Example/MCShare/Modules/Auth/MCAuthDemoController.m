//
// Created by majiancheng on 2019/1/10.
// Copyright (c) 2019 majiancheng. All rights reserved.
//

#import "MCAuthDemoController.h"

#import <MCBase/MCLog.h>

#import "MCAuthDemoDataVM.h"
#import "UIButton+BackgroundColor.h"
#import "MCAuthPopView.h"
#import "DeviceUtils.h"
#import "ShareItem.h"

@interface MCAuthDemoController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIButton *authButton;
@property(nonatomic, strong) MCAuthDemoDataVM *dataVM;

@end


@implementation MCAuthDemoController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.authButton];
    [self refresh];
}

- (void)refresh {
    [self.tableView reloadData];
}

- (void)authButtonClick {

    MCAuthPopView *authPopView = [MCAuthPopView new];

    [authPopView showWithCallBack:^(LDSDKLoginCode code, NSError *error, NSDictionary *oauthInfo, NSDictionary *userInfo) {
        MCLog(@"code %zd error %@ auth %@ user %@", code, error, oauthInfo, userInfo);
    }];
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

- (UIButton *)authButton {
    if (!_authButton) {
        _authButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 40 - [DeviceUtils xBottom], CGRectGetWidth(self.view.frame), 40)];
        [_authButton setTitle:@"授权" forState:UIControlStateNormal];
        [_authButton setBackgroundColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_authButton addTarget:self action:@selector(authButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _authButton;
}

- (MCAuthDemoDataVM *)dataVM {
    if (!_dataVM) {
        _dataVM = [MCAuthDemoDataVM new];
    }
    return _dataVM;
}

@end