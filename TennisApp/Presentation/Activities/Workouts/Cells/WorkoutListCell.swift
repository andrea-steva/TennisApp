//
//  WorkoutListCell.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

final class WorkoutListCell: UICollectionViewListCell {

    var workout: WorkoutListCell?

    override func updateConfiguration(using state: UICellConfigurationState) {
        guard let workout else { return }
//        let newConfiguration = match.updated(for: state)
//        contentConfiguration = newConfiguration
    }
}
