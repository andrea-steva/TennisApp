source 'https://github.com/CocoaPods/Specs.git'

platform :ios, "13.0"

use_frameworks!

def shared_pods

  #Firebase
  pod 'Firebase/Core'
  pod 'Firebase/Auth'

	pod 'RESideMenu', '4.0.7'
	pod 'FontAwesome.swift'
	pod 'GSKStretchyHeaderView', '1.0.4'
	pod 'PagingMenuController', :git => 'https://github.com/andr3a88/PagingMenuController.git'
	pod 'INSPullToRefresh', '1.2.0'
  pod 'SCLAlertView', :git => 'https://github.com/vikmeup/SCLAlertView-Swift.git', :branch => 'master'

end

target "TennisApp" do

	shared_pods

end

target "TennisAppTests" do
    
    shared_pods
    
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
         end
    end
  end
end

