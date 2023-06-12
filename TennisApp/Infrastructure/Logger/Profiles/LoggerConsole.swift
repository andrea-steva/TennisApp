//
//  LoggerConsole.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/03/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import OSLog

/// A logger profile that log on the console
final class LoggerConsole: LoggerProfile {

    let loggerProfileId = "shopfully.logger.console"

    private var loggers: [String: Logger] = [:]

    func writeLog(
        level: LogLevels,
        message: String,
        subsystem: String,
        category: String,
        file: String,
        line: Int,
        function: String
    ) {
        let logger = getLoggerForSubsystem(subsystem: subsystem, category: category)

        switch level {
        case .error:
            logger.error("🔴 \(message)")
        case .warn:
            logger.warning("⚠️ \(message)")
        case .debug:
            logger.debug("⚪️ \(message)")
        case .info:
            logger.info("🔵 \(message)")
        case .trace:
            logger.trace("🟧 \(message)")
        }
    }

    private func getLoggerForSubsystem(subsystem: String, category: String) -> Logger {
        guard let logger = self.loggers[subsystem] else {
            let newLogger = Logger(subsystem: subsystem, category: category)
            self.loggers[subsystem] = newLogger
            return newLogger
        }
        return logger
    }
}
