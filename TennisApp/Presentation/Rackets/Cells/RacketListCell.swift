//
//  RacketListCell.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

final class RacketListCell: UICollectionViewListCell {

    var racket: RacketViewModel?

    override func updateConfiguration(using state: UICellConfigurationState) {
        guard let racket else { return }
        let newConfiguration = racket.updated(for: state)
        contentConfiguration = newConfiguration
    }
}
