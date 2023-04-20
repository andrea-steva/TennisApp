//
//  RacketCellViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 07/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol RacketCellViewModelType {
    var manufacter: String { get }
    var model: String { get }
    var weight: Int32 { get }
    var gripSize: GripSize { get }
    var image: Data? { get }
    var purchaseDate: Date? { get }
    var strings: [Strings] { get }
}

final class RacketCellViewModel: RacketCellViewModelType {

    let manufacter: String
    let model: String
    let weight: Int32
    let gripSize: GripSize
    let image: Data?
    let purchaseDate: Date?
    let strings: [Strings]

    init(racket: Racket) {
        self.manufacter = racket.manufacter
        self.model = racket.model
        self.weight = racket.weight
        self.gripSize = racket.gripSize
        self.image = racket.image
        self.purchaseDate = racket.purchaseDate
        self.strings = racket.strings
    }
}
