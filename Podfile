source 'https://github.com/CocoaPods/Specs.git'

platform :ios, "8.0"

# ignore all warnings from all pods
#inhibit_all_warnings!

def shared_pods
	#Crashlytics
	pod 'Fabric', '~> 1.5'
	pod 'Crashlytics'

	#Mobile Database
	pod 'RealmSwift', '~> 0.98'

	#ReatciveCocoa    
	pod 'ReactiveCocoa', '~> 4.0'

	#Menu
	pod 'RESideMenu', '~> 4.0.7'

	#Networking
	pod 'AlamofireImage', '~> 2.0'
	pod 'Alamofire', '~> 3.1'

	#Form
	pod 'Eureka', :git => 'https://github.com/xmartlabs/Eureka', :branch => 'swift2.3'
	
    # Camera View Controller https://github.com/AlexLittlejohn/ALCameraViewController∫
    pod 'ALCameraViewController'

	#UI
	pod 'FontAwesome.swift', '~> 0.6'
	pod 'DZNEmptyDataSet'
	pod 'FormatterKit'
	pod 'MBProgressHUD', '~> 0.8'
	pod 'IQKeyboardManagerSwift'
	pod 'SWTableViewCell', '~> 0.3'
	pod 'GSKStretchyHeaderView'
    pod 'ASProgressHud'
    
	#Charts
	pod 'Charts', :git => 'https://github.com/danielgindi/Charts', :branch => 'Swift-2.3'
    
	#PagedView
	pod 'PagingMenuController' , '0.9.1'
    
	#Pull to refresh for tablew view and collection view
	pod 'INSPullToRefresh', '~> 1.0'
end

use_frameworks!

target "TennisApp" do

	shared_pods

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |configuration|
            configuration.build_settings['SWIFT_VERSION'] = "2.3"
        end
    end
end
