#
# Be sure to run `pod lib lint PoporInputCell.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PoporInputCell'
  s.version          = '0.0.16'
  s.summary          = '简化UITableViewCell 设定输入框，按钮等部件。包含大陆号码、钱、银行卡数字格式化。验证码倒计时等。'

  s.homepage         = 'https://github.com/popor/PoporInputCell'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'popor' => '908891024@qq.com' }
  s.source           = { :git => 'https://github.com/popor/PoporInputCell.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.frameworks = 'UIKit', 'Foundation'

  s.source_files = 'Example/Classes/PoporInputCell/*.{h,m}'
  
  s.dependency 'Masonry'
  s.dependency 'PoporFoundation/NSString'
  s.dependency 'PoporUI/UITextField'
  s.dependency 'PoporUI/UITextView'
  
end
