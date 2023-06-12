//
//  LoggerNull.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/03/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

/// A logger profile that does not log
struct LoggerNull: LoggerProfile {

    let loggerProfileId = "com.logger.null"

    func writeLog(
        level: LogLevels,
        message: String,
        subsystem: String,
        category: String,
        file: String,
        line: Int,
        function: String
    ) {}
}
