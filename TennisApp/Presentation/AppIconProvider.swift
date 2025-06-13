//
//  AppIconProvider.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 28/08/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

enum AppIconProvider {
    static func appIcon(in bundle: Bundle = .main) -> String {

        guard let icons = bundle.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
              let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
              let iconFileName = iconFiles.last else {
            fatalError("Could not find icons in bundle")
        }

        return iconFileName
    }
}
