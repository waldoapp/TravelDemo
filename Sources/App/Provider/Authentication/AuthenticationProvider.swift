import Firebase

public class AuthenticationProvider: Provider {

    // MARK: Public Instance Properties

    public private(set) var currentUser: Credentials?

    // MARK: Public Instance Methods

    public func createUser(email: String,
                           password: String,
                           completion: @escaping (Result<Credentials, Error>) -> Void) {
        guard auth.currentUser == nil
        else { completion(.failure(TravelSpotError.alreadySignedIn)); return }

        auth.createUser(withEmail: email,
                        password: password) {
            if let error = $1 {
                completion(.failure(Self._convertError(error)))
            } else if let email = $0?.user.email,
                      let userID = $0?.user.uid {
                completion(.success(Credentials(userID: userID,
                                                email: email)))
            } else {
                completion(.failure(TravelSpotError.unknownCredentials))
            }
        }
    }

    public func deleteUser(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = auth.currentUser
        else { completion(.failure(TravelSpotError.notSignedIn)); return }

        user.delete {
            if let error = $0 {
                completion(.failure(Self._convertError(error)))
            } else {
                completion(.success(()))
            }
        }
    }

    public func signIn(email: String,
                       password: String,
                       completion: @escaping (Result<Credentials, Error>) -> Void) {
        guard auth.currentUser == nil
        else { completion(.failure(TravelSpotError.alreadySignedIn)); return }

        auth.signIn(withEmail: email,
                    password: password) {
            if let error = $1 {
                completion(.failure(Self._convertError(error)))
            } else if let email = $0?.user.email,
                      let userID = $0?.user.uid {
                completion(.success(Credentials(userID: userID,
                                                email: email)))
            } else {
                completion(.failure(TravelSpotError.unknownCredentials))
            }
        }
    }

    public func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        guard auth.currentUser != nil
        else { completion(.failure(TravelSpotError.notSignedIn)); return }

        do {
            try auth.signOut()

            DispatchQueue.main.async {
                completion(.success(()))
            }
        } catch {
            DispatchQueue.main.async {
                completion(.failure(Self._convertError(error)))
            }
        }
    }

    // MARK: Private Type Methods

    private static func _convertError(_ error: Error) -> Error {
        switch (error as NSError).code {
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            return TravelSpotError.duplicateCredentials

        case AuthErrorCode.invalidEmail.rawValue:
            return TravelSpotError.invalidEmail

        default:
            return TravelSpotError.unknownCredentials
        }
    }

    // MARK: Private Instance Properties

    private let auth: Auth

    // MARK: Private Instance Methods

    private func _updateCurrentUser(_ user: User?) {
        if let email = user?.email,
           let userID = user?.uid {
            currentUser = Credentials(userID: userID,
                                      email: email)
        } else {
            currentUser = nil
        }
    }

    // MARK: Overridden Provider Initializers

    override internal init(delegate: ProviderDelegate) {
        self.auth = FirebaseServices.shared.authentication

        super.init(delegate: delegate)

        auth.addStateDidChangeListener { [weak self] _, user in
            self?._updateCurrentUser(user)
        }

        _updateCurrentUser(try? RunLoop.waitForValue(timeout: 3) { auth.currentUser })
    }
}
