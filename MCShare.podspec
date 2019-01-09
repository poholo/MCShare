Pod::Spec.new do |s|
    s.name             = "MCShare"
    s.version          = "0.0.1"
    s.summary          = "第三方分享组件，依赖于LDSDKManager_IOS(QQ、微信、微博、支付宝、Telegram、钉钉)."
    s.description      = "第三方分享组件，依赖于LDSDKManager_IOS(QQ、微信、微博、支付宝、Telegram、钉钉)."
    s.license          = 'MIT'
    s.author           = { "littleplayer" => "mailjiancheng@163.com" }
    s.homepage         = "https://github.com/poholo/MCShare"
    s.source           = { :git => "https://github.com/poholo/MCShare.git", :tag => s.version.to_s }

    s.platform     = :ios, '8.0'
    s.requires_arc = true


    s.source_files = 'SDK/Config/*.{h,m,mm}' ,
                     'SDK/Models/*.{h,m,mm}',
                     'SDK/Utils/*.{h,m,mm}',
                     'SDK/Vender/Toast/*.{h,m,mm}',
                     'SDK/Utils/*.{h,m,mm}',
                     'SDK/Views/*.{h,m,mm}',
                     'SDK/*.{h,m,mm}'

    s.public_header_files = 'SDK/Config/*.h' ,
                     'SDK/Models/*.h',
                     'SDK/Utils/*.h',
                     'SDK/Vender/Toast/*.h',
                     'SDK/Utils/*.h',
                     'SDK/Views/*.h',
                     'SDK/*.h'

    s.dependency 'LDSDKManager'
    s.dependency 'MMPopupView'
    s.dependency 'SDWebImage'
    s.dependency 'SDVersion'
    s.dependency 'MCStyle', '0.0.6'

end
