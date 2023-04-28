//
//  StringCellViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 07/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol StringCellViewModelType {
    var manufacter: String { get }
    var model: String { get }
    var price: String { get }
    var gauge: String { get }
    var duration: Double { get }
    var tension: Double { get }
    var inUse: Bool { get }
}

final class StringCellViewModel: StringCellViewModelType {

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
