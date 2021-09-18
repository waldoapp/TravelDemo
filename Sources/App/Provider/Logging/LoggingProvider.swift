//import Foundation
//
//public func logDebug(_ message: @autoclosure () -> String,
//                     file: StaticString = #file,
//                     function: StaticString = #function,
//                     line: UInt = #line) {
//    LoggingProvider.shared?.logMessage(message(),
//                                       flag: .debug,
//                                       file: file,
//                                       function: function,
//                                       line: line)
//}
//
//public func logError(_ message: @autoclosure () -> String,
//                     file: StaticString = #file,
//                     function: StaticString = #function,
//                     line: UInt = #line) {
//    LoggingProvider.shared?.logMessage(message(),
//                                       flag: .error,
//                                       file: file,
//                                       function: function,
//                                       line: line)
//}
//
//public func logInfo(_ message: @autoclosure () -> String,
//                    file: StaticString = #file,
//                    function: StaticString = #function,
//                    line: UInt = #line) {
//    LoggingProvider.shared?.logMessage(message(),
//                                       flag: .info,
//                                       file: file,
//                                       function: function,
//                                       line: line)
//}
//
//public func logVerbose(_ message: @autoclosure () -> String,
//                       file: StaticString = #file,
//                       function: StaticString = #function,
//                       line: UInt = #line) {
//    LoggingProvider.shared?.logMessage(message(),
//                                       flag: .verbose,
//                                       file: file,
//                                       function: function,
//                                       line: line)
//}
//
//public func logWarn(_ message: @autoclosure () -> String,
//                    file: StaticString = #file,
//                    function: StaticString = #function,
//                    line: UInt = #line) {
//    LoggingProvider.shared?.logMessage(message(),
//                                       flag: .warning,
//                                       file: file,
//                                       function: function,
//                                       line: line)
//}
//
//public class LoggingProvider: Provider {
//
//    // MARK: Public Nested Types
//
//    public class LogFile {
//
//        // MARK: Public Nested Types
//
//        public typealias Date = Foundation.Date
//
//        // MARK: Public Instance Properties
//
//        public let fileName: String
//        public let filePath: String?
//        public let fileSize: UInt64
//        public let creationDate: Date?
//        public let modificationDate: Date?
//
//        // MARK: Internal Initializers
//
//        internal init(fileName: String,
//                      filePath: String? = nil,
//                      fileSize: UInt64 = 0,
//                      creationDate: Date? = nil,
//                      modificationDate: Date? = nil) {
//            self.fileName = fileName
//            self.filePath = filePath
//            self.fileSize = fileSize
//            self.creationDate = creationDate
//            self.modificationDate = modificationDate
//        }
//    }
//
//    public struct LogFlag: OptionSet {
//        public static let error = LogFlag(rawValue: 1 << 0)     // 0b00000001
//        public static let warning = LogFlag(rawValue: 1 << 1)   // 0b00000010
//        public static let info = LogFlag(rawValue: 1 << 2)      // 0b00000100
//        public static let debug = LogFlag(rawValue: 1 << 3)     // 0b00001000
//        public static let verbose = LogFlag(rawValue: 1 << 4)   // 0b00010000
//
//        public init(rawValue: UInt) {
//            self.rawValue = rawValue
//        }
//
//        public let rawValue: UInt
//    }
//
//    public enum LogLevel: UInt {
//        case off = 0
//        case error = 0b00000001
//        case warning = 0b00000011
//        case info = 0b00000111
//        case debug = 0b00001111
//        case verbose = 0b00011111
//        case all = 0xffffffff
//    }
//
//    // MARK: Public Instance Properties
//
//    public var logFiles: [LogFile] {
//        if let list = fileLogger.logFileManager?.sortedLogFileInfos {
//            return list.map { mapLogFileInfo($0) }
//        } else {
//            return []
//        }
//    }
//
//    public func logMessage(_ message: @autoclosure () -> String,
//                           flag: LogFlag,
//                           file: StaticString,
//                           function: StaticString,
//                           line: UInt) {
//        let level = defaultDebugLevel
//
//        if level.rawValue & flag.rawValue != 0 {
//            let message = DDLogMessage(message: message(),
//                                       level: level,
//                                       flag: DDLogFlag(rawValue: flag.rawValue),
//                                       context: 0,
//                                       file: String(describing: file),
//                                       function: String(describing: function),
//                                       line: line,
//                                       tag: nil,
//                                       options: [.copyFile, .copyFunction],
//                                       timestamp: nil)
//
//            log.log(asynchronous: true,
//                    message: message)
//        }
//    }
//
//    // MARK: Internal Type Properties
//
//    internal static var shared: LoggingProvider?
//
//    // MARK: Private Instance Properties
//
////    private unowned let log: DDLog
//    private let fileLogger: DDFileLogger
//
//    // MARK: Private Instance Methods
//
//    private func mapLogFileInfo(_ lfi: DDLogFileInfo) -> LogFile {
//        LogFile(fileName: lfi.fileName ?? "???",
//                filePath: lfi.filePath,
//                fileSize: lfi.fileSize,
//                creationDate: lfi.creationDate,
//                modificationDate: lfi.modificationDate)
//    }
//
//    // MARK: Overridden Provider Initializers
//
//    override internal init() {
//        self.fileLogger = .init()
//        self.log = .sharedInstance
//
//        super.init()
//
//        if #available(iOS 10.0, *) {
//            self.log.add(DDOSLogger.sharedInstance)
//        } else {
//            self.log.add(DDASLLogger.sharedInstance)
//        }
//
//        DDLog.add(self.fileLogger)
//    }
//}
