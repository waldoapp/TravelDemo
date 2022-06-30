public class ProfileViewModel: ViewModel {

    // MARK: Public Initializers

    public init(_ client: TravelSpotClient) {
        self.client = client
    }

    // MARK: Public Instance Properties

    public var emailText: String {
        client.credentials?.email ?? ""
    }

    // MARK: Private Instance Properties

    private let client: TravelSpotClient
}
