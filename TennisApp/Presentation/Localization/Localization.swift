//
//  Localization.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol Localized {
    associatedtype Strings
}

struct Localization {
    struct App {
        static let appName = "appName".localized
    }

    struct Menu {
        static let activities = "menu.activities".localized
        static let rackets = "menu.rackets".localized
        static let strings = "menu.strings".localized
        static let stats = "menu.stats".localized
        static let profile = "menu.profile".localized
        static let settings = "menu.settings".localized
    }

    static let match = "match".localized
    static let practice = "practice".localized
    static let workout = "workout".localized

    static let genericDone = "generic.done".localized
    static let genericCancel = "generic.cancel".localized
    static let genericError = "generic.error".localized
    static let genericOk = "generic.ok".localized
    static let genericYes = "generic.yes".localized
    static let genericAlertTitle = "generic.alertTitle".localized
    static let logout = "logout".localized

    static let dialogUnableToLocalize = "dialog.unableToLocalize".localized
    static let dialogCheckConnection = "dialog.checkConnection".localized

    static let loginButton = "login.button.title".localized
    static let signupButton = "signup.button.title".localized

    static let racketsAddRacket = "rackets.addRacket".localized
    static let stringsAddString = "strings.addString".localized
}

private extension String {

    /// Localize the string
    var localized: String {
        NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }

    /// Get localized string with parameters
    /// - Parameter args: The parameters
    /// - Returns: The localized string
    func localized(_ args: CVarArg...) -> String {
        String(format: NSLocalizedString(self, comment: ""), arguments: args)
    }
}
