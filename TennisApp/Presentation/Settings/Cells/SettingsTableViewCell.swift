//
//  SettingsTableViewCell.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {

    // MARK: Reuse Identifier

    static let reuseIdentifier = String(describing: SettingsTableViewCell.self)

    // MARK: View Management

    override func awakeFromNib() {
        super.awakeFromNib()

        textLabel?.font = Fonts.get(.regular, size: .normal)
    }

    func setup(settings: SettingsItem) {
        imageView?.image = UIImage(systemName: settings.iconName)
        imageView?.tintColor = Colors.primaryColor
        textLabel?.text = settings.title
    }
}
