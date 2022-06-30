import Firebase

public struct FirebaseServices {

    // MARK: Public Type Properties

    public static let shared: FirebaseServices = .init()

    // MARK: Public Instance Properties

    public var authentication: Auth {
        Auth.auth()
    }

    public var storage: Storage {
        Storage.storage()
    }

    // MARK: Private Initializers

    private init() {
        FirebaseApp.configure()
    }
}
