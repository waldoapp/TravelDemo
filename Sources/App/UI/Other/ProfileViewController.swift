import UIKit

public class ProfileViewController: BaseViewController {

    // MARK: Public Instance Properties

    public var viewModel: ProfileViewModel? { didSet { bindViewModel() } }

    // MARK: Private Instance Properties

    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var emailAddressLabel: UILabel!

    // MARK: Private Instance Functions

    @IBAction private func backButtonTapped(_ sender: Any) {
        coordinator?.showPrevious()
    }

    // MARK: Overridden BaseViewController Methods

    override public func bindViewModel() {
        super.bindViewModel()

        guard isViewLoaded,
              let vm = viewModel
        else { return }
    }

    // MARK: Overridden UIViewController Methods

    override public func viewDidLoad() {
        super.viewDidLoad()
    }
}
