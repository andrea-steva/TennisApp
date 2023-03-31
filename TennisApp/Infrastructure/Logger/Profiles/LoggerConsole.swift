//
//  LoggerConsole.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/03/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

/// A logger profile that log on the console
struct LoggerConsole: LoggerProfile {

    let loggerProfileId = "shopfully.logger.console"

    func writeLog(level: String, message: String, file: String, line: Int, function: String) {
        let now = getCurrentDate()
        print("\(now) \(getIcon(level)) \(level.uppercased()): \(message)")
    }

    private func getIcon(_ level: String) -> String {
        var icon = ""
        switch level {
        case "debug":
            icon = "⚪️"
        case "info":
            icon = "🔵"
        case "warn":
            icon = "⚠️"
        case "error":
            icon = "🔴"
        case "trace":
            icon = "🟧"
        default:
            icon = ""
        }
        return icon
    }
}
