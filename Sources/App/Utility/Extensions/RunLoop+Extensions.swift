import Foundation

public extension RunLoop {

    // MARK: Public Nested Types

    enum Error: Swift.Error {
        case timedOut(String)
    }

    // MARK: Public Type Properties

    static let defaultWaitInterval = TimeInterval(0.1)
    static let defaultWaitTimeout = TimeInterval(60)

    static let defaultWaitMessage = "Timed out waiting"

    // MARK: Public Type Methods

    static func wait(duration: TimeInterval) {
        current.run(until: Date(timeIntervalSinceNow: duration))
    }

    static func wait(until action: @autoclosure () -> Bool,
                     timeout: TimeInterval = defaultWaitTimeout,
                     message: String = defaultWaitMessage) throws {
        try waitForValue(timeout: timeout,
                         message: message) {
            action() ? true : nil
        }
    }

    @discardableResult
    static func waitForValue<T>(timeout: TimeInterval = defaultWaitTimeout,
                                message: String = defaultWaitMessage,
                                interval: TimeInterval = defaultWaitInterval,
                                action: () throws -> T?) throws -> T {
        let timeoutDate = Date(timeIntervalSinceNow: timeout)
        let interval = min(interval, timeout)

        while true {
            if let result = try action() {
                return result
            }

            wait(duration: interval)

            if timeoutDate.timeIntervalSinceNow < 0 {
                throw Error.timedOut(message)
            }
        }
    }
}
