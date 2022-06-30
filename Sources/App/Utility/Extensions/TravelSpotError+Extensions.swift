import Foundation

public extension TravelSpotError {
    static func configureMessages() {
        NSError.setUserInfoValueProvider(forDomain: (Self.spotNotFound as NSError).domain) {
            switch $1 {
            case NSLocalizedDescriptionKey:
                return ($0 as? TravelSpotError)?.message

            default:
                return nil
            }
        }
    }

    var message: String {
        switch self {
        case .alreadySignedIn:
            return "ERROR.MESSAGE.ALREADY_SIGNED_IN".localized

        case .duplicateCredentials:
            return "ERROR.MESSAGE.DUPLICATE_CREDENTIALS".localized

        case .duplicateSpot:
            return "ERROR.MESSAGE.DUPLICATE_SPOT".localized

        case .invalidEmail:
            return "ERROR.MESSAGE.INVALID_EMAIL".localized

        case .missingDescription:
            return "ERROR.MESSAGE.MISSING_DESCRIPTION".localized

        case .missingEmail:
            return "ERROR.MESSAGE.MISSING_EMAIL".localized

        case .missingLocation:
            return "ERROR.MESSAGE.MISSING_LOCATION".localized

        case .missingName:
            return "ERROR.MESSAGE.MISSING_NAME".localized

        case .missingPassword:
            return "ERROR.MESSAGE.MISSING_PASSWORD".localized

        case .missingPhoto:
            return "ERROR.MESSAGE.MISSING_PHOTO".localized

        case .notSignedIn:
            return "ERROR.MESSAGE.NOT_SIGNED_IN".localized

        case .spotNotFound:
            return "ERROR.MESSAGE.SPOT_NOT_FOUND".localized

        case .unknownCredentials:
            return "ERROR.MESSAGE.UNKNOWN_CREDENTIALS".localized
        }
    }
}
