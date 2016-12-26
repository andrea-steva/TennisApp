source 'https://github.com/CocoaPods/Specs.git'

platform :ios, "9.0"

# ignore all warnings from all pods
#inhibit_all_warnings!

def shared_pods
	#Crashlytics
	pod 'Fabric'
	pod 'Crashlytics'

	#Mobile Database
	pod 'RealmSwift', '~> 2.0.0'

	#Menu
	pod 'RESideMenu', '~> 4.0.7'

	#Networking
	pod 'AlamofireImage', '~> 3.0'
	pod 'Alamofire', '~> 4.0'

	#Form
	pod 'Eureka', '~> 2.0.0-beta.1'
	
    # Camera View Controller https://github.com/AlexLittlejohn/ALCameraViewController∫
    pod 'ALCameraViewController'

	#UI
	pod 'FontAwesome.swift', '~> 1.0'
	pod 'DZNEmptyDataSet'
	pod 'FormatterKit'
	pod 'MBProgressHUD', '~> 1.0'
	pod 'IQKeyboardManagerSwift'
	pod 'GSKStretchyHeaderView'

	#Charts
	pod 'Charts'
    
	#PagedView
	pod 'PagingMenuController'
    
	#Pull to refresh for tablew view and collection view
	pod 'INSPullToRefresh', '~> 1.0'
end

use_frameworks!

target "TennisApp" do

	shared_pods

end

#post_install do |installer|
#    installer.pods_project.targets.each do |target|
#        target.build_configurations.each do |configuration|
#            configuration.build_settings['SWIFT_VERSION'] = "2.3"
#        end
#    end
#end
