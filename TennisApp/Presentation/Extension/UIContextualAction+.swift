//
//  UIContextualAction+.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

extension UIContextualAction {

    func setTitle(title: String, font: UIFont, textColor: UIColor = .white) {
        let label = UILabel()
        label.text = title
        label.textColor = textColor
        label.font = font
        label.sizeToFit()
        self.image = UIImage(view: label)
    }
}
