import UIKit

public class WelcomeViewController: BaseViewController {

    // MARK: Public Instance Properties

    public var viewModel: WelcomeViewModel? { didSet { bindViewModel() } }

    // MARK: Private Instance Properties

    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var termsLabel: UILabel!

    // MARK: Private Instance Methods

    @IBAction private func signInButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator
        else { return }

        mc.providers.analytics.trackUIButtonTapped("signIn",
                                                   screen: "welcome")

        mc.showSignIn()
    }

    @IBAction private func signUpButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator
        else { return }

        mc.providers.analytics.trackUIButtonTapped("signUp",
                                                   screen: "welcome")

        mc.showSignUp()
    }

    private func _showSignOutConfirm() {
        guard let mc = mainCoordinator,
              let vm = viewModel
        else { return }

        let confirmAction = UIAlertAction(title: vm.signOutConfirmActionTitle,
                                          style: .default,
                                          handler: nil)

        confirmAction.accessibilityIdentifier = "alert_sign_out_confirm_action"

        mc.showAlert(title: vm.signOutConfirmTitle,
                     message: vm.signOutConfirmMessage,
                     actions: [confirmAction])
    }

    // MARK: Overridden BaseViewController Methods

    override public func bindViewModel() {
        guard isViewLoaded,
              let vm = viewModel
        else { return }

        messageLabel.text = vm.messageText

        signInButton.setTitle(vm.signInTitle,
                              for: .normal)

        signUpButton.setTitle(vm.signUpTitle,
                              for: .normal)

        termsLabel.text = vm.termsText
    }

    override public func configureSubviews() {
        messageLabel.text = nil

        signInButton.accessibilityIdentifier = "sign_in_button"
        signInButton.setTitle(nil,
                              for: .normal)

        signUpButton.accessibilityIdentifier = "sign_up_button"
        signUpButton.setTitle(nil,
                              for: .normal)

        termsLabel.text = nil
    }

    // MARK: Overridden UIViewController Methods

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let vm = viewModel
        else { return }

        if vm.signedOut {
            _showSignOutConfirm()
        }
    }
}
