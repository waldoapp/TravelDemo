import UIKit

// swiftlint:disable type_body_length

public class SignInViewController: BaseViewController {

    // MARK: Public Instance Properties

    public var viewModel: SignInViewModel? { didSet { bindViewModel() } }

    // MARK: Private Instance Properties

    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var contentViewBottom: NSLayoutConstraint!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var spinnerView: SpinnerView!
    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: Private Instance Methods

    @IBAction private func actionButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator,
              let vm = viewModel
        else { return }

        let button = vm.isRegistering ? "signUp" : "signIn"
        let screen = vm.isRegistering ? "signUp" : "signIn"

        mc.providers.analytics.trackUIButtonTapped(button,
                                                   screen: screen)

        if let error = vm.validate(email: emailTextField.text,
                                   password: passwordTextField.text) {
            _showValidationError(error)

            return
        }

        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else { return }

        emailTextField.resignFirstResponder()

        passwordTextField.resignFirstResponder()

        actionButton.isEnabled = false
        backButton.isEnabled = false
        emailTextField.isEnabled = false
        passwordTextField.isEnabled = false

        _refreshSpinnerView(true)

        vm.performAction(email: email,
                         password: password) { [weak self] in
            self?._refreshSpinnerView(false)

            if let error = $0 {
                self?._showActionError(error)

                self?.actionButton.isEnabled = true
                self?.backButton.isEnabled = true
                self?.emailTextField.isEnabled = true
                self?.passwordTextField.isEnabled = true
            } else if vm.isRegistering {
                mc.showOnboarding()
            } else {
                mc.showSpotList(mySpots: false)
            }
        }
    }

    @IBAction private func backButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator,
              let vm = viewModel
        else { return }

        let screen = vm.isRegistering ? "signUp" : "signIn"

        mc.providers.analytics.trackUIButtonTapped("back",
                                                   screen: screen)

        mc.showPrevious()
    }

    private func _addNotificationObservers() {
        let nc = NotificationCenter.default

        nc.addObserver(self,
                       selector: #selector(_keyboardWillChangeFrame),
                       name: UIResponder.keyboardWillChangeFrameNotification,
                       object: nil)
    }

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

    @objc
    private func _keyboardWillChangeFrame(notification: NSNotification) {
        guard let frameEnd = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let rawCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }

        let options = UIView.AnimationOptions(rawValue: rawCurve << 16)
        let bottom = view.bounds.maxY - frameEnd.minY

        view.layoutIfNeeded()

        self.contentViewBottom.constant = max(bottom, 0)

        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: options) {
            self.view.layoutIfNeeded()
        }
    }

    private func _makeRevealButton() -> UIButton {
        let button = UIButton(type: .custom)

        button.setImage(UIImage(named: "hide_password_icon"),
                        for: .normal)

        button.setImage(UIImage(named: "show_password_icon"),
                        for: .selected)

        button.addTarget(self,
                         action: #selector(_revealButtonTapped(_:)),
                         for: .primaryActionTriggered)

        return button
    }

    private func _refreshActionButton() {
        actionButton.isEnabled = !(emailTextField.text?.isEmpty ?? true)
            && !(passwordTextField.text?.isEmpty ?? true)
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

    private func _removeNotificationObservers() {
        let nc = NotificationCenter.default

        nc.removeObserver(self,
                          name: UIResponder.keyboardWillChangeFrameNotification,
                          object: nil)
    }

    @objc
    private func _revealButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator,
              let vm = viewModel,
              let revealButton = sender as? UIButton
        else { return }

        let screen = vm.isRegistering ? "signUp" : "signIn"

        mc.providers.analytics.trackUIButtonTapped("reveal",
                                                   screen: screen)

        revealButton.isSelected.toggle()

        passwordTextField.isSecureTextEntry = !revealButton.isSelected
    }

    private func _showActionError(_ error: Error) {
        guard let mc = mainCoordinator,
              let vm = viewModel
        else { return }

        let errorAction = UIAlertAction(title: vm.actionErrorActionTitle,
                                        style: .default,
                                        handler: nil)

        errorAction.accessibilityIdentifier = "alert_action_error_action"

        mc.showAlert(title: vm.actionErrorTitle,
                     message: error.localizedDescription,
                     actions: [errorAction])
    }

    private func _showValidationError(_ error: Error) {
        guard let mc = mainCoordinator,
              let vm = viewModel
        else { return }

        let errorAction = UIAlertAction(title: vm.validationErrorActionTitle,
                                        style: .default,
                                        handler: nil)

        errorAction.accessibilityIdentifier = "alert_validation_error_action"

        mc.showAlert(title: vm.validationErrorTitle,
                     message: error.localizedDescription,
                     actions: [errorAction])
    }

    @objc
    private func _textFieldChanged(_ textField: UITextField) {
        _refreshActionButton()
    }

    // MARK: Overridden BaseViewController Methods

    override public func bindViewModel() {
        guard isViewLoaded,
              let vm = viewModel
        else { return }

        let theme = Theme.default

        actionButton.setTitle(vm.actionTitle,
                              for: .normal)

        emailLabel.text = vm.emailSectionTitle

        emailTextField.attributedPlaceholder = NSAttributedString(string: vm.emailPlaceholder,
                                                                  attributes: [.foregroundColor: theme.colors.deactive])

        passwordLabel.text = vm.passwordSectionTitle

        passwordTextField.attributedPlaceholder = NSAttributedString(string: vm.passwordPlaceholder,
                                                                     attributes: [.foregroundColor: theme.colors.deactive])

        titleLabel.text = vm.screenTitle
    }

    override public func configureSubviews() {
        actionButton.isEnabled = false

        actionButton.setTitle(nil,
                              for: .normal)

        emailLabel.text = nil

        emailTextField.keyboardAppearance = .light
        emailTextField.placeholder = nil
        emailTextField.text = nil

        emailTextField.addTarget(self,
                                 action: #selector(_textFieldChanged(_:)),
                                 for: .editingChanged)

        passwordLabel.text = nil

        let revealButton = _makeRevealButton()

        passwordTextField.isSecureTextEntry = !revealButton.isSelected
        passwordTextField.keyboardAppearance = .light
        passwordTextField.placeholder = nil
        passwordTextField.rightView = revealButton
        passwordTextField.rightViewMode = .always
        passwordTextField.text = nil
        passwordTextField.textContentType = .username   // seems to fix iOS 14 weirdness

        passwordTextField.addTarget(self,
                                    action: #selector(_textFieldChanged(_:)),
                                    for: .editingChanged)

        titleLabel.text = nil

        _configureSpinnerView()
    }

    // MARK: Overridden UIViewController Methods

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        emailTextField.becomeFirstResponder()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        _addNotificationObservers()

        _refreshActionButton()
    }

    override public func viewWillDisappear(_ animated: Bool) {
        _removeNotificationObservers()

        super.viewWillDisappear(animated)
    }
}

// MARK: - UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }

        _refreshActionButton()

        return true
    }
}
