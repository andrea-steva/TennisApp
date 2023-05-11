//
//  UINavigationBar+.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

extension UINavigationBar {

    static func customNavigationBarAppearance(tintColor: UIColor) {
        let appearance = UINavigationBar.appearance()
        appearance.prefersLargeTitles = true
        appearance.setBackgroundImage(UIImage(), for: .default)
        appearance.shadowImage = UIImage()
        appearance.isTranslucent = true
        appearance.tintColor = tintColor
    }
}
