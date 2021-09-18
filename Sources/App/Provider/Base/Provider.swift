import UIKit

public class Provider: NSObject {

    // MARK: Public Nested Types

    public enum Access {
        case allowed
        case disabled
        case notAllowed
        case unknown
    }

    // MARK: Public Instance Methods

    public func didBecomeActive() {
    }

    public func didEnterBackground() {
    }

    public func didFinishLaunching(_ options: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        true
    }

    public func didReceiveMemoryWarning() {
    }

    public func willEnterForeground() {
    }

    public func willFinishLaunching(_ options: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        true
    }

    public func willResignActive() {
    }

    public func willTerminate() {
    }
}
