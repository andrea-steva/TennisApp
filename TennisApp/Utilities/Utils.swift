//
//  Utils.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import EventKit
import PassKit
import Alamofire
import AlamofireImage
import FontAwesome_swift


//MARK: - Menu Item

enum MenuItem : Int {
    
    case Home = 0
    case Rackets = 1
    case Stats = 2
    case Profile = 3
    case Settings = 4
    
    static var count: Int { return MenuItem.Settings.rawValue + 1}
    
    func storyboardName() -> String {
        switch self {
        case .Home:
            return "Home"
        case .Rackets:
            return "Rackets"
        case .Stats:
            return "Stats"
        case .Profile:
            return "Profile"
        case .Settings:
            return "Settings"
        }
    }
    
    func localizedName() -> String {
        switch self {
        case .Home:
            return localizer.get(LocalizerKey.menu_home)
        case .Rackets:
            return localizer.get(LocalizerKey.menu_rackets)
        case .Stats:
            return localizer.get(LocalizerKey.menu_stats)
        case .Profile:
            return localizer.get(LocalizerKey.menu_profile)
        case .Settings:
            return localizer.get(LocalizerKey.menu_settings)
        }
    }
    
    func menuIcon() -> UIImage {
        
        let size = CGSizeMake(35, 35)
        let color  = Style.Colors.lightColor.colorWithAlphaComponent(0.8)
        
        switch self {
        case .Home:
            return UIImage.fontAwesomeIconWithName(.Home, textColor: color, size: size)
        case .Rackets:
            return UIImage.fontAwesomeIconWithName(.Rocket, textColor: color, size: size)
        case .Stats:
            return UIImage.fontAwesomeIconWithName(.BarChartO, textColor: color, size: size)
        case .Profile:
            return UIImage.fontAwesomeIconWithName(.User, textColor: color, size: size)
        case .Settings:
            return UIImage.fontAwesomeIconWithName(.Cogs, textColor: color, size: size)
        }
        
    }
}

//MARK: - Utils Class

class Utils {
    
    static let AppName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleDisplayName")
    static let AppBuildVersion = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleVersion")
    static let AppVersion = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString")
    
    /**
     Get screen bounds for the device. I needed this helper function that kept the same Screen Bounds for both iOS7 under iOS8.
     On iOS8 [UIScreen mainScreen].bounds  is interface-oriented while on iOS7 isn't
     
     - returns: The screen bounds
     */
    static func getScreenBounds() -> CGRect {
        
        var bounds = UIScreen.mainScreen().bounds
        if (UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)) {
            bounds.size = CGSizeMake(bounds.size.height, bounds.size.width);
        }
        return bounds;
    }
    
    //MARK: HUD - Network activity indicator
    
    static func setNetworkActivityIndicator(active : Bool) {
        dispatch_async(dispatch_get_main_queue(),{
            UIApplication.sharedApplication().networkActivityIndicatorVisible = active
        })
    }
    
    /**
     Show Default HUD on view
     
     - parameter view: The view where to show the HUD
     */
    static func showHUD(view : UIView) {
        dispatch_async(dispatch_get_main_queue(),{
            let hudProperty = HudProperty(prefixName: "loader_clear", frameNumber: 30, backgroundColor: UIColor.whiteColor())
            ASProgressHud.showCustomHUDAddedTo(view, animated: true, hudProperty: hudProperty)
        })
    }
    
    /**
     Hide Default HUD on view
     
     - parameter view: The view where to hide the HUD
     */
    static func hideHUD(view : UIView) {
        dispatch_async(dispatch_get_main_queue(),{
            ASProgressHud.hideAllHUDsForView(view, animated: true)
        })
    }
    
    //MARK: UIImageView Setter
    
    /**
    Set rounded image on image view with user placeholder
    
    - parameter imageUrl:  Image url
    - parameter imageView: Image view
    */
    static func setAvatarImage(imageUrl : String?, imageView: UIImageView) {
        Utils.setImage(imageUrl, placeholder: "user_placeholder", cornerRadius: imageView.frame.size.width/2, imageView: imageView)
    }
    
    /**
     Set an image from url on a image view.
     
     - parameter imageUrl:  Image url
     - parameter placeholder: Placeholder image name, default quad_placeholder
     - parameter cornerRadius: The corners radius applied to the image. Default 0
     - parameter imageView: ImageView
     */
    static func setImage(imageUrl : String?, placeholder : String = "quad_placeholder", cornerRadius : CGFloat = 0, imageView: UIImageView) {
        
        guard let imageUrl = imageUrl else {
            imageView.image = UIImage(named: placeholder)
            return
        }
        
        let URL = NSURL(string: imageUrl)!
        let placeholderImage = UIImage(named: placeholder)!
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
            size: imageView.frame.size,
            radius: cornerRadius
        )
        
        imageView.af_setImageWithURL(
            URL,
            placeholderImage: placeholderImage,
            filter: cornerRadius > 0 ? filter : nil,
            imageTransition: .CrossDissolve(0.2)
        )
    }
    
    //MARK: Parallax Effect
    
    static func parallaxEffect(value : Int) -> UIMotionEffectGroup {
        
        // Set vertical effect
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = Int(-value)
        verticalMotionEffect.maximumRelativeValue = Int(value)
        
        // Set horizontal effect
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = Int(-value)
        horizontalMotionEffect.maximumRelativeValue = Int(value)
        
        let motionGroup = UIMotionEffectGroup()
        motionGroup.motionEffects = [verticalMotionEffect,horizontalMotionEffect]
        return motionGroup
    }
    
    static func roundCorners(corners : UIRectCorner, radius : CGFloat, view : UIView) {
        
        let bounds = view.bounds
        
        //Bezier path with round rectangular path
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSizeMake(radius, radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.CGPath
        
        view.layer.mask = maskLayer
        
        let frameLayer = CAShapeLayer()
        frameLayer.frame = bounds
        frameLayer.path = maskPath.CGPath
        frameLayer.fillColor = nil
        
        view.layer.addSublayer(frameLayer)
    }
    
    static func getOverlayFrame(frame : CGRect, alpha : CGFloat) -> UIView {
        
        let overlay = UIView(frame: CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height))
        overlay.backgroundColor = UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: alpha)
        return overlay
    }
    
    static func applyBlur(view : UIView, style : UIBlurEffectStyle) {
        let blurStyle = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurStyle)
        blurView.frame = view.bounds
        blurView.alpha = 0.8
        view.addSubview(blurView)
    }
    
    
    //MARK: Local notification
    
    
    /**
    Send local notification with message
    
    - parameter message: The notification message
    - parameter fireDate: The fire date
    */
    static func sendLocalNotification(message : String, fireDate: NSDate) {
        
        let localNotification = UILocalNotification()
        
        localNotification.fireDate = fireDate
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.alertBody = message
        localNotification.soundName = UILocalNotificationDefaultSoundName
        
        let app = UIApplication.sharedApplication()
        localNotification.applicationIconBadgeNumber = app.applicationIconBadgeNumber + 1
        
        app.presentLocalNotificationNow(localNotification)
    }
    
    
    //MARK: Storyboard
    
    static func getControllerFromStoryboard(storyboard : String, controllerId : String? = nil)  -> UIViewController {
        
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        if let controllerId = controllerId {
            return storyboard.instantiateViewControllerWithIdentifier(controllerId)
        }
        return storyboard.instantiateInitialViewController()!
    }
    
    //MARK: EventStore Utils
    
    static func addEvent(eventDate : NSDate, title : String, notes : String, completion : Bool -> ()) {
        let eventStore = EKEventStore()
        
        eventStore.requestAccessToEntityType(.Event) { (granted, error) -> Void in
            if error == nil {
                
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.notes = notes
                event.startDate = eventDate
                event.endDate = eventDate.dateByAddingTimeInterval(30*60)
                event.calendar = eventStore.defaultCalendarForNewEvents
                
                do {
                    try eventStore.saveEvent(event, span: EKSpan.ThisEvent)
                } catch {
                    completion(false)
                }
                completion(true)
            }
            completion(false)
        }
    }
    
    
    //MARK: FileManager Utils
    
    static let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
    static let fileManager = NSFileManager.defaultManager()
    
    /**
     Save file on Documents folder
     
     - parameter filename: File name with extension
     - parameter folder:   Folder ex folder1/folder2 or folder1
     - parameter data:     Data to save
     */
    static func saveFile(filename : String, folder : String, data : NSData) -> Bool {
        
        let relativePath = "/\(folder)/\(filename)"
        let filePath = documentsPath.stringByAppendingString(relativePath)
        
        NSLog("filePath: \(filePath)")
        if (fileManager.isWritableFileAtPath(filePath)) {
            NSLog("Writable");
        } else {
            NSLog("Not Writable");
        }
        return data.writeToFile(filePath, atomically: true)
    }
    
    /**
     Determinates if a file exists at the given path
     
     - parameter filename: File name with extensions or path (eg: file.txt or folder/file.txt)
     - parameter folder:   Folder ex folder1/folder2 or folder1
     
     - returns: Boolean value indicating if the file exists
     */
    static func existsFile(filename : String, folder : String) -> Bool {
        
        let relativePath = "/\(folder)/\(filename)"
        let filePath = documentsPath.stringByAppendingString(relativePath)
        return fileManager.fileExistsAtPath(filePath)
    }
    
    /**
     Delete file with name
     
     - parameter filename: File name with extensions or path (eg: file.txt or folder/file.txt)
     - parameter folder:   Folder ex folder1/folder2 or folder1
     
     - returns: The result for the operation
     */
    static func deleteFile(filename : String, folder : String) -> Bool {
        
        let relativePath = "/\(folder)/\(filename)"
        let filePath = documentsPath.stringByAppendingString(relativePath)
        
        do {
            try fileManager.removeItemAtPath(filePath)
            return true
        } catch {
            return false
        }
    }
    
    /**
     Get file from file manager
     
     - parameter filename:   File name plus extension
     - parameter folder: Relative path from Documents directory "folder1/folder2/folderN"
     */
    static func getFile(filename : String, folder : String) -> NSData? {
        
        let relativePath = "/\(folder)/\(filename)"
        let data = NSData(contentsOfFile: documentsPath.stringByAppendingString(relativePath))
        return data
        
    }
    
    /**
     List file on a folder
     
     - parameter folderName: Folder name
     
     
     - returns: The array of string with the filename of the files on the folder
     */
    static func listFile(folderName : String) -> [String]? {
        
        let folderPath = "/\(documentsPath)/\(folderName)"
        
        do {
            let fileArray = try fileManager.contentsOfDirectoryAtPath(folderPath)
            return fileArray
        } catch {
            return nil
        }
        
        
    }
    
    /**
     Create folder in documents directory (http://nshipster.com/nsfilemanager/)
     
     - parameter folderName: Folder name
     */
    static func createDocumentsFolderWithName(folderName : String) -> Bool {
        
        let folderPath = (documentsPath as NSString).stringByAppendingPathComponent(folderName)
        if !fileManager.fileExistsAtPath(folderPath) {
            do {
                try fileManager.createDirectoryAtPath(folderPath, withIntermediateDirectories: false, attributes: nil)
                return true
            } catch {
                return false
            }
            
        }
        return true
    }
    
    //MARK: Alert Controller
    
    /**
    Present a generic alert controller with Confirm and Cancel action
    
    - parameter title:           The title for the alert controller
    - parameter message:         The message for the alert controller
    - parameter controller:      The view controller in which present the alert
    - parameter completionBlock: The user completion block
    */
    static func alertController(title : String?, message : String?, controller: UIViewController, completionBlock :(userCancelAction : Bool) -> () ) {
        
        var alertTitle = ""
        if title?.characters.count > 0 {
            alertTitle = title!
        }
        
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .Alert)
        
        let actionConfirm = UIAlertAction(title: localizer.get(.generic_ok), style: .Default) { (alertAction) -> Void in
            controller.dismissViewControllerAnimated(true, completion: nil)
            completionBlock(userCancelAction: false)
        }
        
        let actionCancel = UIAlertAction(title: localizer.get(.generic_cancel), style: .Cancel ) { (alertAction) -> Void in
            controller.dismissViewControllerAnimated(true, completion: nil)
            completionBlock(userCancelAction: true)
        }
        
        alertController.addAction(actionConfirm)
        alertController.addAction(actionCancel)
        controller.presentViewController(alertController, animated: true, completion: nil)
    }
    
    static func alertController(title : String?, message : String?, controller: UIViewController) {
        
        var alertTitle = ""
        if title?.characters.count > 0 {
            alertTitle = title!
        }
        
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .Alert)
        
        let actionConfirm = UIAlertAction(title: localizer.get(.generic_ok), style: .Default) { (alertAction) -> Void in
            controller.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(actionConfirm)
        controller.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: Dispatch After
    
    static func dispatchAfter(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}

//MARK: - Generic UIKit subclass

/// Label with custom edge insets, default value 10.0 for left and right, 0 for top and bottom
class INSLabel : UILabel {
    
    var leftInset : CGFloat = 10.0
    var topInset : CGFloat = 0.0
    var rightInset : CGFloat = 10.0
    var bottomInset : CGFloat = 0.0
    
    override func drawTextInRect(rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
}

