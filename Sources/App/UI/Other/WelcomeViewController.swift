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

    @IBAction private func signInButtonTapped(_ sender: UIButton) {
        coordinator?.showSignIn()
    }

    @IBAction private func signUpButtonTapped(_ sender: UIButton) {
        coordinator?.showSignUp()
    }

    // MARK: Overridden BaseViewController Methods

    override public func bindViewModel() {
        super.bindViewModel()

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

    // MARK: Overridden UIViewController Methods

    override public func viewDidLoad() {
        super.viewDidLoad()

        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
        signUpButton.layer.masksToBounds = true
    }
}
