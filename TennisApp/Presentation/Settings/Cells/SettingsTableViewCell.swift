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

    // MARK: Properties

    private let designLibrary: DesignLibraryProvider = DesignLibrary()

    // MARK: View Management

    override func awakeFromNib() {
        super.awakeFromNib()

        textLabel?.font = designLibrary.font.textNormalSize.regular
    }

    func setup(settings: SettingsItem) {
        imageView?.image = UIImage(systemName: settings.iconName)
        imageView?.tintColor = designLibrary.color.text.brandPrimary
        textLabel?.text = settings.title
    }
}
