public class ProfileViewModel: ViewModel {

    // MARK: Public Initializers

    public init(_ client: TravelSpotClient) {
        self.client = client
        self.signOutActionTitle = "PROFILE.ACTION_SHEET.ACTION.TITLE.SIGN_OUT".localized
        self.signOutCancelActionTitle = "PROFILE.ALERT.ACTION.TITLE.SIGN_OUT_CANCEL".localized
        self.signOutConfirmActionTitle = "PROFILE.ALERT.ACTION.TITLE.SIGN_OUT_CONFIRM".localized
        self.signOutConfirmMessage = "PROFILE.ALERT.MESSAGE.SIGN_OUT_CONFIRM".localized
        self.signOutConfirmTitle = "PROFILE.ALERT.TITLE.SIGN_OUT_CONFIRM".localized
        self.signOutErrorActionTitle = "PROFILE.ALERT.ACTION.TITLE.SIGN_OUT_ERROR".localized
        self.signOutErrorTitle = "PROFILE.ALERT.TITLE.SIGN_OUT_ERROR".localized
        self.signOutTitle = "PROFILE.BUTTON.TITLE.SIGN_OUT".localized
    }

    // MARK: Public Instance Properties

    public let signOutActionTitle: String
    public let signOutCancelActionTitle: String
    public let signOutConfirmActionTitle: String
    public let signOutConfirmMessage: String
    public let signOutConfirmTitle: String
    public let signOutErrorActionTitle: String
    public let signOutErrorTitle: String
    public let signOutTitle: String

    public var emailText: String {
        client.credentials?.email ?? ""
    }

    // MARK: Public Instance Methods

    public func signOut(completion: @escaping (String?) -> Void) {
        client.signOut {
            switch $0 {
            case let .failure(error):
                completion(error.localizedDescription)

            case .success:
                completion(nil)
            }
        }
    }

    // MARK: Private Instance Properties

    private let client: TravelSpotClient
}
