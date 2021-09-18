import Foundation

public class SignInViewModel: ViewModel {

    // MARK: Public Initializers

    public init(_ client: TravelSpotClient,
                _ isRegistering: Bool) {
        self.client = client
        self.isRegistering = isRegistering

        if isRegistering {
            self.actionTitle = "SIGN_IN.BUTTON.TITLE.SIGN_UP".localized
            self.screenTitle = "SIGN_IN.SCREEN.TITLE.SIGN_UP".localized
        } else {
            self.actionTitle = "SIGN_IN.BUTTON.TITLE.SIGN_IN".localized
            self.screenTitle = "SIGN_IN.SCREEN.TITLE.SIGN_IN".localized
        }

        self.actionErrorActionTitle = "SIGN_IN.ALERT.ACTION.TITLE.ACTION_ERROR".localized
        self.actionErrorTitle = "SIGN_IN.ALERT.TITLE.ACTION_ERROR".localized
        self.emailPlaceholder = "SIGN_IN.SECTION.PLACEHOLDER.EMAIL".localized
        self.emailSectionTitle = "SIGN_IN.SECTION.TITLE.EMAIL".localized.uppercased()
        self.passwordPlaceholder = "SIGN_IN.SECTION.PLACEHOLDER.PASSWORD".localized
        self.passwordSectionTitle = "SIGN_IN.SECTION.TITLE.PASSWORD".localized.uppercased()
        self.validationErrorActionTitle = "SIGN_IN.ALERT.ACTION.TITLE.VALIDATION_ERROR".localized
        self.validationErrorTitle = "SIGN_IN.ALERT.TITLE.VALIDATION_ERROR".localized
    }

    // MARK: Public Instance Properties

    public let actionErrorActionTitle: String
    public let actionErrorTitle: String
    public let actionTitle: String
    public let emailPlaceholder: String
    public let emailSectionTitle: String
    public let isRegistering: Bool
    public let passwordPlaceholder: String
    public let passwordSectionTitle: String
    public let screenTitle: String
    public let validationErrorActionTitle: String
    public let validationErrorTitle: String

    // MARK: Public Instance Methods

    public func performAction(email: String,
                              password: String,
                              completion: @escaping (Error?) -> Void) {
        if isRegistering {
            client.signUp(email: email,
                          password: password) {
                switch $0 {
                case let .failure(error):
                    completion(error)

                case .success:
                    completion(nil)
                }
            }
        } else {
            client.signIn(email: email,
                          password: password) {
                switch $0 {
                case let .failure(error):
                    completion(error)

                case .success:
                    completion(nil)
                }
            }
        }
    }

    public func validate(email: String?,
                         password: String?) -> Error? {
        if let email = email {
            if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return TravelSpotError.missingEmail
            }

            if !_validateEmail(email) {
                return TravelSpotError.invalidEmail
            }
        }

        if let password = password,
           password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return TravelSpotError.missingPassword
        }

        return nil
    }

    // MARK: Private Instance Properties

    private unowned let client: TravelSpotClient

    // MARK: Private Instance Methods

    private func _validateEmail(_ email: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@",
                    emailRegex).evaluate(with: email)
    }
}

// swiftlint:disable:next line_length
private let emailRegex = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
