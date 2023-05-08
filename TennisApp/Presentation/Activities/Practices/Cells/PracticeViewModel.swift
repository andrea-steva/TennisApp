//
//  PracticeViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol PracticeViewModelType: UIContentConfiguration, Hashable {
    var name: String { get }
    var notes: String { get }
}

struct PracticeViewModel: PracticeViewModelType {

    // MARK: UIContentConfiguration

    func makeContentView() -> UIView & UIContentView {
        PracticeContentView(configuration: self)
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

    init(practice: Practice) {
        self.name = practice.name
        self.notes = practice.notes
    }
}
