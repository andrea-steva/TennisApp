//
//  UIBarButtonItem+.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 07/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    convenience init(iconName: String, selector: Selector, target: Any) {
        // swiftlint:disable:next force_unwrapping
        var icon = UIImage(systemName: iconName)!
        icon = icon.tint(TennisApp.Style.Colors.primaryColor)

        self.init(image: icon,
                  style: UIBarButtonItem.Style.plain,
                  target: target, action: selector)
    }

    static func negativeSpacer(_ width: CGFloat) -> UIBarButtonItem {

        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = width >= 0 ? -width : width
        return spacer
    }
}
