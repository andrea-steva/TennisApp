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

final class AlertView {

    // MARK: Properties

    static let localizer = Localizer()

    static let appearance = SCLAlertView.SCLAppearance(
        kTitleFont: Style.Fonts.get(.regular, size: .extraLarge),
        kTextFont: Style.Fonts.get(.regular, size: .normal),
        kButtonFont: Style.Fonts.get(.bold, size: .large),
        showCloseButton: true
    )

    static func showWarning(_ title: String?, message: String, controller: UIViewController) {
        var alertTitle = localizer.get(LocalizationKeys.genericAlertTitle)
        if let title {
            alertTitle = title
        }
        let alertView = SCLAlertView(appearance: appearance)
        alertView.showWarning(alertTitle, subTitle: message, closeButtonTitle: localizer.get(LocalizationKeys.genericOk), animationStyle: .noAnimation)
    }

    static func showConfirm(_ title: String?, message: String, completionBlock: @escaping (_ userCancelAction: Bool) -> Void) {
        var alertTitle = localizer.get(LocalizationKeys.genericAlertTitle)
        if let title {
            alertTitle = title
        }

        let alertView = SCLAlertView(appearance: appearance)

        alertView.addButton(localizer.get(LocalizationKeys.genericOk), backgroundColor: Style.Colors.courtHardB) {
            completionBlock(false)
        }
        alertView.addButton(localizer.get(LocalizationKeys.genericCancel), backgroundColor: Style.Colors.courtHardB) {
            completionBlock(true)
        }

        alertView.showInfo(alertTitle, subTitle: message, animationStyle: .noAnimation)
    }
}
