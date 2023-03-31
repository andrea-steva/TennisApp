//
//  LoggerProfile.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/03/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

/// The logger profile protocol
protocol LoggerProfile {

    /// The logger profile id
    var loggerProfileId: String { get }

    /// Write a log message on the storage provided by the profile
    ///
    /// - Parameters:
    ///   - level: The log level
    ///   - message: The message
    func writeLog(level: String, message: String, file: String, line: Int, function: String)
}

extension LoggerProfile {

    func getCurrentDate() -> String {
        DateFormatter.loggerDateFormatter.string(from: Date())
    }
}

private extension DateFormatter {

    static let loggerDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return dateFormatter
    }()
}
