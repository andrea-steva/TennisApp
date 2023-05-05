//
//  Strings.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

/// Strings domain model
struct Strings {
    let identifier: String
    let manufacter: String
    let model: String
    let gauge: String
    let duration: Double
    let tension: Double
    let price: Double
    let inUse: Bool
}

extension Strings {

    init(string: Strings?, formData: [String: Any?]) {
        self.identifier = string?.identifier ?? UUID().uuidString
        self.manufacter = formData[StringForm.Keys.manufacter] as? String ?? ""
        self.model = formData[StringForm.Keys.model] as? String ?? ""
        self.gauge = formData[StringForm.Keys.gauge] as? String ?? ""
        self.duration = formData[StringForm.Keys.duration] as? Double ?? 0
        self.tension = formData[StringForm.Keys.tension] as? Double ?? 0
        self.price = formData[StringForm.Keys.price] as? Double ?? 0
        self.inUse = formData[StringForm.Keys.inUse] as? Bool ?? false
    }
}
