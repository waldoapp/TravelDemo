public class SpotListViewModel: ViewModel {

    // MARK: Public Initializers

    public init(_ mySpots: Bool,
                _ client: TravelSpotClient) {
        self.client = client
        self.emptyAddTitle = "SPOT_LIST.BUTTON.TITLE.ADD_NEW_SPOT".localized
        self.emptyMessageText = "SPOT_LIST.SCREEN.MESSAGE.NO_SPOTS".localized
        self.mySpots = mySpots
    }

    // MARK: Public Instance Properties

    public let emptyAddTitle: String
    public let emptyMessageText: String

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

    // MARK: Private Instance Properties

    private unowned let client: TravelSpotClient
}
