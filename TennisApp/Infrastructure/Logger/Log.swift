//
//  Log.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/03/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

struct Log: LoggerType {

    static var loggers = [LogLevels: [LoggerProfile]]()

    static func writeLog(
        logLevel: LogLevels,
        message: String,
        subsystem: String,
        category: String,
        file: String,
        line: Int,
        function: String
    ) {
        guard hasLoggerForLevel(logLevel: logLevel) else {
            print("No logger")
            return
        }
        if let logProfiles = loggers[logLevel] {
            for logProfile in logProfiles {
                logProfile.writeLog(
                    level: logLevel,
                    message: message,
                    subsystem: subsystem,
                    category: category,
                    file: file,
                    line: line,
                    function: function
                )
            }
        }
    }

    static func error(
        _ message: String,
        subsystem: String = "Default",
        category: String = "Default",
        file: String = #file,
        line: Int = #line,
        function: String = #function
    ) {
        writeLog(
            logLevel: .error,
            message: message,
            subsystem: subsystem,
            category: category,
            file: file,
            line: line,
            function: function
        )
    }

    static func warn(
        _ message: String,
        subsystem: String = "Default",
        category: String = "Default",
        file: String = #file,
        line: Int = #line,
        function: String = #function
    ) {
        writeLog(
            logLevel: .warn,
            message: message,
            subsystem: subsystem,
            category: category,
            file: file,
            line: line,
            function: function
        )
    }

    static func debug(
        _ message: String,
        subsystem: String = "Default",
        category: String = "Default",
        file: String = #file,
        line: Int = #line,
        function: String = #function
    ) {
        writeLog(
            logLevel: .debug,
            message: message,
            subsystem: subsystem,
            category: category,
            file: file,
            line: line,
            function: function
        )
    }

    static func info(
        _ message: String,
        subsystem: String = "Default",
        category: String = "Default",
        file: String = #file,
        line: Int = #line,
        function: String = #function
    ) {
        writeLog(
            logLevel: .info,
            message: message,
            subsystem: subsystem,
            category: category,
            file: file,
            line: line,
            function: function
        )
    }

    static func trace(
        _ message: String,
        subsystem: String = "Default",
        category: String = "Default",
        file: String = #file,
        line: Int = #line,
        function: String = #function
    ) {
        writeLog(
            logLevel: .trace,
            message: message,
            subsystem: subsystem,
            category: category,
            file: file,
            line: line,
            function: function
        )
    }

    static func initialize(
    ) {
        Log.addLogProfileToAllLevels(
            defaultLoggerProfile: LoggerConsole(
            )
        )
    }
}
