////
////  DeveloperToolsLogger.swift
////  Utils
////
////  Created by Petrovich on 07.11.2021.
////
//
//import Foundation
//
//// MARK: - LogLevel
//
//enum LogLevel: String {
//    
//    case details  = "[ℹ️]"
//    case event    = "[💬]"
//    case error    = "[⚠️]"
//    case critical = "[🔥]"
//    
//    static var allValues: [LogLevel] { return [.details, .event, .error, .critical] }
//    
//    // MARK: - Public methods
//    
//    init(value: Int) {
//        switch value {
//        case 0  : self = .details
//        case 1  : self = .event
//        case 2  : self = .error
//        case 3  : self = .critical
//        default : self = .details
//        }
//    }
//}
//
//// MARK: - DeveloperToolsLogger
//
//final class DeveloperToolsLogger {
//    
//    // MARK: - Public properties
//    
//    static var isEnabled: Bool = false
//    
//    private(set) public static var logOnRelease: Bool = false
//    private(set) public static var writeToFile: Bool = false
//    private(set) public static var shouldAppend: Bool = false
//    
//    public static let filePath: String = FileManager.getPath(to: "Logs")
//    public static var isLogingEnabled: Bool { return DeveloperToolsLogger.isEnabled }
//    public static var isAlreadySetup: Bool = false
//    public static let loggerStore = LoggerStore.shared
//    // MARK: - Private properties
//    
//    private static let consoleLogDestinationKey: String = "LogManager.console"
//    private static let fileLogDestinationKey: String = "LogManager.file"
//    
//    fileprivate static let lineStartKey: String = "ǁ"
//    fileprivate static let logger: XCGLogger = XCGLogger(identifier: "LogManager", includeDefaultDestinations: false)
//    fileprivate static var collectedLogs: String = ""
//    public static let swiftLogger = Logging.Logger(label: "test")
//    
//    fileprivate static var levelsDescriptions = [
//        XCGLogger.Level.verbose: LogLevel.details.rawValue,
//        XCGLogger.Level.info: LogLevel.event.rawValue,
//        XCGLogger.Level.error: LogLevel.error.rawValue,
//        XCGLogger.Level.severe: LogLevel.critical.rawValue
//    ]
//    
//    // MARK: - Public methods
//    
//    public class func setup(logOnRelease: Bool = false, writeToFile: Bool = false, shouldAppend: Bool = false) {
//        loggerStore.storeMessage(label: "setup", level: .info, message: "info from setup")
//        swiftLogger.info("swiftLogger")
//
//        logger.remove(destinationWithIdentifier: consoleLogDestinationKey)
//        logger.remove(destinationWithIdentifier: fileLogDestinationKey)
//        
//        self.logOnRelease = logOnRelease
//        self.writeToFile  = writeToFile
//        self.shouldAppend = shouldAppend
//        
//        addWritingToConsole()
//        
//        if writeToFile {
//            addWritingToFile(shouldAppend: shouldAppend)
//        }
//        
//        isAlreadySetup = true
//        logger.logAppDetails()
//    }
//    
//    public class func clear() {
//        collectedLogs = ""
//    }
//    
//    public class func collectedLogs(_ types: [LogLevel] = LogLevel.allValues) -> String {
//        return filteredLogs(collectedLogs, levels: types)
//    }
//    
//    public class func lastLogs(_ types: [LogLevel] = LogLevel.allValues, number: Int = 1) -> [String] {
//        return splitLogs(with: collectedLogs, levels: types).suffix(number)
//    }
//    
//    public class func fileLogs(_ types: [LogLevel] = LogLevel.allValues) -> String? {
//        guard writeToFile else { return nil }
//        
//        if let rawLogs = try? String(contentsOf: URL(fileURLWithPath: filePath), encoding: .utf8) {
//            return filteredLogs(rawLogs, levels: types)
//        } else {
//            return nil
//        }
//    }
//    
//    // MARK: - Private methods
//    
//    private class func addWritingToConsole() {
//        let console: BaseQueuedDestination = FormattedConsoleDestination(identifier: consoleLogDestinationKey)
//        
//        console.outputLevel       = .verbose
//        console.showLogIdentifier = false
//        console.showFunctionName  = true
//        console.showThreadName    = false
//        console.showLevel         = true
//        console.showFileName      = true
//        console.showLineNumber    = true
//        console.showDate          = true
//        console.levelDescriptions = levelsDescriptions
//        
//        logger.add(destination: console)
//    }
//    
//    private class func addWritingToFile(shouldAppend: Bool) {
//        let file = FormattedFileDestination(
//            
//            writeToFile  : DeveloperToolsLogger.filePath,
//            identifier   : fileLogDestinationKey,
//            shouldAppend : shouldAppend
//        )
//        
//        file.outputLevel       = .verbose
//        file.showLogIdentifier = false
//        file.showFunctionName  = true
//        file.showThreadName    = true
//        file.showLevel         = true
//        file.showFileName      = true
//        file.showLineNumber    = true
//        file.showDate          = true
//        file.logQueue          = XCGLogger.logQueue
//        file.levelDescriptions = levelsDescriptions
//        
//        logger.add(destination: file)
//    }
//    
//    private class func splitLogs(with rawLogs: String, levels: [LogLevel]) -> [String] {
//        let levelTags: [String] = levels.map { $0.rawValue }
//        return rawLogs.components(separatedBy:lineStartKey).filter { levelTags.contains(where: $0.contains) }
//    }
//    
//    private class func filteredLogs(_ rawLogs: String, levels: [LogLevel]) -> String {
//        return splitLogs(with: rawLogs, levels: levels).joined(separator: "")
//    }
//    
//    fileprivate class func log(
//        
//        _ level  : LogLevel,
//        message  : String,
//        function : StaticString = #function,
//        file     : StaticString = #file,
//        line     : Int          = #line
//    ) {
//        if isAlreadySetup == false { setup() }
//        
//        if collectedLogs.count + message.count >= NSIntegerMax {
//            collectedLogs = (collectedLogs as NSString).substring(from: NSIntegerMax/2)
//        }
//        
//        if DeveloperToolsLogger.isLogingEnabled {
//            
//            switch level {
//                
//            case .details  : logger.verbose(message, functionName: function, fileName: file, lineNumber: line)
//            case .event    : logger.info(message, functionName: function, fileName: file, lineNumber: line)
//            case .error    : logger.error(message, functionName: function, fileName: file, lineNumber: line)
//            case .critical : logger.severe(message, functionName: function, fileName: file, lineNumber: line)
//            }
//        }
//    }
//}
//
//// MARK: - Log
//
//final class Log: NSObject {
//    
//    // MARK: - Public methods
//    
//    @available(*, deprecated, message: "Please use details/event/error/critical instead") public class func show(
//        
//        _ message  : String,
//        function : StaticString = #function,
//        file     : StaticString = #file,
//        line     : Int          = #line
//    ) {
//        
//        details(message, function: function, file: file, line: line)
//    }
//    
//    /// Used to log all the detailed information like an API JSON response or file path, etc.
//    public class func details(
//        _ message: String,
//        function: StaticString = #function,
//        file: StaticString = #file,
//        line: Int = #line
//    ) {
//        DeveloperToolsLogger.log(.details, message: message, function: function, file: file, line: line)
//    }
//    
//    /// Used to log all the significant events like a gesture recognition or user authorization success or any other.
//    public class func event(
//        _ message: String,
//        function: StaticString = #function,
//        file: StaticString = #file,
//        line: Int = #line
//    ) {
//        DeveloperToolsLogger.log(.event, message: message, function: function, file: file, line: line)
//    }
//    
//    /// Used to log any non-critical error, like a wrong user password or http request timeout.
//    public class func error(
//        _ message: String,
//        function: StaticString = #function,
//        file: StaticString = #file,
//        line: Int = #line
//    ) {
//        DeveloperToolsLogger.log(.error, message: message, function: function, file: file, line: line)
//    }
//    
//    /// Used to log any critical error, which occuring requires special attention.
//    public class func critical(
//        _ message: String,
//        function: StaticString = #function,
//        file: StaticString = #file,
//        line: Int = #line
//    ) {
//        DeveloperToolsLogger.log(.critical, message: message, function: function, file: file, line: line)
//    }
//}
//
//// MARK: - FormattedFileDestination
//
//class FormattedFileDestination: FileDestination {
//    
//    override func process(logDetails: LogDetails) {
//        formattedProcess(logDetails)
//    }
//}
//
//// MARK: - FormattedConsoleDestination
//
//class FormattedConsoleDestination: BaseQueuedDestination {
//    
//    // MARK: - Override properties
//    
//    // Setter is ignored, NSLog adds the date, so we always want showDate to be false in this subclass
//    override var showDate: Bool {
//        get { return isNSLog == false }
//        // swiftlint:disable:next unused_setter_value
//        set { print("showDate parameter not set") }
//    }
//    
//    // MARK: - Private properties
//    
//    fileprivate var isNSLog: Bool {
//#if DEBUG
//        return false
//#else
//        return DeveloperToolsLogger.logOnRelease == true
//#endif
//    }
//    
//    // MARK: - Override methods
//    
//    override func write(message: String) {
//        DeveloperToolsLogger.collectedLogs = message + "\n" + DeveloperToolsLogger.collectedLogs
//        
//        let cleanMessage = message.replace(pattern: DeveloperToolsLogger.lineStartKey)
//        
//        if isNSLog == true {
//            NSLog("%@", cleanMessage)
//        } else {
//            print(cleanMessage)
//        }
//    }
//    
//    override func process(logDetails: LogDetails) {
//        formattedProcess(logDetails)
//    }
//}
//
//extension BaseQueuedDestination {
//    
//    // MARK: - Private methods
//    
//    fileprivate func formattedProcess(_ logDetails: LogDetails) {
//        guard let owner = owner else { return }
//        
//        var extendedDetails: String = "\n\(DeveloperToolsLogger.lineStartKey)\n"
//        
//        if showDate {
//            if let formatter = owner.dateFormatter {
//                extendedDetails += "\(formatter.string(from: logDetails.date))"
//            } else {
//                extendedDetails += "\(logDetails.date.description)\n"
//            }
//        }
//        
//        if showLogIdentifier {
//            extendedDetails += "[\(owner.identifier)] "
//        }
//        
//        if showFunctionName {
//            extendedDetails += "\(logDetails.functionName) "
//        }
//        
//        if showFileName {
//            let lineNumber = showLineNumber ? ":" + String(logDetails.lineNumber) : ""
//            extendedDetails += "[\((logDetails.fileName as NSString).lastPathComponent)\((lineNumber))] "
//        } else if showLineNumber {
//            extendedDetails += "[\(logDetails.lineNumber)] "
//        }
//        
//        if showThreadName {
//            extendedDetails += "[\(threadName())] "
//        }
//        
//        var level = ""
//        
//        if showLevel {
//            let levelDescription = levelDescriptions[logDetails.level]
//            ?? owner.levelDescriptions[logDetails.level]
//            ?? logDetails.level.description
//            
//            level = "\(levelDescription) "
//        }
//        
//        let formattedMessage = "\(extendedDetails)\n\(level)\(logDetails.message)"
//        
//        output(logDetails: logDetails, message: formattedMessage)
//    }
//    
//    private func threadName() -> String {
//        guard Thread.isMainThread == false else {
//            return "main"
//        }
//        
//        if let threadName = Thread.current.name, !threadName.isEmpty {
//            return threadName
//        } else if let queueName = DispatchQueue.currentQueueLabel, !queueName.isEmpty {
//            return queueName
//        } else {
//            return String(format: "%p", Thread.current)
//        }
//    }
//}
//
//// MAKR: - FileManager
//
//extension FileManager {
//    
//    // MARK: - Public properties
//    
//    class var documentDirectory: String {
//        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//    }
//    
//    class func getPath(to file: String) -> String { getPath(to: file, from: documentDirectory) }
//    
//    class func getPath(to file: String, from path: String) -> String { (path as NSString).appendingPathComponent(file) }
//    
//    class func getPathFromBundle(to file: String) -> String {
//        
//        var components = file.components(separatedBy : ".")
//        let fileExtension = components.popLast()
//        
//        return Bundle.main.path(forResource: components.joined(separator: "."), ofType: fileExtension) ?? ""
//    }
//}
//
//// MARK: - String
//
//fileprivate extension String {
//    
//    // MARK: - Public methods
//    
//    func replace(pattern: String, with replaceString: String = "") -> String {
//        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
//        else { return self }
//        
//        let range = NSRange(location: 0, length: count)
//        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceString)
//    }
//}
