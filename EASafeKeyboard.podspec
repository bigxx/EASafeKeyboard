#
#  Be sure to run `pod spec lint EASafeKeyboard.podspec" to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "EASafeKeyboard"
  spec.version      = "1.0.6"
  spec.summary      = "自定义安全键盘"
  spec.platform     = :ios, "8.0"
  spec.frameworks   = "Foundation"
  spec.description  = "自定义的安全键盘，数字键盘随机生成"
  spec.homepage     = "https://github.com/bigxx/EASafeKeyboard"
  spec.license      = "MIT"
  spec.author       = { "bigxx" => "305506026@qq.com" }
  spec.ios.deployment_target = "8.0"
  spec.source       = { :git => "https://github.com/bigxx/EASafeKeyboard.git", :tag => "#{spec.version}" }
  spec.source_files = "EASafeKeyboard", "EASafeKeyboard/**/*.{h,m}"
  spec.resources    = "EASafeKeyboard/Help/EASafeKeyboard.bundle"

end
