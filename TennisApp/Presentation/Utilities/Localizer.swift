//
//  Localizer.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

/// The localizer class used to get the localized string
final class Localizer {

    func get(_ key: String) -> String {
        var value = NSLocalizedString(key, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        value = value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return value
    }
}

/// The localization keys
struct LocalizationKeys {

    static let appName = "appName"

    static let menuHome = "menu.home"
    static let menuRackets = "menu.rackets"
    static let menuStrings = "menu.strings"
    static let menuStats = "menu.stats"
    static let menuProfile = "menu.profile"
    static let menuSettings = "menu.settings"
    static let menuLogout = "menu.logout"

    static let genericDone = "generic.done"
    static let genericCancel = "generic.cancel"
    static let genericError = "generic.error"
    static let genericOk = "generic.ok"
    static let genericYes = "generic.yes"
    static let genericAlertTitle = "generic.alertTitle"

    static let dialogUnableToLocalize = "dialog.unableToLocalize"
    static let dialogCheckConnection = "dialog.checkConnection"

    static let loginButton = "login.button.title"
    static let signupButton = "signup.button.title"

    static let racketsAddRacket = "rackets.addRacket"

    static let stringsAddString = "strings.addString"
}
