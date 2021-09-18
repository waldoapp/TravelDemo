public class WelcomeViewModel: ViewModel {

    // MARK: Public Initializers

    public init(_ signedOut: Bool) {
        self.messageText = "WELCOME.SCREEN.MESSAGE.EXPLORE".localized
        self.signedOut = signedOut
        self.signInTitle = "WELCOME.BUTTON.TITLE.SIGN_IN".localized
        self.signOutConfirmActionTitle = "WELCOME.ALERT.ACTION.TITLE.SIGN_OUT_CONFIRM".localized
        self.signOutConfirmMessage = "WELCOME.ALERT.MESSAGE.SIGN_OUT_CONFIRM".localized
        self.signOutConfirmTitle = "WELCOME.ALERT.TITLE.SIGN_OUT_CONFIRM".localized
        self.signUpTitle = "WELCOME.BUTTON.TITLE.SIGN_UP".localized
        self.termsText = "WELCOME.SCREEN.FOOTER.TERMS".localized
    }

    // MARK: Public Instance Properties

    public let messageText: String
    public let signedOut: Bool
    public let signInTitle: String
    public let signOutConfirmActionTitle: String
    public let signOutConfirmMessage: String
    public let signOutConfirmTitle: String
    public let signUpTitle: String
    public let termsText: String
}
