import UIKit

public struct DeepLink {

    // MARK: Public Nested Types

    public enum Command {
        case spot(String)
    }

    // MARK: Public Initializers

    public init?(_ userActivity: NSUserActivity) {
        if let command = DeepLink._parseUserActivity(userActivity) {
            self.command = command
        } else {
            return nil
        }
    }

    // MARK: Public Instance Properties

    public let command: Command

    // MARK: Private Type Properties

    private static let appHost = "deeplink.waldo.io"

    private static let appScheme1 = "http"
    private static let appScheme2 = "https"

    private static let spotCommand = "spot"

    private static let spotIDKey = "spotID"

    // MARK: Private Type Methods

    private static func _parseCommand(_ command: String,
                                      _ queryItems: [URLQueryItem]?) -> Command? {
        switch command {
        case spotCommand:
            guard let queryItem = queryItems?.first(where: { $0.name == spotIDKey }),
                  let spotID = queryItem.value,
                  !spotID.isEmpty
            else { return nil }

            return .spot(spotID)

        default:
            return nil
        }
    }

    private static func _parseUserActivity(_ userActivity: NSUserActivity) -> Command? {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
              let url = userActivity.webpageURL,
              let uc = URLComponents(url: url,
                                     resolvingAgainstBaseURL: true),
              let lcScheme = uc.scheme?.lowercased(),
              lcScheme == appScheme1 || lcScheme == appScheme2,
              let lcHost = uc.host?.lowercased(),
              lcHost == appHost,
              uc.path.hasPrefix("/")
        else { return nil }

        return _parseCommand(String(uc.path.dropFirst()),
                             uc.queryItems)
    }
}
