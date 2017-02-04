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

    static let appearance = SCLAlertView.SCLAppearance(
        kTitleFont: Style.Fonts.get(.regular, size: .extraLarge),
        kTextFont: Style.Fonts.get(.regular, size: .normal),
        kButtonFont: Style.Fonts.get(.bold, size: .large),
        showCloseButton: false
    )

    static func showWarning(_ title: String?, message: String, controller: UIViewController) {

        var alertTitle = localizer.get(LocalizedString.generic_alertTitle)
        if title != nil {
            alertTitle = title!
        }

        let alertView = SCLAlertView(appearance: appearance)
        alertView.showWarning(alertTitle, subTitle: message, closeButtonTitle: localizer.get(LocalizedString.generic_ok), animationStyle: .noAnimation)
    }

    static func showConfirm(_ title: String?, message: String, completionBlock :@escaping (_ userCancelAction: Bool) -> Void) {

        var alertTitle = localizer.get(LocalizedString.generic_alertTitle)
        if title != nil {
            alertTitle = title!
        }

        let alertView = SCLAlertView(appearance: appearance)

        alertView.addButton(localizer.get(LocalizedString.generic_ok), backgroundColor: Style.Colors.courtHardB) {
            completionBlock(false)
        }
        alertView.addButton(localizer.get(LocalizedString.generic_cancel), backgroundColor: Style.Colors.courtHardB) {
            completionBlock(true)
        }

        alertView.showInfo(alertTitle, subTitle: message, animationStyle: .noAnimation)
    }
}
