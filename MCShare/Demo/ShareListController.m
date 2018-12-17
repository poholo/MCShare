//
//  ShareListController.m
//  MCShare
//
//  Created by majiancheng on 2018/11/20.
//  Copyright © 2018 majiancheng. All rights reserved.
//

#import "ShareListController.h"

#import "UIButton+BackgroundColor.h"
#import "MCShareColor.h"
#import "MCSharePopView.h"
#import "ShareDto.h"
#import "ShareListDataVM.h"
#import "ShareItem.h"
#import "DeviceUtils.h"

@interface ShareListController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIButton *shareButton;
@property(nonatomic, strong) ShareDto *shareDto;
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
    self.shareDto.toType = item.type;

    MCSharePopView *sharePopView = [MCSharePopView new];
    [sharePopView shareCommenShareDto:self.shareDto callBack:^(BOOL success, NSError *error) {

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

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 40 - [DeviceUtils xBottom], CGRectGetWidth(self.view.frame), 40)];
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        [_shareButton setBackgroundColor:[MCShareColor colorV] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

- (ShareDto *)shareDto {
    if (!_shareDto) {
        _shareDto = [ShareDto createShareURL:@"http://news.cctv.com/2018/11/21/ARTIg1vM5MUC0ImOi4x18MOh181121.shtml"
                                       title:@"大妈公交坐过站抢夺司机方向盘 被处以拘留10天处罚"
                                        desc:@"，接到公交公司报警后，涪城分局城北派出所迅速开展调查工作并依法将违法嫌疑人张某某(女，53岁，雅安市名山区人)传唤至派出所，张某某如实交代了自己因急于下车一时冲动而抢夺方向盘的违法事实，同时表示后悔和自责，希望得到公众谅解。"
                                       image:@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1903202034,3702680589&fm=55&app=22&f=JPEG?w=121&h=81&s=AD336397508303F1059CBC0D0300E042"];
    }
    return _shareDto;
}

- (ShareListDataVM *)dataVM {
    if (!_dataVM) {
        _dataVM = [ShareListDataVM new];
    }
    return _dataVM;
}

@end
