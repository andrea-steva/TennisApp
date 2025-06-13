//
//  MatchListCell.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

final class MatchListCell: UICollectionViewListCell {

    var match: MatchViewModel?

    override func updateConfiguration(using state: UICellConfigurationState) {
        guard let match else { return }
        let newConfiguration = match.updated(for: state)
        contentConfiguration = newConfiguration
    }
}
