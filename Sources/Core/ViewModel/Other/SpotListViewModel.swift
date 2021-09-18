public class SpotListViewModel: ViewModel {

    // MARK: Public Initializers

    override public init() {
        self.isFiltered = false

        self.cancelActionTitle = "SPOT_LIST.ACTION_SHEET.ACTION.TITLE.CANCEL".localized
        self.profileActionTitle = "SPOT_LIST.ACTION_SHEET.ACTION.TITLE.PROFILE".localized
        self.signOutActionTitle = "SPOT_LIST.ACTION_SHEET.ACTION.TITLE.SIGN_OUT".localized
    }

    // MARK: Public Instance Properties

    public let cancelActionTitle: String
    public let profileActionTitle: String
    public let signOutActionTitle: String

    public var isFiltered: Bool

    public var screenTitle: String {
        if isFiltered {
            return "SPOT_LIST.SCREEN.TITLE.MY_SPOTS".localized
        } else {
            return "SPOT_LIST.SCREEN.TITLE.EXPLORE".localized
        }
    }
 }
