##FAQ 审核问题

- Q:iOS的应用还没有上线苹果商店，是否能够通过审核，涉及如下两种情况
    1.不发布在APP store的应用：
        插件类应用\需越狱方可使用的应用、集团公司内部应用
    2. 还未发布在APP store的应用：
        首次开发集成我们的SDK。
- A:ios和wp应用能否通过审核与此应用是否在商店上线无关，应用信息都可正常填写，也可正常提交审核，内容符合要求可通过审核，为了避免开发者使用此规则作恶，要求应用地址按下面要求填写
    - appstore待审IOS应用请填写URL地址为 http://itunes.apple.com/cn/app/ 
    - WidowsPhone应用商店待审应用请填写URL地址为 http://www.windowsphone.com/zh-CN/store

##FAQ 授权出错

- Q:redirect_uri_mismatch
- A:平台设置和授权Request传递的回调地址（WBAuthorizeRequest.redirectURI） 不一致导致的，必须保证字符完全匹配。

- Q:21338 sso package or sign error
- A:平台设置和项目设置的Bundle id不一致导致的，必须保证字符完全匹配。

- Q:弹出授权窗口后瞬间消失
- A:两个可能
	1、bundle id不一致导致
	2、https://github.com/sinaweibosdk/weibo_ios_sdk/issues/6
	    
- Q:WeiboSDKResponseStatusCodeUnknown               = -100,
- A:检查一下 bundle id设置

##FAQ LinkCard

- Q:什么是LinkCard
- A:http://open.weibo.com/wiki/%E7%A7%BB%E5%8A%A8%E5%AE%A2%E6%88%B7%E7%AB%AF%E6%8E%A5%E5%85%A5
(在微博消息流内,分享一条链接,该链接将解析为包含一个对象数据的特殊短链,且该对象数据可以在微博消息流内显示并交互,这种形态就是微博消息流LinkCard解析。
)

- Q:WBWebpageObject 分享之后不显示缩略图 是什么原因
- A:移动应用商务合作,移动SDK中的LinkCard和附件栏集成分享权限需要合作申请，商务对接请发邮件至：yuqing1@staff.sina.com.cn

- Q:我已经通过了商务合作，仍然不显示Card
- A:请填写平台-应用基本信息中的 安全域名，确定分享的链接处于安全域名之内，方能显示为Card

##FAQ 分享

- Q:分享难道一定要下载新浪微博客户端么？好像不下载返回-4
- A:通过新版的 SDK，第三方应用在分享到微博的时候，可以直接调用新浪官方微博客户端的发布器，分享完成之后再直接返回第三方应用。为了保证没安装官方客户端用户的正常分享需求，过去第三方调用发博接口的方式也将并存。方式为授权取到Token之后，可以通过open API在应用內分享（http://open.weibo.com/wiki/%E5%BE%AE%E5%8D%9AAPI）
@see WeiboSDK WBHttpRequest

##FAQ  平台接口

- Q:SDK用户授权后，如何获得用户的头像等基本信息，好像没有看到API
- A:http://open.weibo.com/wiki/2/users/show , 此外，WBHttpRequest+WeiboUser.h、WBHttpRequest+WeiboShare.h、WBHttpRequest+WeiboToken.h中提供了部分OpenAPI接口的封装，可方便开发者调用。

##授权后不返回应用

- Q:iOSWeiboSDK授权后为什么没有返回应用？
- A:检查配置,info.plist里设置的Scheme是否正确，需要是wb+appkey的形式，详见文档

