//
// Created by majiancheng on 2019/2/20.
// Copyright (c) 2019 majiancheng. All rights reserved.
//

#import "SysSocialController.h"

@interface SysSocialController ()

@property(nonatomic, strong) UIActivityViewController *activityViewController;

@end


@implementation SysSocialController

- (void)viewDidLayoutSubviews {
    [super viewDidLoad];
    [self presentViewController:self.activityViewController animated:YES completion:NULL];
}

- (UIActivityViewController *)activityViewController {
    if (!_activityViewController) {
        _activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"test", @"test1", @"tt"] applicationActivities:NULL];
    }
    return _activityViewController;
}

@end
