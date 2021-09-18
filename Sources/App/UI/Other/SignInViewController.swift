import UIKit

public class SignInViewController: BaseViewController {

    // MARK: Public Instance Properties

    public var viewModel: SignInViewModel? { didSet { bindViewModel() } }

    // MARK: Private Instance Properties

    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: Private Instance Methods

    @IBAction private func actionButtonTapped(_ sender: Any) {
        // for now…

        coordinator?.showOnboarding()
    }

    @IBAction private func backButtonTapped(_ sender: Any) {
        coordinator?.showPrevious()
    }

    // MARK: Overridden BaseViewController Methods

    override public func bindViewModel() {
        super.bindViewModel()

        guard isViewLoaded,
              let vm = viewModel
        else { return }

        actionButton.setTitle(vm.actionTitle,
                              for: .normal)

        emailLabel.text = vm.emailSectionTitle

        emailTextField.placeholder = vm.emailPlaceholderText

        passwordLabel.text = vm.passwordSectionTitle

        passwordTextField.placeholder = vm.passwordPlaceholderText

        titleLabel.text = vm.screenTitle
    }

    // MARK: Overridden UIViewController Methods

    override public func viewDidLoad() {
        super.viewDidLoad()

        actionButton.layer.cornerRadius = actionButton.frame.height / 2
        actionButton.layer.masksToBounds = true
    }
}
