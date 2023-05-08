//
//  WorkoutViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol WorkoutViewModelType: UIContentConfiguration, Hashable {
    var name: String { get }
    var notes: String { get }
}

struct WorkoutViewModel: WorkoutViewModelType {

    // MARK: UIContentConfiguration

    func makeContentView() -> UIView & UIContentView {
        WorkoutContentView(configuration: self)
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

    init(workout: Workout) {
        self.name = workout.name
        self.notes = workout.notes
    }
}
