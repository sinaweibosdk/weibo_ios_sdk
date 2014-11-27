# ReadMe
为了方便第三方开发者快速集成微博 SDK，我们提供了以下联系方式，协助开发者进行集成：  
**QQ群：226214250（iOS 请加此群）**
**263989257（此群已满）**  
**284084420（此群已满）**  
**邮箱：sdk4wb@sina.cn**  
**微博：移动新技术**  
另外，关于SDK的Bug反馈、用户体验、以及好的建议，请大家尽量提交到 Github 上，我们会尽快解决。  
目前，我们正在逐步完善微博 SDK，争取为第三方开发者提供一个规范、简单易用、可靠、可扩展、可定制的 SDK，敬请期待。

# 概述
微博 iOS 平台 SDK 为第三方应用提供了简单易用的微博API调用服务，使第三方客户端无需了解复杂的验证机制即可进行授权登陆，并提供微博分享功能，可直接通过微博官方客户端分享微博。

#API文档
[http://sinaweibosdk.github.io/weibo_ios_sdk/index.html](http://sinaweibosdk.github.io/weibo_ios_sdk/index.html)

#常见问题 FAQ
[https://github.com/sinaweibosdk/weibo_ios_sdk/blob/master/FAQ.md](https://github.com/sinaweibosdk/weibo_ios_sdk/blob/master/FAQ.md)
# 名词解释
| 名词        | 注解    | 
| --------    | :-----  | 
| AppKey      | 分配给每个第三方应用的 app key。用于鉴权身份，显示来源等功能。|
| RedirectURI | 应用回调页面，可在新浪微博开放平台->我的应用->应用信息->高级应用->授权设置->应用回调页中找到。|
| AccessToken | 表示用户身份的 token，用于微博 API 的调用。| 
| Expire in   | 过期时间，用于判断登录是否过期。| 

# 功能列表
### 1. 认证授权
为开发者提供 Oauth2.0 授权认证，并集成 SSO 登录功能。
### 2. 微博分享
从第三方应用分享信息到微博，目前只支持通过微博官方客户端进行分享。
### 3. 登入登出
微博登入按钮主要是简化用户进行 SSO 登陆，实际上，它内部是对 SSO 认证流程进行了简单的封装。  
微博登出按钮主要提供一键登出的功能，帮助开发者主动取消用户的授权。
### 4.OpenAPI通用调用
OpenAPI通用调用接口，帮助开发者访问开放平台open api(http://open.weibo.com/wiki/微博API)
此外，还提供了一系列封装了open api调用的接口，方便开发者使用。
### 5. 社会化评论服务、原生关注组件
提供社会化评论按钮和原生关注按钮，简化用户进行关注以及评论的流程。
# 适用范围
使用此SDK需满足以下条件:  

- 在新浪微博开放平台注册并创建应用
- 已定义本应用的授权回调页  
- 已选择应用为iOS平台，并正确填写Bundle id和appple id

注: 关于授权回调页对移动客户端应用来说对用户是不可见的，所以定义为何种形式都将不影响，但是没有定义将无法使用SDK认证登录。建议使用默认回调页 https://api.weibo.com/oauth2/default.html 
