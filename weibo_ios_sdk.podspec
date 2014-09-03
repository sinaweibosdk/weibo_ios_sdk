Pod::Spec.new do |s|
  s.name         = "weibo_ios_sdk"
  s.version      = "2.4.2.0.1"
  s.source       = { :git => "https://github.com/shiguol/weibo_ios_sdk.git", :tag => "2.4.2.0.1" }
  s.platform     = :ios, '5.0'
  s.requires_arc = true
  s.source_files = 'libWeiboSDK/*.{h,m}'
  s.resources = 'libWeiboSDK/WeiboSDK.bundle'
  s.vendored_libraries  = 'libWeiboSDK/libWeiboSDK.a'
end
