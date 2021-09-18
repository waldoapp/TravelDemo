public class WelcomeViewModel: ViewModel {

    // MARK: Public Initializers

    override public init() {
        self.messageText = "WELCOME.SCREEN.MESSAGE.EXPLORE".localized
        self.signInTitle = "WELCOME.BUTTON.TITLE.SIGN_IN".localized
        self.signUpTitle = "WELCOME.BUTTON.TITLE.SIGN_UP".localized
        self.termsText = "WELCOME.SCREEN.FOOTER.TERMS".localized
    }

    // MARK: Public Instance properties

    public let messageText: String
    public let signInTitle: String
    public let signUpTitle: String
    public let termsText: String
}
