//
//  StringListCell.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

final class StringListCell: UICollectionViewListCell {

    var string: StringViewModel?

    override func updateConfiguration(using state: UICellConfigurationState) {
        guard let string else { return }
        let newConfiguration = string.updated(for: state)
        contentConfiguration = newConfiguration
    }
}
