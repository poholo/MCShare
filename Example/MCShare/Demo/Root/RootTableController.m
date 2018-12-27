//
// Created by majiancheng on 2018/12/27.
// Copyright (c) 2018 majiancheng. All rights reserved.
//

#import "RootTableController.h"

#import "RootDataVM.h"
#import "CateDto.h"

@interface RootTableController ()

@property(nonatomic, strong) RootDataVM *dataVM;

@end

@implementation RootTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MCShare样式";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self pullToRefresh];
}

- (void)pullToRefresh {
    [self.dataVM refresh];
    [self.tableView reloadData];
}

#pragma mark - table

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    CateDto *cateDto = self.dataVM.dataList[indexPath.row];
    cell.textLabel.text = cateDto.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataVM.dataList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CateDto *cateDto = self.dataVM.dataList[indexPath.row];
    UIViewController *controller = [cateDto.targetClass new];
    controller.title = cateDto.name;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - getter

- (RootDataVM *)dataVM {
    if (!_dataVM) {
        _dataVM = [RootDataVM new];
    }
    return _dataVM;
}
@end