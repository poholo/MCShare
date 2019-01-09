
> 0.0.1 support cocoapods

# MCShare
[MCShahre](https://github.com/poholo/MCShare)第三方分享组件，依赖于LDSDKManager_IOS.

## 功能
MCShare是一个iOS分享组件，旨在减少分享模块的开发工作量，包含以下功能：
```text
1 完整的分享UI
2 支持自定义的分享功能
3 集成简单
4 动态域名
5 自定义样式
```

## Screenshot

<img src="https://github.com/poholo/MCShare/raw/master/ScreenShot/ScreenShot.PNG" width="25%"/>

## MCStyle Support
```text
用MCStyle提供自定义样式，具体参照MCStyle使用规范
配置自定义颜色
[MCStyleManager share].colorStyleDataCallback = ^NSDictionary *(void) {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CustomColor" ofType:@"json"];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:nil];
    return dict[@"data"];
};
[[MCStyleManager share] loadData];
```
配色如下

<img src="https://github.com/poholo/MCShare/raw/master/ScreenShot/ScreenShot_MCStyle.png" width="25%"/>

## 配置方法
### 0. 接入
```text
直接copy SDK/ 目录代码，按照Example接入
or
pod 'MCShare' 按照Example_pod例子接入
```
### 1. 各平台账号秘钥配置
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

### 2.Info配置
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
    <string>dingtalk</string>
    <string>dingtalk-open</string>
    <string>dingtalk-sso</string>
</array>

```

### 3.info.plist 增加URL types
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
    <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLName</key>
    <string>alipayShare</string>
    <key>CFBundleURLSchemes</key>
    <array>
    <string>ap2018121462531700</string>
    </array>
    </dict>
    <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLName</key>
    <string>dingtalk</string>
    <key>CFBundleURLSchemes</key>
    <array>
    <string>dingoak5hqhuvmpfhpnjvt</string>
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
ShareDto *shareDto = [ShareDto createShareURL:@"https://github.com/poholo/MCShare"
                                   title:@"LDSDKManager_MCShare"
                                    desc:@"集成的第三方SDK（目前包括QQ,微信,易信,支付宝）进行集中管理，按照功能（目前包括第三方登录,分享,支付）开放给各个产品使用。通过接口的方式进行产品集成，方便对第三方SDK进行升级维护。"
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
pod 'SDVersion', git: 'https://github.com/cguess/SDVersion'
```
LDSDKManager是MCShare的分享能力，由于网易团队不在更新LDSDKManager，LDSDKManager的pod版本已经fork的poholo下并长期维护。
MMPopupView提供弹出pop组件，


## 测试Demo注意事项
```text
手动修改bundleid
AlipayShare com.ldsdk.ldsdkmanager
DingTalk com.laiwang.DTShareKit
```

