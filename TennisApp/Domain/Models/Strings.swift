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
    var gauge: String
    var duration: Double
    var tension: Double
    var price: Double
}

extension Strings {

    init(string: Strings?, form: [String: Any?]) {
        self.identifier = string?.identifier ?? UUID().uuidString
        self.manufacter = form["manufacter"] as? String ?? ""
        self.model = form["model"] as? String ?? ""
        self.gauge = form["gauce"] as? String ?? ""
        self.duration = form["duration"] as? Double ?? 0
        self.tension = form["tension"] as? Double ?? 0
        self.price = form["price"] as? Double ?? 0
    }
}
