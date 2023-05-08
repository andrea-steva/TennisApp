//
//  MatchViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol MatchViewModelType: UIContentConfiguration, Hashable {
    var name: String { get }
    var notes: String { get }
}

struct MatchViewModel: MatchViewModelType {
    // MARK: UIContentConfiguration

    func makeContentView() -> UIView & UIContentView {
        MatchContentView(configuration: self)
    }

    func updated(for state: UIConfigurationState) -> Self {
        // Perform update on parameters that does not related to cell's data itesm
        guard let state = state as? UICellConfigurationState else {
            return self
        }

        let updatedConfiguration = self
        if state.isSelected {
        } else {
        }

        return updatedConfiguration
    }

    // MARK: Properties

    let name: String
    let notes: String

    init(match: Match) {
        self.name = match.name
        self.notes = match.notes
    }
}
