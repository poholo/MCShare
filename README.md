# MCShare
第三方分享组件，依赖于LDSDKManager_IOS

## 功能
MCShare是一个iOS分享组件，旨在减少分享模块的开发工作量，包含以下功能：
1 完整的分享UI
2 支持自定义的分享功能

## Screenshot


## 使用手册

```
    ShareDto *shareDto = [ShareDto createShareURL:@"http://news.cctv.com/2018/11/21/ARTIg1vM5MUC0ImOi4x18MOh181121.shtml"
                                       title:@"大妈公交坐过站抢夺司机方向盘 被处以拘留10天处罚"
                                        desc:@"，接到公交公司报警后，涪城分局城北派出所迅速开展调查工作并依法将违法嫌疑人张某某(女，53岁，雅安市名山区人)传唤至派出所，张某某如实交代了自己因急于下车一时冲动而抢夺方向盘的违法事实，同时表示后悔和自责，希望得到公众谅解。"
                                       image:@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1903202034,3702680589&fm=55&app=22&f=JPEG?w=121&h=81&s=AD336397508303F1059CBC0D0300E042"
                                   pasteText:@""];
    MCSharePopView *sharePopView = [MCSharePopView new];
    [sharePopView shareCommenShareDto:shareDto callBack:^(BOOL success, NSError *error) {

    }];
    
```

## 依赖

```
    pod 'LDSDKManager' # 由于网易团队不在更新LDSDKManager，LDSDKManager的pod版本已经fork的poholo下并长期维护
    pod 'MMPopupView'
    pod 'SDWebImage'
    pod 'ReactiveCocoa', '2.5'
    pod 'SDVersion', git: 'https://github.com/cguess/SDVersion'
```
LDSDKManager是MCShare的分享能力，由于网易团队不在更新LDSDKManager，LDSDKManager的pod版本已经fork的poholo下并长期维护。
MMPopupView提供弹出pop组件，


## TODO
- 功能简化
   提供功能性demo
- 动态域名
- 健壮性