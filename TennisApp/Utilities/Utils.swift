//
//  Utils.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Alamofire
import AlamofireImage
import EventKit
import MBProgressHUD
import PassKit
import UIKit

private func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

private func > <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

// MARK: - Utils Class

class Utils {

    static let AppName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName")
    static let AppBuildVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")
    static let AppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
    
    /**
     Get screen bounds for the device. I needed this helper function that kept the same Screen Bounds for both iOS7 under iOS8.
     On iOS8 [UIScreen mainScreen].bounds  is interface-oriented while on iOS7 isn't
     
     - returns: The screen bounds
     */
    static func getScreenBounds() -> CGRect {

        var bounds = UIScreen.main.bounds
        if UIApplication.shared.statusBarOrientation.isLandscape {
            bounds.size = CGSize(width: bounds.size.height, height: bounds.size.width)
        }
        return bounds
    }

    // MARK: HUD - Network activity indicator

    /**
     Show HUD on view
     
     - parameter view: The view where to show the HUD
     */
    static func showHUD(view: UIView) {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: view, animated: true)
        }
    }

    /**
     Hide HUD on view
     
     - parameter view: The view where to hide the HUD
     */
    static func hideHUD(view: UIView) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }

    static func setNetworkActivityIndicator(_ active: Bool) {
        DispatchQueue.main.async(execute: {
            UIApplication.shared.isNetworkActivityIndicatorVisible = active
        })
    }

    // MARK: UIImageView Setter

    /**
    Set rounded image on image view with user placeholder
    
    - parameter imageUrl:  Image url
    - parameter imageView: Image view
    */
    static func setAvatarImage(_ imageUrl: String?, imageView: UIImageView) {
        Utils.setImage(imageUrl, placeholder: "user_placeholder", cornerRadius: imageView.frame.size.width / 2, imageView: imageView)
    }

    /**
     Set an image from url on a image view.
     
     - parameter imageUrl:  Image url
     - parameter placeholder: Placeholder image name, default quad_placeholder
     - parameter cornerRadius: The corners radius applied to the image. Default 0
     - parameter imageView: ImageView
     */
    static func setImage(_ imageUrl: String?, placeholder: String = "quad_placeholder", cornerRadius: CGFloat = 0, imageView: UIImageView) {

        guard let imageUrl = imageUrl else {
            imageView.image = UIImage(named: placeholder)
            return
        }

        let URL = Foundation.URL(string: imageUrl)!
        let placeholderImage = UIImage(named: placeholder)!
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
            size: imageView.frame.size,
            radius: cornerRadius
        )

        imageView.af_setImage(
            withURL: URL,
            placeholderImage: placeholderImage,
            filter: cornerRadius > 0 ? filter : nil,
            imageTransition: .crossDissolve(0.2)
        )
    }

    // MARK: Parallax Effect

    static func parallaxEffect(_ value: Int) -> UIMotionEffectGroup {

        // Set vertical effect
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = Int(-value)
        verticalMotionEffect.maximumRelativeValue = Int(value)

        // Set horizontal effect
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = Int(-value)
        horizontalMotionEffect.maximumRelativeValue = Int(value)

        let motionGroup = UIMotionEffectGroup()
        motionGroup.motionEffects = [verticalMotionEffect, horizontalMotionEffect]
        return motionGroup
    }

    static func roundCorners(_ corners: UIRectCorner, radius: CGFloat, view: UIView) {

        let bounds = view.bounds

        //Bezier path with round rectangular path
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))

        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath

        view.layer.mask = maskLayer

        let frameLayer = CAShapeLayer()
        frameLayer.frame = bounds
        frameLayer.path = maskPath.cgPath
        frameLayer.fillColor = nil

        view.layer.addSublayer(frameLayer)
    }

    static func getOverlayFrame(_ frame: CGRect, alpha: CGFloat) -> UIView {

        let overlay = UIView(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height))
        overlay.backgroundColor = UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: alpha)
        return overlay
    }

    static func applyBlur(_ view: UIView, style: UIBlurEffect.Style) {
        let blurStyle = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurStyle)
        blurView.frame = view.bounds
        blurView.alpha = 0.8
        view.addSubview(blurView)
    }

    // MARK: Local notification

    /**
    Send local notification with message
    
    - parameter message: The notification message
    - parameter fireDate: The fire date
    */
    static func sendLocalNotification(_ message: String, fireDate: Date) {

        let localNotification = UILocalNotification()

        localNotification.fireDate = fireDate
        localNotification.timeZone = TimeZone.current
        localNotification.alertBody = message
        localNotification.soundName = UILocalNotificationDefaultSoundName

        let app = UIApplication.shared
        localNotification.applicationIconBadgeNumber = app.applicationIconBadgeNumber + 1

        app.presentLocalNotificationNow(localNotification)
    }

    // MARK: Storyboard

    static func getControllerFromStoryboard(_ storyboard: String, controllerId: String? = nil) -> UIViewController {

        let storyboard = UIStoryboard(name: storyboard, bundle: nil)

        if let controllerId = controllerId {
            return storyboard.instantiateViewController(withIdentifier: controllerId)
        }
        return storyboard.instantiateInitialViewController()!
    }

    // MARK: EventStore Utils

    static func addEvent(_ eventDate: Date, title: String, notes: String, completion : @escaping (Bool) -> Void) {
        let eventStore = EKEventStore()

        eventStore.requestAccess(to: .event) { (granted, error) -> Void in
            if error == nil {

                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.notes = notes
                event.startDate = eventDate
                event.endDate = eventDate.addingTimeInterval(30 * 60)
                event.calendar = eventStore.defaultCalendarForNewEvents

                do {
                    try eventStore.save(event, span: EKSpan.thisEvent)
                } catch {
                    completion(false)
                }
                completion(true)
            }
            completion(false)
        }
    }

    // MARK: FileManager Utils

    static let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    static let fileManager = FileManager.default

    /**
     Save file on Documents folder
     
     - parameter filename: File name with extension
     - parameter folder:   Folder ex folder1/folder2 or folder1
     - parameter data:     Data to save
     */
    static func saveFile(_ filename: String, folder: String, data: Data) -> Bool {

        let relativePath = "/\(folder)/\(filename)"
        let filePath = documentsPath + relativePath

        NSLog("filePath: \(filePath)")
        if fileManager.isWritableFile(atPath: filePath) {
            NSLog("Writable")
        } else {
            NSLog("Not Writable")
        }
        return ((try? data.write(to: URL(fileURLWithPath: filePath), options: [.atomic])) != nil)
    }

    /**
     Determinates if a file exists at the given path
     
     - parameter filename: File name with extensions or path (eg: file.txt or folder/file.txt)
     - parameter folder:   Folder ex folder1/folder2 or folder1
     
     - returns: Boolean value indicating if the file exists
     */
    static func existsFile(_ filename: String, folder: String) -> Bool {

        let relativePath = "/\(folder)/\(filename)"
        let filePath = documentsPath + relativePath
        return fileManager.fileExists(atPath: filePath)
    }

    /**
     Delete file with name
     
     - parameter filename: File name with extensions or path (eg: file.txt or folder/file.txt)
     - parameter folder:   Folder ex folder1/folder2 or folder1
     
     - returns: The result for the operation
     */
    static func deleteFile(_ filename: String, folder: String) -> Bool {

        let relativePath = "/\(folder)/\(filename)"
        let filePath = documentsPath + relativePath

        do {
            try fileManager.removeItem(atPath: filePath)
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
    static func getFile(_ filename: String, folder: String) -> Data? {

        let relativePath = "/\(folder)/\(filename)"
        let data = try? Data(contentsOf: URL(fileURLWithPath: documentsPath + relativePath))
        return data

    }

    /**
     List file on a folder
     
     - parameter folderName: Folder name
     
     
     - returns: The array of string with the filename of the files on the folder
     */
    static func listFile(_ folderName: String) -> [String]? {

        let folderPath = "/\(documentsPath)/\(folderName)"

        do {
            let fileArray = try fileManager.contentsOfDirectory(atPath: folderPath)
            return fileArray
        } catch {
            return nil
        }

    }

    /**
     Create folder in documents directory (http://nshipster.com/nsfilemanager/)
     
     - parameter folderName: Folder name
     */
    static func createDocumentsFolderWithName(_ folderName: String) -> Bool {

        let folderPath = (documentsPath as NSString).appendingPathComponent(folderName)
        if !fileManager.fileExists(atPath: folderPath) {
            do {
                try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: false, attributes: nil)
                return true
            } catch {
                return false
            }

        }
        return true
    }

    // MARK: Alert Controller

    /**
    Present a generic alert controller with Confirm and Cancel action
    
    - parameter title:           The title for the alert controller
    - parameter message:         The message for the alert controller
    - parameter controller:      The view controller in which present the alert
    - parameter completionBlock: The user completion block
    */
    static func alertController(_ title: String, message: String?, controller: UIViewController, completionBlock: @escaping (_ userCancelAction: Bool) -> Void ) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let actionConfirm = UIAlertAction(title: localizer.get(LocalizedString.generic_ok), style: .default) { (alertAction) -> Void in
            controller.dismiss(animated: true, completion: nil)
            completionBlock(false)
        }

        let actionCancel = UIAlertAction(title: localizer.get(LocalizedString.generic_cancel), style: .cancel ) { (alertAction) -> Void in
            controller.dismiss(animated: true, completion: nil)
            completionBlock(true)
        }

        alertController.addAction(actionConfirm)
        alertController.addAction(actionCancel)
        controller.present(alertController, animated: true, completion: nil)
    }

    static func alertController(_ title: String, message: String?, controller: UIViewController) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let actionConfirm = UIAlertAction(title: localizer.get(LocalizedString.generic_ok), style: .default) { (alertAction) -> Void in
            controller.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(actionConfirm)
        controller.present(alertController, animated: true, completion: nil)
    }

    // MARK: Dispatch After

    static func dispatchAfter(_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}

// MARK: - Generic UIKit subclass

/// Label with custom edge insets, default value 10.0 for left and right, 0 for top and bottom
class INSLabel: UILabel {

    var leftInset: CGFloat = 10.0
    var topInset: CGFloat = 0.0
    var rightInset: CGFloat = 10.0
    var bottomInset: CGFloat = 0.0

    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
}
