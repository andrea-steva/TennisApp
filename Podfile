source 'https://github.com/CocoaPods/Specs.git'

platform :ios, "10.0"

use_frameworks!

def shared_pods

    #Firebase
    pod 'Firebase/Core'
    pod 'Firebase/Auth'
    
    #Facebook
    pod 'FBSDKLoginKit'
    
    #Reactive
    pod 'Bond'

	#Menu
	pod 'RESideMenu', '4.0.7'

	#Networking
	pod 'AlamofireImage', '~> 3.0'
	pod 'Alamofire', '~> 4.0'

	#Form
    pod 'Eureka', '~> 4.0'
	
	#UI
	pod 'FontAwesome.swift'
	pod 'MBProgressHUD', '1.1.0'
	pod 'DZNEmptyDataSet', '1.8.1'
	pod 'IQKeyboardManagerSwift'
	pod 'GSKStretchyHeaderView', '1.0.4'
    pod 'SCLAlertView', :git => 'https://github.com/vikmeup/SCLAlertView-Swift.git', :branch => 'master'
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
