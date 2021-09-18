import UIKit

public class MainCoordinator: Coordinator {

    // MARK: Public Instance Properties

    public private(set) lazy var providers = ProviderHub(delegate: self)

    // MARK: Public Instance Methods

    @discardableResult
    public func showActionSheet(title: String? = nil,
                                message: String? = nil,
                                actions: [UIAlertAction]) -> Bool {
        let ac = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .actionSheet)

        for action in actions {
            ac.addAction(action)
        }

        navigationController.present(ac,
                                     animated: true) {
            ac.setAccessibilityIdentifiers()
        }

        return true
    }

    @discardableResult
    public func showAlert(title: String?,
                          message: String?,
                          actions: [UIAlertAction]) -> Bool {
        let ac = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)

        for action in actions {
            ac.addAction(action)
        }

        navigationController.present(ac,
                                     animated: true) {
            ac.setAccessibilityIdentifiers()
        }

        return true
    }

    @discardableResult
    public func showDeepLink(_ deepLink: DeepLink) -> Bool {
        switch deepLink.command {
        case let .spot(spotID):
            _showDeepLinkSpot(for: spotID)
        }

        return true
    }

    @discardableResult
    public func showOnboarding(for step: Int = 1) -> Bool {
        guard let vc = OnboardingViewController.instantiate(from: .main)
        else { return false }

        vc.mainCoordinator = self
        vc.viewModel = OnboardingViewModel(step)

        navigationController.pushViewController(vc,
                                                animated: true)

        return true
    }

    @discardableResult
    public func showPrevious(forceMySpots: Bool = false) -> Bool {
        if forceMySpots,
           navigationController.viewControllers.count > 1,
           let vc = navigationController.viewControllers.first as? SpotListViewController {
            vc.forceMySpots()
        }

        navigationController.popViewController(animated: true)

        return true
    }

    @discardableResult
    public func showProfile() -> Bool {
        guard let vc = ProfileViewController.instantiate(from: .main)
        else { return false }

        vc.mainCoordinator = self
        vc.viewModel = ProfileViewModel(client)

        navigationController.pushViewController(vc,
                                                animated: true)

        return true
    }

    @discardableResult
    public func showShareSheet(for spot: SpotViewModel) -> Bool {
        guard let image = spot.spotImage
        else { return false }

        let avc = UIActivityViewController(activityItems: [image],
                                           applicationActivities: nil)

        navigationController.present(avc,
                                     animated: true)

        return true
    }

    @discardableResult
    public func showSignIn() -> Bool {
        guard let vc = SignInViewController.instantiate(from: .main)
        else { return false }

        vc.mainCoordinator = self
        vc.viewModel = SignInViewModel(client,
                                       false)

        navigationController.pushViewController(vc,
                                                animated: true)

        return true
    }

    @discardableResult
    public func showSignUp() -> Bool {
        guard let vc = SignInViewController.instantiate(from: .main)
        else { return false }

        vc.mainCoordinator = self
        vc.viewModel = SignInViewModel(client,
                                       true)

        navigationController.pushViewController(vc,
                                                animated: true)

        return true
    }

    @discardableResult
    public func showSpot(for spotCell: SpotCellViewModel) -> Bool {
        guard let vc = SpotViewController.instantiate(from: .main)
        else { return false }

        vc.mainCoordinator = self
        vc.viewModel = SpotViewModel(spotCell.spot,
                                     client)

        navigationController.pushViewController(vc,
                                                animated: true)

        return true
    }

    @discardableResult
    public func showSpotEdit() -> Bool {
        guard let vc = SpotEditViewController.instantiate(from: .main)
        else { return false }

        vc.mainCoordinator = self
        vc.viewModel = SpotEditViewModel(client)

        navigationController.pushViewController(vc,
                                                animated: true)

        return true
    }

    @discardableResult
    public func showSpotList(mySpots: Bool) -> Bool {
        guard let vc = SpotListViewController.instantiate(from: .main)
        else { return false }

        vc.mainCoordinator = self
        vc.viewModel = SpotListViewModel(mySpots,
                                         client)

        navigationController.setViewControllers([vc],
                                                animated: true)

        return true
    }

    @discardableResult
    public func showWelcome(signingOut: Bool = false) -> Bool {
        guard let vc = WelcomeViewController.instantiate(from: .main)
        else { return false }

        vc.mainCoordinator = self
        vc.viewModel = WelcomeViewModel(signingOut)

        if signingOut,
           let topVC = navigationController.topViewController {
            navigationController.setViewControllers([vc, topVC],
                                                    animated: false)

            navigationController.popViewController(animated: true)
        } else {
            navigationController.setViewControllers([vc],
                                                    animated: true)
        }

        return true
    }

    // MARK: Private Instance Properties

    private lazy var client = TravelSpotClient(authentication: providers.authentication,
                                               storage: providers.storage)

    // MARK: Private Instance Methods

    private func _showDeepLinkSpot(_ spot: Spot) {
        guard providers.authentication.currentUser != nil,
              let slvc = SpotListViewController.instantiate(from: .main),
              let svc = SpotViewController.instantiate(from: .main)
        else { return }

        let svm = SpotViewModel(spot,
                                client)

        slvc.mainCoordinator = self
        slvc.viewModel = SpotListViewModel(svm.isMine,
                                           client)

        svc.mainCoordinator = self
        svc.viewModel = svm

        navigationController.setViewControllers([slvc, svc],
                                                animated: true)
    }

    private func _showDeepLinkSpot(for spotID: String) {
        client.fetchSpot(for: spotID) { [weak self] in
            switch $0 {
            case .failure:
                self?.showSpotList(mySpots: false)

            case let .success(spot):
                self?._showDeepLinkSpot(spot)
            }
        }
    }

    // MARK: Overridden Coordinator Initializers

    override public init(_ navigationController: UINavigationController) {
        super.init(navigationController)

        navigationController.setNavigationBarHidden(true,
                                                    animated: false)
    }

    // MARK: Overridden Coordinator Methods

    override public func start() {
        if providers.authentication.currentUser != nil {
            showSpotList(mySpots: false)
        } else {
            showWelcome()
        }
    }
}

// MARK: - ProviderDelegate

extension MainCoordinator: ProviderDelegate {
    public func dismiss(_ vc: UIViewController) {
        guard navigationController.presentedViewController == vc
        else { return }

        navigationController.dismiss(animated: true)
    }

    public func present(_ vc: UIViewController) {
        navigationController.present(vc,
                                     animated: true)
    }
}
