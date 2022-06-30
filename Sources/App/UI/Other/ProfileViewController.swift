import UIKit

public class ProfileViewController: BaseViewController {

    // MARK: Public Instance Properties

    public var viewModel: ProfileViewModel? { didSet { bindViewModel() } }

    // MARK: Private Instance Properties

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var emailAddressLabel: UILabel!

    // MARK: Private Instance Functions

    @IBAction private func backButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator
        else { return }

        mc.providers.analytics.trackUIButtonTapped("back",
                                                   screen: "profile")

        mc.showPrevious()
    }

    // MARK: Overridden BaseViewController Methods

    override public func bindViewModel() {
        guard isViewLoaded,
              let vm = viewModel
        else { return }

        emailAddressLabel.text = vm.emailText
    }

    override public func configureSubviews() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.layer.masksToBounds = true

        emailAddressLabel.text = nil
    }
}
