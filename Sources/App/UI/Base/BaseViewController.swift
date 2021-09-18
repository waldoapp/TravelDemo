import UIKit

public class BaseViewController: UIViewController {

    // MARK: Public Instance Properties

    public weak var mainCoordinator: MainCoordinator?

    public private(set) var isViewVisible = false

    // MARK: Public Instance Methods

    public func bindViewModel() {
    }

    public func configureSubviews() {
    }

    // MARK: Overridden UIViewController Methods

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !isViewVisible {
            isViewVisible = true
        }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        configureSubviews()
        bindViewModel()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //
        // Force view to load before mucking with any subviews:
        //
        loadViewIfNeeded()
    }

    override public func viewWillDisappear(_ animated: Bool) {
        if isViewVisible {
            isViewVisible = false
        }

        super.viewWillDisappear(animated)
    }
}
