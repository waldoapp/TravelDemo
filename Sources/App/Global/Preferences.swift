import Foundation

internal protocol PreferencesDelegate: class {
    var appBundleID: String? { get }
}

public class Preferences {

    // MARK: Public Instance Properties

    public var exampleProfileCopyDone: Bool {
        get { localStore.bool(forKey: key(.exampleProfileCopyDone)) }
        set {
            cloudStore.set(newValue, forKey: key(.exampleProfileCopyDone))
            localStore.set(newValue, forKey: key(.exampleProfileCopyDone))
        }
    }

    public var launchTime: TimeInterval {
        get { localStore.double(forKey: key(.launchTime)) }
        set {
            cloudStore.set(newValue, forKey: key(.launchTime))
            localStore.set(newValue, forKey: key(.launchTime))
        }
    }

    // MARK: Public Instance Methods

    public func synchronizeCloud() {
//        if cloudStore.synchronize() {
//            logInfo("Synchronized cloud store")
//        } else {
//            logWarn("Unable to synchronize cloud store")
//        }
    }

    public func synchronizeLocal() {
        localStore.synchronize()
    }

    public func updateLocalFromCloud(_ keys: [String]?) {
        guard
            let keys = keys
            else { return }

        for key in keys {
            localStore.set(cloudStore.object(forKey: key),
                           forKey: key)
        }
    }

    // MARK: Internal Initializers

    internal init(delegate: PreferencesDelegate) {
        self.delegate = delegate

        self.cloudStore = .`default`
        self.localStore = .standard

        if let appBundleID = delegate.appBundleID {
            self.prefix = appBundleID + "."
        } else {
            self.prefix = ""
        }
    }

    // MARK: Private Nested Types

    private enum RawKey: String {
        case exampleProfileCopyDone
        case launchTime
    }

    // MARK: Private Instance Properties

    private let cloudStore: NSUbiquitousKeyValueStore
    private let localStore: UserDefaults
    private let prefix: String

    private weak var delegate: PreferencesDelegate?

    // MARK: Private Instance Methods

    private func key(_ rawKey: RawKey) -> String {
        prefix + rawKey.rawValue
    }
}
