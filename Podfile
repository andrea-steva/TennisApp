source 'https://github.com/CocoaPods/Specs.git'

platform :ios, "10.0"

use_frameworks!

def shared_pods

    pod 'LifetimeTracker'
    
	#Crashlytics
	pod 'Fabric'
	pod 'Crashlytics'
    
    #Firebase
    pod 'Firebase/Core'
    pod 'Firebase/Auth'
    
    #Facebook
    pod 'FBSDKLoginKit'
    
    #Reactive
    pod 'Bond', '~> 6.0'

	#Menu
	pod 'RESideMenu', '4.0.7'

	#Networking
	pod 'AlamofireImage', '~> 3.0'
	pod 'Alamofire', '~> 4.0'

	#Form
    pod 'Eureka', '~> 4.0'
	
    # Camera View Controller https://github.com/AlexLittlejohn/ALCameraViewController∫
    pod 'ALCameraViewController', '3.0.3'

	#UI
	pod 'FontAwesome.swift', '1.3.2'
	pod 'MBProgressHUD', '1.1.0'
	pod 'DZNEmptyDataSet', '1.8.1'
	pod 'IQKeyboardManagerSwift'
	pod 'GSKStretchyHeaderView', '1.0.4'
    pod 'SCLAlertView', :git => 'https://github.com/vikmeup/SCLAlertView-Swift.git'
    pod 'Tamamushi', '0.1.3'
    
	#PagedView
	pod 'PagingMenuController', :git => 'https://github.com/andr3a88/PagingMenuController.git'
    
    #Charts
    pod 'Charts', '~> 3.0'
    
	#Pull to refresh for table view and collection view
	pod 'INSPullToRefresh', '1.2.0'
    
    #Logger
    pod 'SwiftyBeaver', '~> 1.0'
end

target "TennisApp" do

	shared_pods

end

target "TennisAppTests" do
    
    shared_pods
    
end
