import UIKit

public class SpotViewModel: ViewModel {

    // MARK: Public Initializers

    public init(_ spot: Spot,
                _ client: TravelSpotClient) {
        self.authorSectionTitle = "SPOT.SECTION.TITLE.AUTHOR".localized
        self.client = client
        self.deleteErrorActionTitle = "SPOT.ALERT.ACTION.TITLE.DELETE_ERROR".localized
        self.deleteErrorTitle = "SPOT.ALERT.TITLE.DELETE_ERROR".localized
        self.deleteTitle = "SPOT.BUTTON.TITLE.DELETE_SPOT".localized
        self.descriptionSectionTitle = "SPOT.SECTION.TITLE.DESCRIPTION".localized
        self.locationSectionTitle = "SPOT.SECTION.TITLE.LOCATION".localized
        self.shareTitle = "SPOT.BUTTON.TITLE.SHARE".localized
        self.spot = spot
    }

    // MARK: Public Instance Properties

    public let authorSectionTitle: String
    public let deleteErrorActionTitle: String
    public let deleteErrorTitle: String
    public let deleteTitle: String
    public let descriptionSectionTitle: String
    public let locationSectionTitle: String
    public let shareTitle: String

    public var authorImage: UIImage? {
        switch spot.author {
        case .me:
            return UIImage(named: "avatar")

        case let .other(_, avatar):
            return avatar.image
        }
    }

    public var authorNameText: String {
        switch spot.author {
        case .me:
            return "COMMON.AUTHOR.NAME.ME".localized

        case let .other(name, _):
            return name
        }
    }

    public var descriptionText: String {
        spot.description
    }

    public var isMine: Bool {
        switch spot.author {
        case .me:
            return true

        case .other:
            return false
        }
    }

    public var locationText: String {
        Formatter.formatLocation(spot.location)
    }

    public var spotImage: UIImage? {
        spot.photo.image
    }

    public var spotNameText: String {
        spot.name
    }

    // MARK: Public Instance Methods

    public func deleteSpot(completion: @escaping (Error?) -> Void) {
        client.deleteSpot(spot) {
            switch $0 {
            case let .failure(error):
                completion(error)

            case .success:
                completion(nil)
            }
        }
    }

    // MARK: Private Instance Properties

    private unowned let client: TravelSpotClient
    private let spot: Spot
}
