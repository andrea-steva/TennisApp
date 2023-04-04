//
//  RESideMenuItem.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/03/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

enum RESideMenuItem: Int, CaseIterable {

    case activities = 0
    case rackets = 1
    case stats = 2
    case profile = 3
    case settings = 4
    case logout = 5
    
    func localizedName() -> String {
        switch self {
        case .activities:
            return localizer.get(LocalizedString.menu_home)
        case .rackets:
            return localizer.get(LocalizedString.menu_rackets)
        case .stats:
            return localizer.get(LocalizedString.menu_stats)
        case .profile:
            return localizer.get(LocalizedString.menu_profile)
        case .settings:
            return localizer.get(LocalizedString.menu_settings)
        case .logout:
            return localizer.get(LocalizedString.menu_logout)
        }
    }

    func menuIcon() -> UIImage {
        switch self {
        case .activities:
            return buildImage(name: "house")
        case .rackets:
            return buildImage(name: "gear")
        case .stats:
            return buildImage(name: "chart.bar.fill")
        case .profile:
            return buildImage(name: "person")
        case .settings:
            return buildImage(name: "slider.horizontal.3")
        case .logout:
            return buildImage(name: "person")
        }
    }

    private func buildImage(name: String) -> UIImage {
        let configuration = UIImage.SymbolConfiguration(scale: .medium)
        guard let image = UIImage(systemName: name, withConfiguration: configuration) else {
            return UIImage()
        }
        let tinted = image.withTintColor(.white, renderingMode: .alwaysOriginal)
        return tinted
    }
}
