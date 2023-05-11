//
//  UITabBarItem+.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

extension UITabBarItem {
    static func customTabBarItemAppearance(font: UIFont) {
        let appearance = UITabBarItem.appearance()
        appearance.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .highlighted)
        appearance.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
    }
}
