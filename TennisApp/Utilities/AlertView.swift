//
//  AlertView.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 28/12/2016.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Foundation
import SCLAlertView

// MARK: - Utils Class

class AlertView {
    
    static func showWarning(_ title: String?, message: String, controller: UIViewController) {
        
        var alertTitle = ""
        if title != nil {
            alertTitle = title!
        }
        
        let alertView = SCLAlertView()
        alertView.showWarning(alertTitle, subTitle: message, closeButtonTitle: localizer.get(.generic_ok))
    }
}
