//
//  FirebaseUser.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 07/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

struct FirebaseUser {
    let providerID: String
    let displayName: String?
    let photoURL: URL?
    let email: String?
}
