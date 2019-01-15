#
# Be sure to run `pod lib lint MLRefreshSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MLRefreshSDK'
  s.version          = '0.1.1'
  s.summary          = 'A short description of MLRefreshSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/wangsanyan/MLRefreshSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wangsanyan' => 'valio@mem853.com' }
  s.source           = { :git => 'https://github.com/wangsanyan/MLRefreshSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.source_files = 'MLRefreshSDK/**/*.{h,m}'
  s.public_header_files = 'MLRefreshSDK/**/*.h'
  
  s.resource_bundles = {
    'MLRefreshSDK' => ['MLRefreshSDK/**/*.{png,xml,plist,bundle,xcassets,storyboard,xib,lproj,gif}']
  }



  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'MJRefresh'
  s.dependency 'KWFoundation'
  s.static_framework  =  true

# 先设置tag
# git tag '0.1.1'
#
# 再提交到远程仓库
# git push --tags
#
#校验
#pod spec lint --sources=gitee-vinny-mlspecs,master --allow-warnings --use-libraries
#
# 提交使用命令
# pod repo push gitee-vinny-mlspecs MLRefreshSDK.podspec --sources=gitee-vinny-mlspecs,master --allow-warnings --use-libraries
#
#pod package MLRefreshSDK.podspec --force --no-mangle --spec-sources=https://gitee.com/vinny/MLSpecs.git,https://github.com/CocoaPods/Specs.git
#
end
