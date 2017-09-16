source 'https://github.com/CocoaPods/Specs.git'

platform :ios, "9.0"

use_frameworks!

def shared_pods
    
	#Crashlytics
	pod 'Fabric'
	pod 'Crashlytics'
    
    #Firebase
    pod 'Firebase/Core'
    pod 'Firebase/Auth'
    
    #Facebook
    pod 'FBSDKLoginKit', '~> 4.18'

	#Mobile Database
	pod 'RealmSwift', '~> 2.0'
    
    #Reactive
    pod 'Bond', '~> 6.0'

	#Menu
	pod 'RESideMenu', '~> 4.0.7'

	#Networking
	pod 'AlamofireImage', '~> 3.0'
	pod 'Alamofire', '~> 4.0'

	#Form
    pod 'Eureka', :git => 'https://github.com/xmartlabs/Eureka.git', :branch => 'feature/Xcode9-Swift4'
	
    # Camera View Controller https://github.com/AlexLittlejohn/ALCameraViewController∫
    pod 'ALCameraViewController'

	#UI
	pod 'FontAwesome.swift', '~> 1.0'
	pod 'MBProgressHUD', '~> 1.0'
	pod 'DZNEmptyDataSet'
	pod 'IQKeyboardManagerSwift'
	pod 'GSKStretchyHeaderView'
    pod 'SCLAlertView'
    pod 'Tamamushi'
    
	#PagedView
	pod 'PagingMenuController'
    
    #Charts
    pod 'Charts'
    
	#Pull to refresh for tablew view and collection view
	pod 'INSPullToRefresh', '~> 1.0'
    
    #Logger
    pod 'SwiftyBeaver'
end

target "TennisApp" do

	shared_pods

end

target "TennisAppTests" do
    
    shared_pods
    
end
