public enum TravelSpotError: Error {
    case alreadySignedIn
    case duplicateCredentials
    case duplicateSpot
    case invalidEmail
    case missingDescription
    case missingEmail
    case missingLocation
    case missingName
    case missingPassword
    case missingPhoto
    case notSignedIn
    case spotNotFound
    case unknownCredentials
}
