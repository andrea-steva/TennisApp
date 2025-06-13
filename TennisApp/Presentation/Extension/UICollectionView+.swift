//
//  UICollectionView+.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

extension UICollectionView {

    func setEmptyMessage(_ message: String, font: UIFont) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = font
        messageLabel.sizeToFit()

        self.isUserInteractionEnabled = false
        self.backgroundView = messageLabel
    }

    func restore() {
        self.isUserInteractionEnabled = true
        self.backgroundView = nil
    }
}
