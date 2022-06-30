import UIKit

// swiftlint:disable type_body_length

public class SpotEditViewController: BaseViewController {

    // MARK: Public Instance Properties

    public var viewModel: SpotEditViewModel? { didSet { bindViewModel() } }

    // MARK: Private Instance Properties

    private let textIndent = CGFloat(12)

    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var descriptionPlaceholderLabel: UILabel!
    @IBOutlet private weak var descriptionSectionLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var locationImageView: UIImageView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var locationSectionLabel: UILabel!
    @IBOutlet private weak var spinnerView: SpinnerView!
    @IBOutlet private weak var spotImageSectionView: UIView!
    @IBOutlet private weak var spotImageView: UIImageView!
    @IBOutlet private weak var spotNameSectionLabel: UILabel!
    @IBOutlet private weak var spotNameTextField: UITextField!

    private var location: Location?

    // MARK: Private Instance Functions

    @IBAction private func addButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator,
              let vm = viewModel
        else { return }

        analytics?.trackUIButtonTapped("add",
                                       screen: "spotEdit")

        if let error = vm.validate(image: spotImageView.image,
                                   name: spotNameTextField.text,
                                   description: descriptionTextView.text,
                                   location: location) {
            _showValidationError(error)

            return
        }

        guard let description = descriptionTextView.text,
              let image = spotImageView.image,
              let location = location,
              let name = spotNameTextField.text
        else { return }

        descriptionTextView.resignFirstResponder()

        spotNameTextField.resignFirstResponder()

        addButton.isEnabled = false
        backButton.isEnabled = false

        _refreshSpinnerView(true)

        analytics?.trackActionRequested("add_new_spot",
                                        name: name)

        vm.addNewSpot(image: image,
                      name: name,
                      description: description,
                      location: location) { [weak self] in
            self?._refreshSpinnerView(false)

            if let error = $0 {
                self?.analytics?.trackActionFailed("add_new_spot",
                                                   name: name,
                                                   reason: error.localizedDescription)

                self?._showAddError(error)

                self?.addButton.isEnabled = true
                self?.backButton.isEnabled = true
            } else {
                self?.analytics?.trackActionSucceeded("add_new_spot",
                                                      name: name)

                mc.showPrevious(forceMySpots: true)
            }
        }
    }

    @IBAction private func backButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator
        else { return }

        analytics?.trackUIButtonTapped("back",
                                       screen: "spotEdit")

        mc.showPrevious()
    }

    private func _addGestureRecognizers() {
        let tgr1 = UITapGestureRecognizer(target: self,
                                          action: #selector(_locationLabelTapped(_:)))

        locationLabel.addGestureRecognizer(tgr1)

        let tgr2 = UITapGestureRecognizer(target: self,
                                          action: #selector(_spotImageViewTapped(_:)))

        spotImageView.addGestureRecognizer(tgr2)
    }

    private func _choosePhoto(completion: @escaping (UIImage?) -> Void) {
        guard let pp = mainCoordinator?.providers.photo
        else { return }

        pp.choosePhoto(completion: completion)
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

    private func _fetchLocation(completion: @escaping (Location?) -> Void) {
        guard let lp = mainCoordinator?.providers.location
        else { return }

        lp.requestAccess {
            switch $0 {
            case .failure:
                completion(nil)

            case let .success(access):
                switch access {
                case .allowed:
                    lp.requestLocation {
                        switch $0 {
                        case .failure:
                            completion(nil)

                        case let .success(location):
                            completion(location)
                        }
                    }

                default:
                    completion(nil)
                }
            }
        }
    }

    @objc
    private func _locationLabelTapped(_ sender: UITapGestureRecognizer) {
        _refreshSpinnerView(true)

        _fetchLocation { [weak self] in
            self?._refreshSpinnerView(false)
            self?._refreshLocationLabel($0)
            self?._refreshAddButton()
        }
    }

    private func _makeTextAttributes(with attrs: [NSAttributedString.Key: Any] = [:],
                                     indent: CGFloat? = nil,
                                     color: UIColor? = nil) -> [NSAttributedString.Key: Any] {
        let ps = attrs[.paragraphStyle] as? NSParagraphStyle ?? NSParagraphStyle.default

        guard let mps = ps.mutableCopy() as? NSMutableParagraphStyle
        else { return attrs }

        var mattrs = attrs

        if let indent = indent {
            mps.firstLineHeadIndent = indent
            mps.headIndent = indent

            mattrs[.paragraphStyle] = mps
        }

        if let color = color {
            mattrs[.foregroundColor] = color
        }

        return mattrs
    }

    private func _refreshAddButton() {
        addButton.isEnabled = spotImageView.image != nil
            && !(spotNameTextField.text?.isEmpty ?? true)
            && !(descriptionTextView.text?.isEmpty ?? true)
            && location != nil
    }

    private func _refreshLocationLabel(_ location: Location?) {
        self.location = location

        guard let vm = viewModel
        else { return }

        let attrs = _makeTextAttributes(indent: textIndent)
        let colors = Theme.default.colors

        if let loc = location {
            locationImageView.isHidden = true

            locationLabel.attributedText = NSAttributedString(string: Formatter.formatLocation(loc),
                                                              attributes: attrs)
            locationLabel.textColor = colors.white
        } else {
            locationImageView.isHidden = false

            locationLabel.attributedText = NSAttributedString(string: vm.locationPlaceholder,
                                                              attributes: attrs)
            locationLabel.textColor = colors.primary
        }
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

    private func _showAddError(_ error: Error) {
        guard let mc = mainCoordinator,
              let vm = viewModel
        else { return }

        let errorAction = UIAlertAction(title: vm.addErrorActionTitle,
                                        style: .default,
                                        handler: nil)

        errorAction.accessibilityIdentifier = "alert_add_error_action"

        mc.showAlert(title: vm.addErrorTitle,
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
    private func _spotImageViewTapped(_ sender: UITapGestureRecognizer) {
        _choosePhoto { [weak self] in
            if let image = $0 {
                self?.spotImageView.image = image
                self?._refreshAddButton()
            }
        }
    }

    @objc
    private func _textFieldChanged(_ textField: UITextField) {
        _refreshAddButton()
    }

    // MARK: Overridden BaseViewController Methods

    override public func bindViewModel() {
        guard isViewLoaded,
              let vm = viewModel
        else { return }

        let attrs = _makeTextAttributes(indent: textIndent)
        let theme = Theme.default

        addButton.setTitle(vm.addTitle,
                           for: .normal)

        descriptionPlaceholderLabel.text = vm.descriptionPlaceholder

        descriptionSectionLabel.text = vm.descriptionSectionTitle

        locationLabel.attributedText = NSAttributedString(string: vm.locationPlaceholder,
                                                          attributes: attrs)

        locationSectionLabel.text = vm.locationSectionTitle

        spotNameSectionLabel.text = vm.spotNameSectionTitle

        var phAttrs = attrs

        phAttrs[.foregroundColor] = theme.colors.deactive

        spotNameTextField.attributedPlaceholder = NSAttributedString(string: vm.spotNamePlaceholder,
                                                                     attributes: phAttrs)
        spotNameTextField.defaultTextAttributes = _makeTextAttributes(with: spotNameTextField.defaultTextAttributes,
                                                                      indent: textIndent)
    }

    override public func configureSubviews() {
        addButton.setTitle(nil,
                           for: .normal)

        descriptionPlaceholderLabel.isHidden = false
        descriptionPlaceholderLabel.text = nil

        descriptionSectionLabel.text = nil

        descriptionTextView.keyboardAppearance = .light
        descriptionTextView.layer.cornerRadius = 12
        descriptionTextView.layer.masksToBounds = true
        descriptionTextView.text = nil
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 12,
                                                              left: 8,
                                                              bottom: 12,
                                                              right: 8)

        locationImageView.isHidden = false

        locationLabel.layer.cornerRadius = 12
        locationLabel.layer.masksToBounds = true
        locationLabel.text = nil

        locationSectionLabel.text = nil

        spotImageSectionView.layer.cornerRadius = 16
        spotImageSectionView.layer.masksToBounds = true

        spotNameTextField.keyboardAppearance = .light
        spotNameTextField.layer.cornerRadius = 12
        spotNameTextField.layer.masksToBounds = true
        spotNameTextField.placeholder = nil
        spotNameTextField.text = nil

        spotNameTextField.addTarget(self,
                                    action: #selector(_textFieldChanged(_:)),
                                    for: .editingChanged)

        _addGestureRecognizers()
        _configureSpinnerView()
        _refreshAddButton()
    }
}

// MARK: - UITextFieldDelegate

extension SpotEditViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        descriptionTextView.becomeFirstResponder()

        _refreshAddButton()

        return true
    }
}

// MARK: - UITextViewDelegate

extension SpotEditViewController: UITextViewDelegate {
    public func textView(_ textView: UITextView,
                         shouldChangeTextIn range: NSRange,
                         replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()

            return false
        }

        return true
    }

    public func textViewDidChange(_ textView: UITextView) {
        descriptionPlaceholderLabel.isHidden = !textView.text.isEmpty

        _refreshAddButton()
    }
}
