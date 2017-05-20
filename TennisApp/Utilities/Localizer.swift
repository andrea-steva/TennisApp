//
//  Localizer.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

struct LocalizedString {

    static let appName = "appName"

    static let menu_home = "menu.home"
    static let menu_rackets = "menu.rackets"
    static let menu_strings = "menu.strings"
    static let menu_stats = "menu.stats"
    static let menu_profile = "menu.profile"
    static let menu_settings = "menu.settings"
    static let menu_logout = "menu.logout"

    static let generic_done = "generic.done"
    static let generic_cancel = "generic.cancel"
    static let generic_error = "generic.error"
    static let generic_ok = "generic.ok"
    static let generic_yes = "generic.yes"
    static let generic_emptyDataSetTitle = "generic.emptyDataSetTitle"
    static let generic_notAvailable = "generic.notAvailable"
    static let generic_alertTitle = "generic.alertTitle"

    static let dialog_unableToLocalize = "dialog.unableToLocalize"
    static let dialog_checkConnection = "dialog.checkConnection"

    static let login_button = "login.button.title"
    static let signup_button = "signup.button.title"

    static let rackets_addRacket = "rackets.addRacket"
    
    static let strings_addString = "strings.addString"

    static let settings_section1 = "settings.section1"
    static let settings_section2 = "settings.section2"
    static let settings_currency = "settings.currency"
    static let settings_tour = "settings.tour"
    static let settings_support = "settings.support"
    static let settings_website = "settings.website"
    static let settings_version = "settings.version"
}

let localizer = Localizer()

/// The localizer class used to get the localized string
final class Localizer {

    init() {
    }

    func get(_ key: LocalizedString) -> String {
        return self.get(key)
    }

    func get(_ key: String) -> String {
        var value = NSLocalizedString(key, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        value = value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return value
    }
}
