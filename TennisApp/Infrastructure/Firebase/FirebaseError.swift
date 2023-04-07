//
//  FirebaseError.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 07/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

enum FirebaseError: Error {
    case error
}

extension FirebaseError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .error:
            return "Firebase Error"
        }
    }

    /// Optional failure reason
    var failureReason: String? { nil }

    /// Optional recovery suggestion
    var recoverySuggestion: String? { nil }
}
