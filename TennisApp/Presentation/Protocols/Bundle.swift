//
//  Bundle.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 14/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol BundleType {
    var appBundleId: String { get }
    var appBuildNumber: String { get }
    var appVersion: String { get }
    var appDisplayName: String { get }}

extension Bundle: BundleType {

    // MARK: External App infos

    var appBundleId: String {
        Bundle.main.bundleIdentifier ?? ""
    }

    var appBuildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }

    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    var appDisplayName: String {
        var displayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
        if displayName == nil {
            displayName = Bundle.main.infoDictionary?["CFBundleName"] as? String
        }
        return displayName ?? ""
    }
}
