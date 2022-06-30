import UIKit

public class ProfileViewController: BaseViewController {

    // MARK: Public Instance Properties

    public var viewModel: ProfileViewModel? { didSet { bindViewModel() } }

    // MARK: Private Instance Properties

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var emailAddressLabel: UILabel!
    @IBOutlet private weak var signOutButton: UIButton!
    @IBOutlet private weak var spinnerView: SpinnerView!

    // MARK: Private Instance Functions

    @IBAction private func backButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator
        else { return }

        analytics?.trackUIButtonTapped("back",
                                       screen: "profile")

        mc.showPrevious()
    }

    @IBAction private func signOutButtonTapped(_ sender: Any) {
        analytics?.trackUIButtonTapped("signOut",
                                       screen: "profile")

        _showSignOutConfirm { [weak self] in
            self?._signOut()
        }
    }

    // MARK: Private Instance Methods

    private func _configureSpinnerView() {
        let theme = Theme.default

        spinnerView.backgroundAlpha = 0.7
        spinnerView.cornerRadius = 8
        spinnerView.indicatorColor = theme.colors.active
        spinnerView.indicatorStyle = .large
        spinnerView.labelFont = theme.fonts.titleSmall
        spinnerView.labelGap = 8
        spinnerView.labelTextColor = theme.colors.active
    }

    private func _refreshSpinnerView(_ active: Bool) {
        if active {
            spinnerView.labelText = "Contacting TravelSpot…"

            spinnerView.sizeToFit()

            if let sv = spinnerView {
                NSLayoutConstraint(item: sv,
                                   attribute: .height,
                                   relatedBy: .equal,
                                   toItem: nil,
                                   attribute: .notAnAttribute,
                                   multiplier: 1,
                                   constant: sv.frame.height).isActive = true

                NSLayoutConstraint(item: sv,
                                   attribute: .width,
                                   relatedBy: .equal,
                                   toItem: nil,
                                   attribute: .notAnAttribute,
                                   multiplier: 1,
                                   constant: sv.frame.width).isActive = true
            }

            spinnerView.startAnimating()
        } else {
            spinnerView.stopAnimating()
        }
    }

    private func _showSignOutConfirm(_ action: @escaping () -> Void) {
        guard let mc = mainCoordinator,
              let vm = viewModel
        else { return }

        let cancelAction = UIAlertAction(title: vm.signOutCancelActionTitle,
                                         style: .cancel,
                                         handler: nil)

        cancelAction.accessibilityIdentifier = "alert_sign_out_cancel_action"

        let confirmAction = UIAlertAction(title: vm.signOutConfirmActionTitle,
                                          style: .destructive) { _ in
            action()
        }

        confirmAction.accessibilityIdentifier = "alert_sign_out_confirm_action"

        mc.showAlert(title: vm.signOutConfirmTitle,
                     message: vm.signOutConfirmMessage,
                     actions: [confirmAction,
                               cancelAction])
    }

    private func _showSignOutError(_ message: String) {
        guard let mc = mainCoordinator,
              let vm = viewModel
        else { return }

        let errorAction = UIAlertAction(title: vm.signOutErrorActionTitle,
                                        style: .default,
                                        handler: nil)

        errorAction.accessibilityIdentifier = "alert_sign_out_error_action"

        mc.showAlert(title: vm.signOutErrorTitle,
                     message: message,
                     actions: [errorAction])
    }

    private func _signOut() {
        guard let mc = mainCoordinator,
              let vm = viewModel
        else { return }

        backButton.isEnabled = false
        signOutButton.isEnabled = false

        _refreshSpinnerView(true)

        let email = vm.emailText

        analytics?.trackActionRequested("sign_out",
                                        name: email)

        vm.signOut { [weak self] in
            self?._refreshSpinnerView(false)

            if let message = $0 {
                self?.analytics?.trackActionFailed("sign_out",
                                                   name: email,
                                                   reason: message)

                self?._showSignOutError(message)

                self?.backButton.isEnabled = true
                self?.signOutButton.isEnabled = true
            } else {
                self?.analytics?.trackActionSucceeded("sign_out",
                                                      name: email)

                mc.showWelcome(signingOut: true)
            }
        }
    }

    // MARK: Overridden BaseViewController Methods

    override public func bindViewModel() {
        guard isViewLoaded,
              let vm = viewModel
        else { return }

        emailAddressLabel.text = vm.emailText

        signOutButton.setTitle(vm.signOutTitle,
                               for: .normal)
    }

    override public func configureSubviews() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.layer.masksToBounds = true

        emailAddressLabel.text = nil

        signOutButton.accessibilityIdentifier = "sign_out_button"
        signOutButton.setTitle(nil,
                               for: .normal)

        _configureSpinnerView()
    }
}
