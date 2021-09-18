import UIKit

public class SpotViewController: BaseViewController {

    // MARK: Public Instance Properties

    public var viewModel: SpotViewModel? { didSet { bindViewModel() } }

    // MARK: Private Instance Properties

    @IBOutlet private weak var authorImageView: UIImageView!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var authorSectionLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var descriptionSectionLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var locationSectionLabel: UILabel!
    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var spinnerView: SpinnerView!
    @IBOutlet private weak var spotImageView: UIImageView!
    @IBOutlet private weak var spotNameLabel: UILabel!

    // MARK: Private Instance Functions

    @IBAction private func backButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator
        else { return }

        mc.providers.analytics.trackUIButtonTapped("back",
                                                   screen: "spot")

        mc.showPrevious()
    }

    @IBAction private func deleteButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator,
              let vm = viewModel,
              vm.isMine
        else { return }

        mc.providers.analytics.trackUIButtonTapped("spot",
                                                   screen: "delete")

        backButton.isEnabled = false
        deleteButton.isEnabled = false

        _refreshSpinnerView(true)

        vm.deleteSpot { [weak self] in
            self?._refreshSpinnerView(false)

            if let error = $0 {
                self?._showDeleteError(error)

                self?.backButton.isEnabled = true
                self?.deleteButton.isEnabled = true
            } else {
                mc.showPrevious()
            }
        }
    }

    @IBAction private func shareButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator,
              let vm = viewModel,
              !vm.isMine
        else { return }

        mc.providers.analytics.trackUIButtonTapped("share",
                                                   screen: "spot")

        mc.showShareSheet(for: vm)
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

    private func _showDeleteError(_ error: Error) {
        guard let mc = mainCoordinator,
              let vm = viewModel
        else { return }

        let errorAction = UIAlertAction(title: vm.deleteErrorActionTitle,
                                        style: .default,
                                        handler: nil)

        errorAction.accessibilityIdentifier = "alert_delete_error_action"

        mc.showAlert(title: vm.deleteErrorTitle,
                     message: error.localizedDescription,
                     actions: [errorAction])
    }

    // MARK: Overridden BaseViewController Methods

    override public func bindViewModel() {
        guard isViewLoaded,
              let vm = viewModel
        else { return }

        authorImageView.image = vm.authorImage ?? UIImage(named: "avatar_fallbacks")

        authorNameLabel.text = vm.authorNameText

        authorSectionLabel.text = vm.authorSectionTitle

        if vm.isMine {
            deleteButton.setTitle(vm.deleteTitle,
                                  for: .normal)
        } else {
            shareButton.setTitle(vm.shareTitle,
                                 for: .normal)
        }

        descriptionSectionLabel.text = vm.descriptionSectionTitle

        descriptionTextView.text = vm.descriptionText

        locationLabel.text = vm.locationText

        locationSectionLabel.text = vm.locationSectionTitle

        spotImageView.image = vm.spotImage

        spotNameLabel.text = vm.spotNameText
    }

    override public func configureSubviews() {
        authorImageView.image = nil
        authorImageView.layer.cornerRadius = authorImageView.frame.height / 2
        authorImageView.layer.masksToBounds = true

        authorNameLabel.text = nil

        authorSectionLabel.text = nil

        deleteButton.isHidden = true

        deleteButton.setTitle(nil,
                              for: .normal)

        descriptionSectionLabel.text = nil

        descriptionTextView.text = nil

        locationLabel.text = nil

        locationSectionLabel.text = nil

        shareButton.isHidden = true

        shareButton.setTitle(nil,
                             for: .normal)

        spotImageView.image = nil

        spotNameLabel.text = nil

        _configureSpinnerView()
    }

    // MARK: Overridden UIViewController Methods

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let vm = viewModel
        else { return }

        if vm.isMine {
            deleteButton.isHidden = false
        } else {
            shareButton.isHidden = false
        }
    }
}
