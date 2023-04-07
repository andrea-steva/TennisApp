//
//  UITableView+.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 07/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 25)
        messageLabel.sizeToFit()

        self.isUserInteractionEnabled = false
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.isUserInteractionEnabled = true
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
