//
//  User.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

/// The user domain model
struct User {
    let identifier: String
    let firstName: String
    let lastName: String
    let age: Int
    let email: String
    let backhandType: String
    let handType: String
    let ranking: String
    let profileImage: Data?
    let isPrimary: Bool

    let rackets: [Racket]
}

extension User {

    init(firstName: String, lastName: String, age: Int, ranking: String) {
        self.identifier = UUID().uuidString
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.email = ""
        self.backhandType = ""
        self.handType = ""
        self.ranking = ranking
        self.profileImage = nil
        self.isPrimary = true
        self.rackets = []
    }
}
