# MCShare
第三方分享组件，依赖于LDSDKManager_IOS

## 功能
MCShare是一个iOS分享组件，旨在减少分享模块的开发工作量，包含以下功能：
1 完整的分享UI
2 支持自定义的分享功能

## Screenshot

## 配置方法
1. 各平台账号秘钥配置
打开Code/MCShareConfig.m 替换ID keys
```
//TODO:: 各个账号id
#pragma mark - warning 各个账号id
NSString *const WXAppID = @"WXAppID";
NSString *const WXAppSecret = @"WXAppSecret";
NSString *const QQAppID = @"QQAppID";
NSString *const QQAppKey = @"QQAppKey";
NSString *const SinaAppID = @"SinaAppID";
NSString *const SinaAppKey = @"SinaAppKey";
```

2.Info配置
App info.plist 中添加一下schemas
```xml
<key>LSApplicationQueriesSchemes</key>
    <array>
        <string>wechat</string>
        <string>weixin</string>
        <string>sinaweibohd</string>
        <string>sinaweibo</string>
        <string>sinaweibosso</string>
        <string>weibosdk</string>
        <string>weibosdk2.5</string>
        <string>mqqapi</string>
        <string>mqq</string>
        <string>mqqOpensdkSSoLogin</string>
        <string>mqqconnect</string>
        <string>mqqopensdkdataline</string>
        <string>mqqopensdkgrouptribeshare</string>
        <string>mqqopensdkfriend</string>
        <string>mqqopensdkapi</string>
        <string>mqqopensdkapiV2</string>
        <string>mqqopensdkapiV3</string>
        <string>mqzoneopensdk</string>
        <string>wtloginmqq</string>
        <string>wtloginmqq2</string>
        <string>mqqwpa</string>
        <string>mqzone</string>
        <string>mqzonev2</string>
        <string>mqzoneshare</string>
        <string>wtloginqzone</string>
        <string>mqzonewx</string>
        <string>mqzoneopensdkapiV2</string>
        <string>mqzoneopensdkapi19</string>
        <string>mqzoneopensdkapi</string>
        <string>mqqbrowser</string>
        <string>mttbrowser</string>
        <string>waquchild</string>
        <string>tencentapi.qq.reqContent</string>
        <string>tencentapi.qzone.reqContent</string>
        <string>tg</string>
    </array>

```

3.info.plist 增加URL types
```xml
<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLName</key>
			<string>com.poholo.MCShare</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>mcshare</string>
			</array>
		</dict>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLName</key>
			<string>weixin</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>xxxxx</string>
			</array>
		</dict>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLName</key>
			<string>tencent</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>xxxxx</string>
			</array>
		</dict>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLName</key>
			<string>weibo</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>sina.xxxxxxxx</string>
			</array>
		</dict>
	</array>
```

## 使用手册
AppDelegate中分享能力注册、回调实现
```objectivec
self.socialModule = [MCSocialModule new];
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.socialModule application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL rsp = [self.socialModule application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    if (rsp) {
        return rsp;
    }
    return NO;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary *)options {
    BOOL rsp = [self.socialModule application:application openURL:url options:options];
    if (rsp) {
        return rsp;
    }
    return NO;
}
```

```objectivec
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