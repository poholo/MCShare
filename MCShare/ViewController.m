//
//  ViewController.m
//  MCShare
//
//  Created by majiancheng on 2018/11/20.
//  Copyright © 2018 majiancheng. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+BackgroundColor.h"
#import "AppColor.h"
#import "SocialSharePopView.h"
#import "ShareDto.h"

@interface ViewController ()

@property(nonatomic, strong) UIButton *shareButton;
@property(nonatomic, strong) ShareDto *shareDto;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.shareButton];
}

- (void)shareButtonClick {
    SocialSharePopView *sharePopView = [SocialSharePopView new];

    [sharePopView shareCommenShareDto:self.shareDto callBack:^(BOOL success, NSError *error) {

    }];
}


#pragma mark -getter

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        _shareButton.center = self.view.center;
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        [_shareButton setBackgroundColor:[AppColor colorXII] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

- (ShareDto *)shareDto {
    if (!_shareDto) {
        _shareDto = [ShareDto createShareURL:@"http://news.cctv.com/2018/11/21/ARTIg1vM5MUC0ImOi4x18MOh181121.shtml"
                                       title:@"大妈公交坐过站抢夺司机方向盘 被处以拘留10天处罚"
                                        desc:@"，接到公交公司报警后，涪城分局城北派出所迅速开展调查工作并依法将违法嫌疑人张某某(女，53岁，雅安市名山区人)传唤至派出所，张某某如实交代了自己因急于下车一时冲动而抢夺方向盘的违法事实，同时表示后悔和自责，希望得到公众谅解。"
                                       image:@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1903202034,3702680589&fm=55&app=22&f=JPEG?w=121&h=81&s=AD336397508303F1059CBC0D0300E042"
                                   pasteText:@""];
    }
    return _shareDto;
}

@end
