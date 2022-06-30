public class SpotListViewModel: ViewModel {

    // MARK: Public Initializers

    public init(_ mySpots: Bool,
                _ client: TravelSpotClient) {
        self.cancelActionTitle = "SPOT_LIST.ACTION_SHEET.ACTION.TITLE.CANCEL".localized
        self.client = client
        self.emptyAddTitle = "SPOT_LIST.BUTTON.TITLE.ADD_NEW_SPOT".localized
        self.emptyMessageText = "SPOT_LIST.SCREEN.MESSAGE.NO_SPOTS".localized
        self.mySpots = mySpots
        self.profileActionTitle = "SPOT_LIST.ACTION_SHEET.ACTION.TITLE.PROFILE".localized
        self.signOutActionTitle = "SPOT_LIST.ACTION_SHEET.ACTION.TITLE.SIGN_OUT".localized
        self.signOutErrorActionTitle = "SPOT_LIST.ALERT.ACTION.TITLE.SIGN_OUT_ERROR".localized
        self.signOutErrorTitle = "SPOT_LIST.ALERT.TITLE.SIGN_OUT_ERROR".localized
    }

    // MARK: Public Instance Properties

    public let cancelActionTitle: String
    public let emptyAddTitle: String
    public let emptyMessageText: String
    public let profileActionTitle: String
    public let signOutActionTitle: String
    public let signOutErrorActionTitle: String
    public let signOutErrorTitle: String

    public var mySpots: Bool

    public var screenTitle: String {
        if mySpots {
            return "SPOT_LIST.SCREEN.TITLE.MY_SPOTS".localized
        } else {
            return "SPOT_LIST.SCREEN.TITLE.EXPLORE".localized
        }
    }

    // MARK: Public Instance Methods

    public func fetchSpots(completion: @escaping ([SpotCellViewModel]) -> Void) {
        client.fetchAllSpots(mySpots: mySpots) {
            switch $0 {
            case .failure:
                completion([])

            case let .success(spots):
                completion(spots.map { SpotCellViewModel($0) })
            }
        }
    }

    public func signOut(completion: @escaping (Error?) -> Void) {
        client.signOut {
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
}
