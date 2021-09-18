import UIKit

public class MainCoordinator: Coordinator {

    // MARK: Public Instance Methods

    @discardableResult
    public func showActions(_ actions: [UIAlertAction]) -> Bool {
        let ac = UIAlertController(title: nil,
                                   message: nil,
                                   preferredStyle: .actionSheet)

        for action in actions {
//            ac.addAction(UIAlertAction(title: action.title,
//                                       style: mapStyle(action.style)) { _ in
//                pq.dismissViewController(ac,
//                                         animated: true,
//                                         completion: action.handler)
//            })

            ac.addAction(action)
        }

        navigationController.present(ac,
                                     animated: true) {
        }

        return true
    }

    @discardableResult
    public func showOnboarding(_ step: Int = 1) -> Bool {
        guard let vc = OnboardingViewController.instantiate(from: .main)
        else { return false }

        vc.coordinator = self
        vc.viewModel = ViewModelFactory.onboarding(step)

        navigationController.pushViewController(vc,
                                                animated: true)

        return true
    }

    @discardableResult
    public func showPrevious() -> Bool {
        navigationController.popViewController(animated: true)

        return true
    }

    @discardableResult
    public func showProfile() -> Bool {
        guard let vc = ProfileViewController.instantiate(from: .main)
        else { return false }

        vc.coordinator = self
        vc.viewModel = ViewModelFactory.profile()

        navigationController.pushViewController(vc,
                                                animated: true)

        return true
    }

    @discardableResult
    public func showSignIn() -> Bool {
        guard let vc = SignInViewController.instantiate(from: .main)
        else { return false }

        vc.coordinator = self
        vc.viewModel = ViewModelFactory.signIn(true)

        navigationController.pushViewController(vc,
                                                animated: true)

        return true
    }

    @discardableResult
    public func showSignUp() -> Bool {
        guard let vc = SignInViewController.instantiate(from: .main)
        else { return false }

        vc.coordinator = self
        vc.viewModel = ViewModelFactory.signIn(false)

        navigationController.pushViewController(vc,
                                                animated: true)

        return true
    }

    @discardableResult
    public func showSpotList() -> Bool {
        guard let vc = SpotListViewController.instantiate(from: .main)
        else { return false }

        vc.coordinator = self
        vc.viewModel = ViewModelFactory.spotList()

        navigationController.pushViewController(vc,
                                                animated: true)

        return true
    }

    @discardableResult
    public func showWelcome() -> Bool {
        guard let vc = WelcomeViewController.instantiate(from: .main)
        else { return false }

        vc.coordinator = self
        vc.viewModel = ViewModelFactory.welcome()

        navigationController.setViewControllers([vc],
                                                animated: true)

        return true
    }

    // MARK: Overridden Coordinator Initializers

    override public init(_ navigationController: UINavigationController) {
        navigationController.setNavigationBarHidden(true,
                                                    animated: false)

        super.init(navigationController)
    }

    // MARK: Overridden Coordinator Methods

    override public func start() {
        showWelcome()
    }
}
