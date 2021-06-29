# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'HR App' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for HR App
pod 'MaterialComponents/BottomAppBar'
pod 'MaterialComponents/BottomNavigation'
pod 'SwiftyJSON', '~> 4.0'
pod 'SVProgressHUD'
pod 'RxSwift', '~> 5'
pod 'Alamofire', '~> 5.2'
pod 'MDFInternationalization'

end

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
end
end
end