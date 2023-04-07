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
    var identifier: String
    var manufacter: String
    var model: String
    var price: String = ""
    var gauge: String = ""
    var duration: Float = 0
    var tension: Float = 0

    // Add relationships to rackets
}

extension Strings {

    init(form: [String: Any?]) {
        self.identifier = UUID().uuidString
        self.manufacter = form["manufacter"] as? String ?? ""
        self.model = form["model"] as? String ?? ""
        self.price = ""
        self.gauge = ""
        self.duration = 0.0
        self.tension = 0.0
    }

    init(string: Strings, form: [String: Any?]) {
        self.identifier = string.identifier
        self.manufacter = form["manufacter"] as? String ?? ""
        self.model = form["model"] as? String ?? ""
        self.price = ""
        self.gauge = ""
        self.duration = 0.0
        self.tension = 0.0
    }
}
