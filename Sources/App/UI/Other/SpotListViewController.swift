import UIKit

public class SpotListViewController: BaseViewController {

    // MARK: Public Instance Properties

    public var viewModel: SpotListViewModel? { didSet { bindViewModel() } }

    // MARK: Private Instance Properties

    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var footerView: UIView!
    @IBOutlet private weak var gridButton: UIButton!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var listButton: UIButton!
    @IBOutlet private weak var profileButton: UIButton!
    @IBOutlet private weak var spotTableView: UITableView!
    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: Private Instance Methods

    @IBAction private func addButtonTapped(_ sender: Any) {
    }

    @IBAction private func gridButtonTapped(_ sender: Any) {
        viewModel?.isFiltered = false

        bindViewModel() // for now…
    }

    @IBAction private func listButtonTapped(_ sender: Any) {
        viewModel?.isFiltered = true

        bindViewModel() // for now…
    }

    @IBAction private func profileButtonTapped(_ sender: Any) {
        guard let vm = viewModel
        else { return }

        coordinator?.showActions([UIAlertAction(title: vm.profileActionTitle,
                                                style: .default) { _ in
            self.coordinator?.showProfile()
        },
        UIAlertAction(title: vm.signOutActionTitle,
                      style: .destructive) { _ in
            self.coordinator?.showWelcome()
        },
        UIAlertAction(title: vm.cancelActionTitle,
                      style: .cancel,
                      handler: nil)])
    }

    // MARK: Overridden BaseViewController Methods

    override public func bindViewModel() {
        super.bindViewModel()

        guard isViewLoaded,
              let vm = viewModel
        else { return }

        titleLabel.text = vm.screenTitle
    }

    // MARK: Overridden UIViewController Methods

    override public func viewDidLoad() {
        super.viewDidLoad()

        addButton.layer.cornerRadius = addButton.frame.height / 2
        addButton.layer.masksToBounds = true
    }
}
