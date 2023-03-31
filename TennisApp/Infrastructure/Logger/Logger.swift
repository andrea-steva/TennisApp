//
//  LoggerProfile.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/03/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

/// The logger levels
enum LogLevels: String, CaseIterable {
    case error
    case warn
    case debug
    case info
    case trace
}

protocol Logger {

    /// The list of logger profile
    static var loggers: [LogLevels: [LoggerProfile]] { get set }

    /// Called within the application to write a message to the logs
    ///
    /// - Parameters:
    ///   - logLevel: The log level
    ///   - message: The message
    ///   - file: The file path
    ///   - line: The file line
    ///   - function: The function called
    static func writeLog(logLevel: LogLevels, message: String, file: String, line: Int, function: String)
}

extension Logger {

    static func setLogLevel(logLevel: LogLevels, loggerProfile: LoggerProfile) {
        if loggers[logLevel] != nil {
            if !logLevelContainsProfile(logLevel: logLevel,
                                        loggerProfile: loggerProfile) {
                loggers[logLevel]?.append(loggerProfile)
            }
        } else {
            var array = [LoggerProfile]()
            array.append(loggerProfile)
            loggers[logLevel] = array
        }
    }

    static func logLevelContainsProfile(logLevel: LogLevels, loggerProfile: LoggerProfile) -> Bool {
        if let logProfiles = loggers[logLevel] {
            for logProfile in logProfiles where logProfile.loggerProfileId == loggerProfile.loggerProfileId {
                return true
            }
        }
        return false
    }

    static func addLogProfileToAllLevels( defaultLoggerProfile: LoggerProfile) {
        for level in LogLevels.allCases {
            setLogLevel(logLevel: level, loggerProfile: defaultLoggerProfile)
        }
    }

    static func removeLogProfileFromLevel(logLevel: LogLevels, loggerProfile: LoggerProfile) {
        if var logProfiles = loggers[logLevel] {
            if let index = logProfiles.firstIndex(where: { $0.loggerProfileId == loggerProfile.loggerProfileId }) {
                logProfiles.remove(at: index)
            }
            loggers[logLevel] = logProfiles
        }
    }

    static func removeLogProfileFromAllLevels(loggerProfile: LoggerProfile) {
        for level in LogLevels.allCases {
            removeLogProfileFromLevel(logLevel: level,
                                      loggerProfile: loggerProfile)
        }
    }

    static func hasLoggerForLevel(logLevel: LogLevels) -> Bool {
        if loggers[logLevel] == nil {
            return false
        }
        return true
    }
}
