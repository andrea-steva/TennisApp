//
//  StringViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 07/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol StringViewModelType: UIContentConfiguration, Hashable {
    var identifier: UUID { get }

    var manufacter: String { get }
    var model: String { get }
    var price: String { get }
    var gauge: String { get }
    var duration: Double { get }
    var tension: Double { get }
    var inUse: Bool { get }
}

struct StringViewModel: StringViewModelType {

    // MARK: UIContentConfiguration

    func makeContentView() -> UIView & UIContentView {
        StringContentView(configuration: self)
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

    let identifier = UUID()

    let manufacter: String
    let model: String
    let price: String
    let gauge: String
    let duration: Double
    let tension: Double
    let inUse: Bool

    init(string: Strings) {
        self.manufacter = string.manufacter
        self.model = string.model
        self.price = String(string.price)
        self.gauge = string.gauge
        self.duration = string.duration
        self.tension = string.tension
        self.inUse = string.inUse
    }
}
