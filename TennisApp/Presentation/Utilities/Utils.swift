//
//  Utils.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import EventKit
import MBProgressHUD
import UIKit

// MARK: - Utils Class

class Utils {

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
