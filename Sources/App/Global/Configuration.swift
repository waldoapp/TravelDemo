import Foundation

public class Configuration {

    // MARK: Public Instance Properties

    public let appBuild: String?
    public let appBundleID: String?
    public let appName: String?
    public let appVersion: String?

    // MARK: Internal Initializers

    internal init() {
        let bundleInfo = Bundle.main.infoDictionary

        self.appBuild = bundleInfo?[Key.bundleBuildKey] as? String
        self.appBundleID = bundleInfo?[Key.bundleIDKey] as? String
        self.appName = bundleInfo?[Key.bundleNameKey] as? String
        self.appVersion = bundleInfo?[Key.bundleVersionKey] as? String
    }

    // MARK: Private Nested Types

    private struct Key {
        static let bundleBuildKey   = "CFBundleVersion"
        static let bundleIDKey      = "CFBundleIdentifier"
        static let bundleNameKey    = "CFBundleName"
        static let bundleVersionKey = "CFBundleShortVersionString"
    }
}
