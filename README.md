
```text
0.0.1 support cocoapods
0.0.2 support CustomStyle
0.0.3 support Auth & config
0.0.4 微信小程序分享 dev
```

# MCShare
[MCShahre](https://github.com/poholo/MCShare)第三方分享组件，依赖于LDSDKManager_IOS.

## 功能
MCShare是一个iOS分享组件，旨在减少分享模块的开发工作量，包含以下功能：
```text
1 完整的分享UI
2 支持自定义的分享功能
3 集成简单
4 动态域名
5 自定义授权项目(联合登录)
6 自定义分享项目
5 自定义样式(MCStyle)
6 support 2018 devices
7 support auth & configs
8 support 微信小程序分享功能
```

## Screenshot
### 1. Share_Screenshot
<img src="https://github.com/poholo/MCShare/raw/master/ScreenShot/ScreenShot.PNG" width="25%"/>

#### 1.1 MCStyle Support
```text
用MCStyle提供自定义样式，具体参照MCStyle使用规范
```
配色如下

<img src="https://github.com/poholo/MCShare/raw/master/ScreenShot/ScreenShot_MCStyle.png" width="25%"/>

### 2. Auth_Screenshot
![Auth](https://github.com/poholo/MCShare/raw/master/ScreenShot/MCAuth.png)

## 配置方法
### 0. 接入
```text
直接copy SDK/ 目录代码，按照Example接入
or
pod 'MCShare' 按照Example_pod例子接入
```
### 1. 各平台账号秘钥配置
```objectivec
/***账号配置 分享 & 授权***/
    __weak typeof(self) weakSelf = self;
    [MCShareConfig share].socialConfigsCallBack = ^NSArray<MCShareConfigDto *> *(void) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        return [strongSelf configs];
    };
    详细见Appdelegate配置
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


### 4.配置
```objectivec
    /***账号配置 分享 & 授权***/
    __weak typeof(self) weakSelf = self;
    [MCShareConfig share].socialConfigsCallBack = ^NSArray<MCShareConfigDto *> *(void) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        return [strongSelf configs];
    };

    /*** 动态域名*/
    [MCShareConfig share].dynamicHostCallback = ^NSDictionary *(NSString *type) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"DynamicHost" ofType:@"json"];
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:&error];
        NSMutableDictionary *result = [NSMutableDictionary new];
        result[DATA_STATUS] = @( error ? NO : YES);
        result[DATA_CONTENT] = dictionary;
        return result;
    };

    /** 分享展示项***/
    [MCShareConfig share].shareItemsCallBack = ^NSDictionary *(void) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SharePlatform" ofType:@"json"];
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:&error];
        NSMutableDictionary *result = [NSMutableDictionary new];
        result[DATA_STATUS] = @( error ? NO : YES);
        result[DATA_CONTENT] = dictionary;
        return result;
    };

    /** 授权展示项目 ***/
    [MCShareConfig share].socialAuthItemsCallBack = ^NSDictionary *(void) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SocialAuth" ofType:@"json"];
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:&error];
        NSMutableDictionary *result = [NSMutableDictionary new];
        result[DATA_STATUS] = @( error ? NO : YES);
        result[DATA_CONTENT] = dictionary;
        return result;
    };


    // 配置自定义颜色
    [MCStyleManager share].colorStyleDataCallback = ^NSDictionary *(void) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CustomColor" ofType:@"json"];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:nil];
        return dict[@"data"];
    };
    [[MCStyleManager share] loadData];

```

## 使用手册

### 1. 实现回调
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

### 2. 分享能力
```objectivec
ShareDto *shareDto = [ShareDto createShareURL:@"https://github.com/poholo/MCShare"
                                   title:@"LDSDKManager_MCShare"
                                    desc:@"集成的第三方SDK（目前包括QQ,微信,易信,支付宝）进行集中管理，按照功能（目前包括第三方登录,分享,支付）开放给各个产品使用。通过接口的方式进行产品集成，方便对第三方SDK进行升级维护。"
                                   image:@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1903202034,3702680589&fm=55&app=22&f=JPEG?w=121&h=81&s=AD336397508303F1059CBC0D0300E042"
                               pasteText:@""];
shareDto.shareCallback = ^(LDSDKErrorCode code, NSError *error) {
    //这里处理分享结果的回调
};
MCSharePopView *sharePopView = [MCSharePopView new];
[sharePopView shareCommenShareDto:shareDto];
```

### 3.授权能力
```objectivec
MCAuthPopView *authPopView = [MCAuthPopView new];
[authPopView showWithCallBack:^(LDSDKLoginCode code, NSError *error, NSDictionary *oauthInfo, NSDictionary *userInfo) {
    MCLog(@"code %zd error %@ auth %@ user %@", code, error, oauthInfo, userInfo);
}];
```


## 依赖

```
pod 'LDSDKManager' # 由于网易团队不在更新LDSDKManager，LDSDKManager的pod版本已经fork的poholo下并长期维护
pod 'MMPopupView'
pod 'SDWebImage'
pod 'SDVersion', git: 'https://github.com/cguess/SDVersion'
pod 'MCStyle', '0.0.6'
```
LDSDKManager是MCShare的分享能力，由于网易团队不在更新LDSDKManager，LDSDKManager的pod版本已经fork的poholo下并长期维护。
MMPopupView提供弹出pop组件，


## 测试Demo注意事项
```text
手动修改bundleid
AlipayShare com.ldsdk.ldsdkmanager
DingTalk com.laiwang.DTShareKit
```

## License
MCShare under MIT license.
