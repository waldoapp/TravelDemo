public class Provider {

    // MARK: Public Nested Types

    public enum Access {
        case allowed
        case disabled
        case notAllowed
        case unknown
    }

    // MARK: Public Initializers

    public init(delegate: ProviderDelegate) {
        self.delegate = delegate
    }

    // MARK: Public Instance Properties

    public let delegate: ProviderDelegate
}
