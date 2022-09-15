//
//  DeveloperToolsLogger.swift
//  Utils
//
//  Created by Petrovich on 07.11.2021.
//

import Foundation
import Pulse

enum LogLevel: String {
    
    case trace = "[Trace 👣]"
    case details = "[Detail ℹ️]"
    case event = "[Event 💬]"
    case warning = "[Warning ⚠️]"
    case error = "[Error ⛔]"
    case critical = "[Critical 🔥]"
    
    static var allValues: [LogLevel] { return [.trace, .details, .event, .warning, .error, .critical] }
}

final class DeveloperToolsLogger {
    
    private enum Constants {
        
        static let dateLogLabel = "Created at "
        static let descriptionLabel = " Description: "
        static let loggedFile = " In file: "
        static let loggedLine = " On line: "
        static let enter = "\n"
    }
    
    private static let loggerStore = LoggerStore.shared
    
    public class func logMessage(_ label: String?, level: LogLevel, message: String) {
        loggerStore.storeMessage(label: label ?? .empty, level: level.externalLevel, message: message)
    }
    
    public class func logRequest(to request: URLRequest, with response: URLResponse, error: Error?, data: Data?) {
        loggerStore.storeRequest(request, response: response, error: error, data: data)
    }
    
    public class func clearLogs() {
        loggerStore.removeAll()
    }
    
    public class func removeAllLogs() {
        try? loggerStore.destroy()
    }
    
    public class func getLogs() -> String {
        guard let messages = try? loggerStore.allMessages() else {
            return .empty
        }
        
        var logCollector: String = .empty
        
        for message in messages {
            logCollector.append(
                Constants.dateLogLabel
                + message.createdAt.description
                + .space
                + convertToLevel(from: message.level)
                + .space
                + message.text
                + Constants.descriptionLabel
                + message.description
                + Constants.loggedFile
                + message.file
                + Constants.loggedLine
                + message.line.description
                + Constants.enter
            )
        }
        
        return logCollector
    }
    
    private class func convertToLevel(from number: Int16) -> String {
        return LoggerStore.Level(rawValue: number)?.defaultLevel.rawValue ?? .empty
    }
}

private extension LogLevel {
    
    var externalLevel: LoggerStore.Level {
        switch self {
        case .trace:
            return .trace
        case .details:
            return .debug
        case .event:
            return .info
        case .warning:
            return .warning
        case .error:
            return .error
        case .critical:
            return .critical
        }
    }
}

private extension LoggerStore.Level {
    
    var defaultLevel: LogLevel {
        switch self {
        case .trace:
            return .trace
        case .debug:
            return .details
        case .info:
            return .event
        case .notice:
            return .event
        case .warning:
            return .warning
        case .error:
            return .error
        case .critical:
            return .critical
        }
    }
}
