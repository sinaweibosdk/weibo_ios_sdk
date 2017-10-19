# WeiboSDK-iOS

为了方便第三方开发者快速集成微博 SDK，我们提供了以下联系方式，协助开发者进行集成：  

**QQ 群：453830884（iOS 请加此群）**
**226214250（此群已满）**
**263989257（此群已满）**  
**284084420（此群已满）**  
**邮箱：sdk4wb@sina.cn**  
**微博：移动新技术**  

另外，关于 SDK 的 Bug 反馈、用户体验、以及好的建议，请大家尽量提交到 Github 上，我们会尽快解决。  
目前，我们正在逐步完善微博 SDK，争取为第三方开发者提供一个规范、简单易用、可靠、可扩展、可定制的 SDK，敬请期待。

## 概述

微博 iOS 平台 SDK 为第三方应用提供了简单易用的微博 API 调用服务，使第三方客户端无需了解复杂的验证机制即可进行授权登陆，并提供微博分享功能，可直接通过微博官方客户端分享微博。

## 快速集成

WeiboSDK 支持使用 CocoaPods 集成，请在 Podfile 中添加以下语句：

```
pod "Weibo_SDK", :git => "https://github.com/sinaweibosdk/weibo_ios_sdk.git" 
```

## API 文档

[http://sinaweibosdk.github.io/weibo_ios_sdk/index.html](http://sinaweibosdk.github.io/weibo_ios_sdk/index.html)

## 常见问题 FAQ

[https://github.com/sinaweibosdk/weibo_ios_sdk/blob/master/FAQ.md](https://github.com/sinaweibosdk/weibo_ios_sdk/blob/master/FAQ.md)

## 名词解释

| 名词        | 注解    | 
| --------    | :-----  | 
| AppKey      | 分配给每个第三方应用的 App Key。用于鉴权身份，显示来源等功能。|
| RedirectURI | 应用回调页面，可在新浪微博开放平台->我的应用->应用信息->高级应用->授权设置->应用回调页中找到。|
| AccessToken | 表示用户身份的 token，用于微博 API 的调用。| 
| Expire in   | 过期时间，用于判断登录是否过期。| 

## 功能列表

#### 1. 认证授权

为开发者提供 Oauth 2.0 授权认证，并集成 SSO 登录功能。

#### 2. 微博分享

从第三方应用分享信息到微博，目前只支持通过微博官方客户端进行分享。

#### 3. 登入登出

微博登入按钮主要是简化用户进行 SSO 登陆，实际上，它内部是对 SSO 认证流程进行了简单的封装。  
微博登出按钮主要提供一键登出的功能，帮助开发者主动取消用户的授权。

## 适用范围

使用此 SDK 需满足以下条件：  

- 在新浪微博开放平台注册并创建应用
- 已定义本应用的授权回调页  
- 已选择应用为 iOS 平台，并正确填写 Bundle ID 和 Apple ID

注：关于授权回调页对移动客户端应用来说对用户是不可见的，所以定义为何种形式都将不影响，但是没有定义将无法使用 SDK 认证登录。建议使用默认回调页 [https://api.weibo.com/oauth2/default.html](https://api.weibo.com/oauth2/default.html)。

## iOS 9 的适配问题

由于 iOS 9 的发布影响了微博 SDK 与应用的集成方式，为了确保好的应用体验，我们需要采取如下措施：

#### 1.对传输安全的支持

在新一代的 iOS 系统中，默认需要为每次网络传输建立 SSL。解决这个问题有两种方法：

- A.建立白名单并添加到你的 App 的 plsit 中
- 
	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSExceptionDomains</key>
		<dict>
			<key>sina.cn</key>
			<dict>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
				<false/>
			</dict>
			<key>weibo.cn</key>
			<dict>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
				<false/>
			</dict>
			<key>weibo.com</key>
			<dict>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
				<true/>
				<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
				<false/>
			</dict>
			<key>sinaimg.cn</key>
			<dict>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
				<true/>
				<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
				<false/>
			</dict>
			<key>sinajs.cn</key>
			<dict>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
				<true/>
				<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
				<false/>
			</dict>
			<key>sina.com.cn</key>
			<dict>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
				<true/>
				<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
				<false/>
			</dict>
		</dict>
	</dict>

如果没有添加可能会遇到“An SSL error has occurred and a secure connection to
the server cannot be made.“这样的问题。

- B.强制将 NSAllowsArbitraryLoads 属性设置为 YES，并添加到你应用的 plist 中
- 
	<key>NSAppTransportSecurity</key>
	<dict>
	<key>NSAllowsArbitraryLoads</key>
	</true>
	</dict>

#### 2.对应用跳转的支持

如果你需要用到微博的相关功能，如登陆，分享等。并且需要实现跳转到微博的功能，在 iOS 9 系统中就需要在你的 App 的 plist 中添加下列键值对。否则在 canOpenURL 函数执行时，就会返回 NO。了解详情请至[https://developer.apple.com/videos/wwdc/2015/?id=703](https://developer.apple.com/videos/wwdc/2015/?id=703)。

-
	<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>sinaweibohd</string>
		<string>sinaweibo</string>
		<string>weibosdk</string>
		<string>weibosdk2.5</string>
	</array>

#### 3.应用瘦身与 Bitcode

苹果在 iOS 9 的 SDK 中添加了对应用的瘦身的支持，其中就包括 Bitcode。我们也在最新的代码中添加了对 Bitcode 的支持。

## 关于 ADSupport 集成的问题

关于第三方应用开发者是否集成 ADSupport.framework 的问题：
 
1. 如果开发者希望集成 ADSupport.framework，在进行 IPA 提交 Store 时候勾选用于跟踪用户广告效果的选项即可。具体操作可参照友盟
[http://bbs.umeng.com/forum.php?mod=viewthread&tid=6242&aid=1611&from=album&page=1&mobile=2](http://bbs.umeng.com/forum.php?mod=viewthread&tid=6242&aid=1611&from=album&page=1&mobile=2)；

2. 如果开发者希望不集成 ADSupport.framework，直接删去即可，微博 SDK 的使用并非强制要求第三方开发者集成 ADSupport.framework。不集成 ADSupport.framework 不会影响 WeiboSDK 的正常使用。

## 关于 ipv6 支持的问题

由于苹果商店 6 月 1 日起，强制 App 需要支持 ipv6-only 的网络。微博 SDK 这边也做了支持，更新了使用的底层网络代码，包括 Reachability 库。

## iOS 10 的适配问题

由于 iOS 10 的发布，原有 ATS 设置在 iOS 10 上会出现 HTTPS 网络访问限制的问题，为了确保好的应用体验，我们需要采取如下措施：

-
	<key>sina.com.cn</key>
	<dict>
		<key>NSIncludesSubdomains</key>
		<true/>
		<key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
		<true/>
		<key>NSExceptionMinimumTLSVersion</key>
		<string>TLSv1.0</string>
		<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
		<false/>
	</dict>

需要在每一个域名下添加 NSExceptionMinimumTLSVersion 这样的 Key，值的部分为 TLSv1.0。

## 3.2.0 版本更新

微博移动 SDK 3.2，围绕“分享＋连接”这个核心主题，面向开发者，规划的主要功能模块只有 4 个：SDK 初始化、用微博帐号登录、分享到微博、连接到微博。其他的功能已经转移，下线或在未来不久的版本即将下线。具体变动的功能如下：

1. 热评与关系化组件下线；
2. 私信分享功能，私信应用推荐功能下线；
3. SDK 不再包装访问 openAPI 的接口，SDK 对外提供的网络访问工具 WBHttpRequest 也将逐步下线，开发者微博后期使用微博 openAPI 接口时，需要使用自己网络模块并按照平台的接口文档进行调用；
4. 短信注册登录功能下线；
5. 多媒体分享功能整体修改，在微博客户端 7.5.0 后的版本，分享到发布器的多媒体对象将不再以 Link Card 显示，转而以文本链接的形式插入到分享的文本中。（该功能的修改不会影响到分享内容在信息里的显示，凡是经过商务对接的第三方，发出去的多媒体对象在信息流中就会显示 Link Card）并且该功能在后期会进一步修改。

同时在新的 SDK 中还有部分功能未完善，会在近期的版本更新中逐步完善：

1. 由于部分 H5 模块针对 TLS 1.2 的支持还有问题，所以目前 SDK 的 ATS 还不能完全打开；
2. 连接到微博的功能还有部分不太完善，将在后期的版本中逐步修改。

## 3.2.1 版本更新

微博移动 SDK 3.2.1，精简了原有的统计功能，更新原有的分享功能，使分享功能更加丰富。具体的变动如下：

1. 统计功能调整，预计后期以组件的形式提供；
2. 原有图片分享功能由粘贴板单图的形式，扩展为相册多图，视频的模式；
3. 新增分享到 Story 功能，形式为单图或视频。
