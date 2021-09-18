public class SignInViewModel: ViewModel {

    // MARK: Public Initializers

    public init(_ registered: Bool) {
        if registered {
            self.actionTitle = "SIGN_IN.BUTTON.TITLE.SIGN_IN".localized
            self.screenTitle = "SIGN_IN.SCREEN.TITLE.SIGN_IN".localized
        } else {
            self.actionTitle = "SIGN_IN.BUTTON.TITLE.SIGN_UP".localized
            self.screenTitle = "SIGN_IN.SCREEN.TITLE.SIGN_UP".localized
        }

        self.emailPlaceholderText = "SIGN_IN.SECTION.PLACEHOLDER.EMAIL".localized
        self.emailSectionTitle = "SIGN_IN.SECTION.TITLE.EMAIL".localized
        self.passwordPlaceholderText = "SIGN_IN.SECTION.PLACEHOLDER.PASSWORD".localized
        self.passwordSectionTitle = "SIGN_IN.SECTION.TITLE.PASSWORD".localized
    }

    // MARK: Public Instance Properties

    public let actionTitle: String
    public let emailPlaceholderText: String
    public let emailSectionTitle: String
    public let passwordPlaceholderText: String
    public let passwordSectionTitle: String
    public let screenTitle: String
}
