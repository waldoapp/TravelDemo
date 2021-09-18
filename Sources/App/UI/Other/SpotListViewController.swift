import UIKit

public class SpotListViewController: BaseViewController {

    // MARK: Public Instance Properties

    public var viewModel: SpotListViewModel? { didSet { bindViewModel() } }

    // MARK: Public Instance Methods

    public func forceMySpots() {
        guard let vm = viewModel,
              !vm.mySpots
        else { return }

        vm.mySpots = true

        bindViewModel() // for now…

        vm.fetchSpots { [weak self] in
            self?.spots = $0

            self?._refreshUI()
        }
    }

    // MARK: Private Instance Properties

    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var emptyAddButton: UIButton!
    @IBOutlet private weak var emptyMessageLabel: UILabel!
    @IBOutlet private weak var emptyView: UIView!
    @IBOutlet private weak var exploreButton: UIButton!
    @IBOutlet private weak var exploreImageView: UIImageView!
    @IBOutlet private weak var footerView: UIView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var mySpotsButton: UIButton!
    @IBOutlet private weak var mySpotsImageView: UIImageView!
    @IBOutlet private weak var profileButton: UIButton!
    @IBOutlet private weak var spinnerView: SpinnerView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var titleLabel: UILabel!

    private var spots: [SpotCellViewModel] = []

    private var isEmpty: Bool {
        spots.isEmpty && (viewModel?.mySpots ?? false)
    }

    // MARK: Private Instance Methods

    @IBAction private func addButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator
        else { return }

        mc.providers.analytics.trackUIButtonTapped("add",
                                                   screen: "spotList")

        mc.showSpotEdit()
    }

    @IBAction private func emptyAddButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator
        else { return }

        mc.providers.analytics.trackUIButtonTapped("emptyAdd",
                                                   screen: "spotList")

        mc.showSpotEdit()
    }

    @IBAction private func exploreButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator,
              let vm = viewModel,
              vm.mySpots
        else { return }

        mc.providers.analytics.trackUIButtonTapped("explore",
                                                   screen: "spotList")

        vm.mySpots = false

        bindViewModel() // for now…

        vm.fetchSpots { [weak self] in
            self?.spots = $0

            self?._refreshUI()
        }
    }

    @IBAction private func mySpotsButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator,
              let vm = viewModel,
              !vm.mySpots
        else { return }

        mc.providers.analytics.trackUIButtonTapped("mySpots",
                                                   screen: "spotList")

        vm.mySpots = true

        bindViewModel() // for now…

        vm.fetchSpots { [weak self] in
            self?.spots = $0

            self?._refreshUI()
        }
    }

    @IBAction private func profileButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator
        else { return }

        mc.providers.analytics.trackUIButtonTapped("profile",
                                                   screen: "spotList")

        mc.showProfile()
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

    private func _refreshUI() {
        let mySpots = viewModel?.mySpots ?? false

        exploreImageView.isHidden = mySpots
        mySpotsImageView.isHidden = !mySpots

        if isEmpty {
            emptyView.isHidden = false
            tableView.isHidden = true
        } else {
            emptyView.isHidden = true
            tableView.isHidden = false

            tableView.reloadData()
        }
    }

    // MARK: Overridden BaseViewController Methods

    override public func bindViewModel() {
        guard isViewLoaded,
              let vm = viewModel
        else { return }

        emptyAddButton.setTitle(vm.emptyAddTitle,
                                for: .normal)

        emptyMessageLabel.text = vm.emptyMessageText

        titleLabel.text = vm.screenTitle
    }

    override public func configureSubviews() {
        emptyAddButton.setTitle(nil,
                                for: .normal)

        emptyMessageLabel.text = nil

        profileButton.accessibilityIdentifier = "profile_button"

        titleLabel.text = nil

        _refreshUI()
        _configureSpinnerView()
    }

    // MARK: Overridden UIViewController Methods

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        _refreshSpinnerView(true)

        viewModel?.fetchSpots { [weak self] in
            self?._refreshSpinnerView(false)

            self?.spots = $0

            self?._refreshUI()
        }
    }
}

// MARK: - UITableViewDataSource

extension SpotListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = SpotCell.instantiate(from: tableView,
                                              for: indexPath)
        else { return UITableViewCell() }

        cell.viewModel = spots[indexPath.row]

        return cell
    }

    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        spots.count
    }
}

// MARK: - UITableViewDelegate

extension SpotListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
        guard let mc = mainCoordinator
        else { return }

        mc.showSpot(for: spots[indexPath.row])
    }

    public func tableView(_ tableView: UITableView,
                          willDisplay cell: UITableViewCell,
                          forRowAt indexPath: IndexPath) {
        tableView.contentSize.height = (cell.frame.height * CGFloat(spots.count))
            + footerView.frame.height
    }
}
