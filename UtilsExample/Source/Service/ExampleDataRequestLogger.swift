//
//  ExampleDataRequestLogger.swift
//  UtilsExample
//
//  Created by Николай on 16.09.2022.
//

import Foundation
import Utils

class ExampleDataRequestLogger: DataRequestLogger {
    
    override func printLogs(_ logs: String) {
        DeveloperToolsLogger.logMessage(label: "Data Request Logger", level: .event, message: logs)
    }
}
