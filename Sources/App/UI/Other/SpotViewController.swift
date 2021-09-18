import UIKit

public class SpotViewController: BaseViewController {

    // MARK: Public Instance Properties

    public var viewModel: SpotViewModel? { didSet { bindViewModel() } }

    // MARK: Private Instance Properties

    @IBOutlet private weak var authorHeaderLabel: UILabel!
    @IBOutlet private weak var authorImageView: UIImageView!
    @IBOutlet private weak var authorValueLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var descriptionHeaderLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var locationHeaderLabel: UILabel!
    @IBOutlet private weak var locationValueLabel: UILabel!
    @IBOutlet private weak var shareButton: UIButton!

    // MARK: Overridden BaseViewController Methods

    override public func bindViewModel() {
        super.bindViewModel()

        guard isViewLoaded,
              let vm = viewModel
        else { return }
    }

    // MARK: Overridden UIViewController Methods

    override public func viewDidLoad() {
        super.viewDidLoad()
    }
}
