//
//  PracticeListCell.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

final class PracticeListCell: UICollectionViewListCell {

    var practice: PracticeListCell?

    override func updateConfiguration(using state: UICellConfigurationState) {
        guard let practice else { return }
//        let newConfiguration = match.updated(for: state)
//        contentConfiguration = newConfiguration
    }
}
