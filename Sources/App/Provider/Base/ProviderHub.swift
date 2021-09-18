public class ProviderHub {

    // MARK: Public Initializers

    public init(delegate: ProviderDelegate) {
        self.analytics = .init(delegate: delegate)
        self.authentication = .init(delegate: delegate)
        self.location = .init(delegate: delegate)
        self.photo = .init(delegate: delegate)
        self.storage = .init(delegate: delegate)
    }

    // MARK: Public Instance Properties

    public let analytics: AnalyticsProvider
    public let authentication: AuthenticationProvider
    public let location: LocationProvider
    public let photo: PhotoProvider
    public let storage: StorageProvider
}
